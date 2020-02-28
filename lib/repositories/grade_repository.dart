import 'package:jsos_helper/common/connection_status_singleton.dart';
import 'package:jsos_helper/common/university.dart';
import 'package:jsos_helper/dao/grade_dao.dart';
import 'package:jsos_helper/models/grade.dart';
import 'package:jsos_helper/repositories/storage_repository.dart';
import 'package:jsos_helper/services/grade_service.dart';
import 'package:meta/meta.dart';

class GradeRepository {
  GradeDao _gradeDao = GradeDao();
  GradeService _gradeService = GradeService();
  final StorageRepository storageRepository;

  GradeRepository({@required this.storageRepository});

  Future<List<Grade>> getAllGrades() async {
    String username = await storageRepository.getUsername();
    University university = await storageRepository.getUniversity();
    if (await ConnectionStatusSingleton.getInstance().checkConnection()) {
      return _gradeService.fetchGrades(username, university);
    } else {
      return _gradeDao.getAllGrades();
    }
  }

  Future<List<Grade>> getGradesBySemester(int semester) =>
      _gradeDao.getGradesBySemester(semester);
}
