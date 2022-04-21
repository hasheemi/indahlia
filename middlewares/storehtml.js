const bucket = require("../helpers/bucket");

function storehtml(req, res, next) {
  let str = req.body.myquil;
  let name = `${req.body.slug}-${req.body.nom}-${req.body.date}.txt`;
  bucket.createObject(name, Buffer.from(str), (err) => {
    if (err) {
      res.redirect("/sensei/dashboard");
      console.log("yu");
    } else {
      req.body.quil = `/cdn/${name}`;
      next();
    }
  });
}
module.exports = storehtml;
