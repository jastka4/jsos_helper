import 'package:jsos_helper/common/db_provider.dart';
import 'package:jsos_helper/models/grade.dart';

class GradeDao {
  Future<List<Grade>> getAllGrades() async {
    final db = await DBProvider.db.database;
    var res = await db.query('grade');
    List<Grade> list =
        res.isNotEmpty ? res.map((c) => Grade.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Grade>> getGradesBySemester(int semester) async {
    final db = await DBProvider.db.database;
    var res =
        await db.query('grade', where: 'semester = ?', whereArgs: [semester]);
    List<Grade> list =
        res.isNotEmpty ? res.map((c) => Grade.fromMap(c)).toList() : [];
    return list;
  }
}
