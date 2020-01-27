import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jsos_helper/common/color_helper.dart';
import 'package:jsos_helper/models/grade.dart';
import 'package:jsos_helper/repositories/grade_repository.dart';
import 'package:jsos_helper/ui/components/custom_card.dart';
import 'package:jsos_helper/ui/components/loading_indicator.dart';

// TODO - show grades by semester
class GradesScreen extends StatelessWidget {
  final String title;
  final GradeRepository _gradeRepository = GradeRepository();

  GradesScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SizedBox(height: 16.0),
          Expanded(child: _buildGradeList()),
        ],
      ),
    );
  }

  Widget _buildGradeList() {
    final DateFormat formatter = DateFormat("dd.MM.yyyy");

    return FutureBuilder<List<Grade>>(
      future: _gradeRepository.getAllGrades(),
      builder: (BuildContext context, AsyncSnapshot<List<Grade>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length == 0) {
            return Center(
              child: Text('You have no grades'),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Grade grade = snapshot.data[index];
                  return CustomCard(asideWidgets: <Widget>[
                    Text(grade.value.toString()),
                    Text(
                      '${grade.ects} ECTS',
                      style: TextStyle(fontSize: 10),
                    ),
                  ], leftWidgets: <Widget>[
                    Text(
                      grade.className,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      grade.lecturer,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ], rightWidgets: <Widget>[
                    Text(formatter.format(grade.date)),
                    Text(describeEnum(grade.eventType)),
                  ], color: ColorHelper.getEventColor(grade.eventType));
                });
          }
        } else {
          return LoadingIndicator();
        }
      },
    );
  }
}
