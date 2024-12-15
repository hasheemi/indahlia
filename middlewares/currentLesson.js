const db = require("../helpers/db");
async function currentLesson(req, res, next) {
  await db.query(
    `SELECT * FROM student WHERE userId = "${req.session.userId}" AND classId = "${req.params.classid}"`,
    (err, resu, field) => {
      if (+resu[0].currentLesson < +req.params.lessonid) {
        res.redirect(
          `/class/lesson/${req.params.classid}/${resu[0].currentLesson}`
        );
      } else if (req.params.lessonid == 0) {
        res.redirect(`/class/lesson/${req.params.classid}/1`);
      } else {
        next();
      }
    }
  );
}
module.exports = currentLesson;
