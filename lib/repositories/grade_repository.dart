import 'package:jsos_helper/dao/grade_dao.dart';
import 'package:jsos_helper/models/grade.dart';

class GradeRepository {
  GradeDao _gradeDao = GradeDao();

  Future<List<Grade>> getAllGrades() => _gradeDao.getAllGrades();

  Future<List<Grade>> getGradesBySemester(semester) =>
      _gradeDao.getGradesBySemester(semester);
}
