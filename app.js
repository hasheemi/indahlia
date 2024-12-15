//module and constant
const express = require("express");
const bodyParser = require("body-parser");
const session = require("express-session");
const path = require("path");
// import fetch from "node-fetch";
const fetch = require("node-fetch-commonjs");
const request = require("request");
const fileUpload = require("express-fileupload");
require("dotenv").config();
const { google } = require("googleapis");
const cors = require("cors");
const { createProxyMiddleware } = require("http-proxy-middleware");
const app = express();
const port = 3024;

const db = require("./helpers/db");
const { crypt, decrypt } = require("./helpers/crypto");
const upload = require("./middlewares/upload");
const bucket = require("./helpers/bucket");
const storetext = require("./middlewares/storetext");
const getCoor = require("./middlewares/coordinat");
const masterAuth = require("./middlewares/masterAuth");
const storehtml = require("./middlewares/storehtml");
const proxy = createProxyMiddleware({
  router: (req) => new URL(req.path.substring(7)),
  pathRewrite: (path, req) => new URL(req.path.substring(7)).pathname,
  changeOrigin: true,
  logger: console,
});
//use
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.json());
app.use(fileUpload());
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");
app.use(express.static(path.join(__dirname, "public")));
app.use(
  session({
    secret: "12alvin44jawir788jomok",
    saveUninitialized: true,
    expires: new Date(Date.now() + 1000 * 3600),
    resave: true,
  })
);
app.use(function (req, res, next) {
  res.locals = req.session;
  next();
});

const authClient = new google.auth.OAuth2(
  process.env.GOOGLE_CLIENT_ID,
  process.env.GOOGLE_CLIENT_SECRET,
  "http://localhost:3024/auth/google/callback"
);
const scopes = [
  "https://www.googleapis.com/auth/userinfo.email",
  "https://www.googleapis.com/auth/userinfo.profile",
];
const authUrl = authClient.generateAuthUrl({
  access_type: "offline",
  scope: scopes,
  include_granted_scopes: true,
});
//route
app.get("/", (req, res) => {
  res.render("index");
});
app.get("/login", (req, res) => {
  res.render("login", { isLogin: req.session.isLogin });
});
app.get("/blog", async (req, res) => {
  await db.query(`SELECT * FROM blog`, (err, resu, field) => {
    if (err) {
      res.redirect("/");
    } else {
      res.render("blog", { post: resu });
    }
  });
});
app.get("/maps", async (req, res) => {
  await db.query(`SELECT * FROM place`, (err, resu, field) => {
    if (err) {
      res.redirect("/");
    } else {
      res.render("maps", { place: resu });
    }
  });
});
app.get("/class", (req, res) => {
  res.render("class.ejs");
});
app.get("/blog/post/:slug&:id", async (req, res) => {
  await db.query(
    `SELECT * FROM blog WHERE slug = "${req.params.slug}" AND id = ${req.params.id}`,
    (err, resu, field) => {
      if (err || resu.length == 0) {
        res.redirect("/");
      } else {
        res.render("post", { data: resu });
      }
    }
  );
});
app.get("/maps/place/:id", async (req, res) => {
  await db.query(
    `SELECT * FROM place WHERE id = ${req.params.id}`,
    (err, resu, field) => {
      if (err || resu.length == 0) {
        res.redirect("/");
      } else {
        res.json(resu);
      }
    }
  );
});
app.get("/class/detail/:id", async (req, res) => {
  await db.query(
    `SELECT * FROM class WHERE classId = ${req.params.id}`,
    async (err, resu, field) => {
      if (err || resu.length == 0) {
        res.redirect("/");
      } else {
        const responsetxt = await fetch(
          "http://localhost:3024" + resu[0].syllabus
        );
        const bodytxt = await responsetxt.text();

        res.render("class-detail.ejs", {
          data: resu[0],
          body: bodytxt,
        });
      }
    }
  );
});
app.get("/class/join/:classid", async (req, res) => {
  if (req.session.isLogin) {
    console.log(req.params.classid);
    console.log(req.session.joined);
    console.log(req.session.joined.includes(+req.params.classid));
    if (!req.session.joined.includes(req.params.classid)) {
      console.log("jjkk");
      // const query = `INSERT INTO student (userId, name, email, classId) VALUES (?, ?, ?, ?)`;
      // await db.query(
      //   query,
      //   [
      //     req.session.userId,
      //     req.session.name,
      //     req.session.email,
      //     req.params.classid,
      //   ],
      //   (error, results) => {
      //     if (error) {
      //       console.error("Error inserting data:", error.message);
      //       return;
      //     }
      //     console.log("Data inserted successfully with ID:", results.insertId);
      //     res.redirect(`/class/lesson/${req.params.classid}/1`);
      //   }
      // );
    } else {
      res.redirect(`/class/lesson/${req.params.classid}/1`);
    }
  } else {
    res.redirect("/login");
  }
});
app.get("/class/lesson/:classid/:lessonid", async (req, res) => {
  await db.query(
    `SELECT * FROM lesson WHERE classId = ${req.params.classid} AND lessonId = ${req.params.lessonid} `,
    async (err, resu, field) => {
      if (err || resu.length == 0) {
        res.redirect("/");
      } else {
        const responsetxt = await fetch(
          "http://localhost:3024" + resu[0].material
        );
        const bodytxt = await responsetxt.text();

        res.render("class-lesson.ejs", {
          data: resu[0],
          body: bodytxt,
        });
      }
    }
  );
});
const runQuery = (query, params) => {
  return new Promise((resolve, reject) => {
    db.query(query, params, (err, results) => {
      if (err) return reject(err);
      resolve(results);
    });
  });
};

app.get("/dashboard", async (req, res) => {
  if (req.session.isLogin == true) {
    try {
      console.log(req.session);

      // Query database menggunakan Promise
      const resu = await runQuery(`SELECT * FROM user WHERE email = ?`, [
        req.session.email,
      ]);
      req.session.userId = resu[0].id;
      const resu2 = await runQuery(`SELECT * FROM student WHERE email = ?`, [
        req.session.email,
      ]);
      req.session.joined =
        resu2.length > 0 ? resu2.map((row) => row.classId) : [];

      // Render dashboard
      res.render("dashboard", { name: req.session.name });
    } catch (err) {
      console.error(err);
      res.redirect("/login");
    }
  } else {
    res.redirect("/login");
  }
});

app.get("/dashboard/add", async (req, res) => {
  if (req.session.isLogin == true) {
    res.render("dashboard-add", {
      name: req.session.name,
      email: req.session.email,
    });
  } else {
    res.redirect("/login");
  }
});
app.get("/dashboard/write", (req, res) => {
  if (req.session.isLogin == true) {
    res.render("dashboard-write", {
      name: req.session.name,
      email: req.session.email,
    });
  } else {
    res.redirect("/login");
  }
});
// app.get("/maps", (req, res) => {
//   res.render("maps");
// });
app.post("/add/place", upload, getCoor, async (req, res) => {
  let data = req.body;
  await db.query(
    `INSERT INTO place (userId,nama,deskripsi,prov,kab,jenis,kondisi,notel,link,koordinat,img,timestamp,email) VALUES ("${data.username}","${data.title}","${data.deskripsi}","${data.provinsi}","${data.kabupaten}","${data.fungsi}","${data.lingkungan}","${data.notel}","${data.link}","${data.koordinat}","${data.img}","${data.date}","${data.email}")`,
    function (err, resu, field) {
      if (err) {
        console.log(err);
        res.redirect("/dashboard/add");
      } else {
        res.redirect("/dashboard");
      }
    }
  );
});
app.post("/add/blog", upload, storetext, async (req, res) => {
  let data = req.body;
  await db.query(
    `INSERT INTO blog (userId,judul,slug,isi,img,timestamp,email,cuplikan) VALUES ("${data.username}","${data.title}","${data.slug}","${data.url}","${data.img}","${data.date}","${data.email}","${data.cuplikan}")`,
    function (err, resu, field) {
      if (err) {
        console.log(err);
        res.redirect("/dashboard/write");
      } else {
        res.redirect("/dashboard");
      }
    }
  );
});

app.get("/sensei/login", (req, res) => {
  res.render("sensei/login");
});
app.post("/sensei/login", (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res
      .status(400)
      .json({ message: "Username dan password harus diisi." });
  }
  const query = "SELECT * FROM sensei WHERE username = ? AND password = ?";
  db.query(query, [username, crypt(password)], (err, results) => {
    if (err) {
      console.error("Error dalam query:", err);
      return res
        .status(500)
        .json({ message: "Terjadi kesalahan pada server." });
    }

    if (results.length > 0) {
      // res.status(200).json({ message: "Login berhasil.", user: results[0] });
      const { id, name, email } = results[0];
      // req.session.username = username;
      // req.session.password = password;
      // req.session.uid = id;
      // req.session.name = name;
      // req.session.email = email;
      req.session.user = {
        uid: id,
        name: name,
        username: username,
        email: email,
      };

      req.session.isSensei = true;

      res.redirect("/sensei/dashboard");
    } else {
      res.status(401).json({ message: "Username atau password salah." });
    }
  });
});

app.get("/sensei/dashboard", (req, res) => {
  if (req.session.isSensei) {
    res.render("sensei/dashboard.ejs");
  } else {
    res.redirect("/");
  }
});

app.get("/sensei/dashboard/add-class", (req, res) => {
  res.render("sensei/add-class.ejs", {
    user: req.session.user,
  });
});
app.get("/sensei/dashboard/:classid/add-lesson", (req, res) => {
  res.render("sensei/add-lesson.ejs", {
    user: req.session.user,
    classid: req.params.classid,
  });
});
app.get("/sensei/dashboard/all-class", async (req, res) => {
  let query = `SELECT * FROM class WHERE teacherId = ${req.session.user.uid}`;
  await db.query(query, (err, resu) => {
    if (err) {
      res.redirect("/sensei/dashboard");
    } else {
      res.json({ res: resu });
    }
  });
});
app.post("/sensei/dashboard/add-class", storehtml, upload, (req, res) => {
  console.log("kkjk");
  const { uid, name, title, quil, banner, thumb, slug } = req.body;
  const insertQuery = `
    INSERT INTO class (teacherId, name, title, slug, syllabus, banner, thumbnail) 
    VALUES (?, ?, ?, ?, ?, ?, ?)
  `;
  const values = [uid, name, title, slug, quil, banner, thumb];
  db.query(insertQuery, values, (err, resu) => {
    if (err) {
      res.render("sensei/add-class.ejs");
    } else {
      res.redirect("/sensei/dashboard");
    }
  });
});
app.post(
  "/sensei/dashboard/:classid/add-lesson",
  storehtml,
  upload,
  (req, res) => {
    const { title, thumb, youtube, quiz, quil } = req.body;

    // Query untuk insert data
    const query = `
        INSERT INTO lesson (classId,className, title, thumbnail, youtubeUrl, quiz, material)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    `;

    const values = [
      req.params.classid,
      "ii",
      title,
      thumb,
      youtube,
      quiz,
      quil,
    ];

    db.query(query, values, (err, result) => {
      if (err) {
        console.error("Error inserting data:", err);
        res.status(500).json({ error: "Failed to insert data" });
      } else {
        res.render("sensei/add-lesson.ejs", {
          classid: req.params.classid,
          user: req.session.user,
        });
      }
    });
  }
);
app.get("/master/login", (req, res) => {
  res.render("master/login.ejs");
});
app.post("/master/access", masterAuth, (req, res) => {
  req.session.isMaster = true;
  res.redirect("/master/control");
});
app.get("/master/control", (req, res) => {
  if (req.session.isMaster) {
    res.render("master/dashboard.ejs");
  } else {
    res.redirect("/");
  }
});
app.get("/master/control/add-sensei", (req, res) => {
  if (req.session.isMaster) {
    res.render("master/add-sensei.ejs");
  } else {
    res.redirect("/");
  }
});
app.post("/master/control/add-sensei", async (req, res) => {
  let data = req.body;
  await db.query(
    `INSERT INTO sensei (username, email, name, password)
    VALUES ('${data.username}', '${data.email}', '${data.name}', '${crypt(
      data.password
    )}');
    `,
    function (err, resu, field) {
      if (err) {
        console.log(err);
        res.redirect("/master/control");
      } else {
        res.redirect("/master/control");
      }
    }
  );
});
app.get("/auth/google", (req, res) => {
  res.redirect(authUrl);
});
app.get("/auth/google/callback", async (req, res) => {
  const { code } = req.query;
  const { tokens } = await authClient.getToken(code);
  authClient.setCredentials(tokens);
  const oauth2 = google.oauth2({
    auth: authClient,
    version: "v2",
  });
  const { data } = await oauth2.userinfo.get();
  await db.query(
    `INSERT INTO user (name,email,profile) VALUES ("${data.given_name} ${data.family_name}","${data.email}","${data.picture}")`,
    function (err, resu, field) {
      if (err) {
        if (err.errno == 1062) {
          req.session.isLogin = true;
          req.session.name = data.given_name;
          req.session.email = data.email;
          res.redirect("/dashboard");
        } else {
          res.status(500).send("errrooror");
        }
      } else {
        req.session.isLogin = true;
        req.session.name = data.given_name;
        req.session.email = data.email;
        res.redirect("/dashboard");
      }
    }
  );
});
app.get("/auth/google/logout", (req, res) => {
  if (authClient.credentials.access_token !== undefined) {
    authClient.revokeCredentials();
  }
  req.session.destroy();
  res.redirect("/");
});
app.get("/proxy/*", proxy, (req, res) => {
  res.send("hello");
});
app.get("/cdn/:file", (req, res) => {
  bucket.readObject(req.params.file, async (err, data) => {
    if (err) res.status(404).send("file not found");
    res.type(req.params.file.split(".")[1]);
    res.send(data.buffer);
  });
});
//start
app.listen(port, () => {
  console.log(`Server berjalan di http://localhost:${port}`);
});
