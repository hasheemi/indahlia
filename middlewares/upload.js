// const bucket = require("../helpers/bucket");
// const sharp = require("sharp");

// function upload(req, res, next) {
//   if (!req.files) next();
//   else {
//     const file = req.files.photo;
//     const type = file.name.split(".")[1];
//     const name = `${req.body.slug}-${req.body.date}.${type}`;
//     sharp(file.data)
//       .webp({ quality: 20 })
//       .toBuffer()
//       .then((data) => {
//         bucket.createObject(name, data, (err) => {
//           if (err) {
//             console.log(err);
//             res.render("dashboard-add.ejs", {
//               err: "failed to upload your image",
//             });
//           } else {
//             req.body.img = `/cdn/${name}`;
//             next();
//           }
//         });
//       });
//   }
// }

// module.exports = upload;
const bucket = require("../helpers/bucket");

function upload(req, res, next) {
  if (!req.files || Object.keys(req.files).length === 0) {
    next();
  } else {
    const fileKeys = Object.keys(req.files); // Ambil semua key input file
    const uploadedFiles = [];

    fileKeys.forEach((key) => {
      const file = req.files[key];
      const type = file.name.split(".").pop(); // Ekstensi file
      const name = `${req.body.slug || "file"}-${key}-${req.body.nom}-${
        req.body.date || Date.now()
      }.${type}`;

      bucket.createObject(name, file.data, (err) => {
        if (err) {
          console.error(err);
          res.render(`${req.body.render}.ejs`, {
            err: "Failed to upload one or more files",
          });
          console.log("uyio");
        } else {
          uploadedFiles.push(`/cdn/${name}`);
          // Simpan path file di dalam req.body
          req.body[key] = `/cdn/${name}`;

          // Jika semua file telah diproses
          if (uploadedFiles.length === fileKeys.length) {
            next();
          }
        }
      });
    });
  }
}

module.exports = upload;
