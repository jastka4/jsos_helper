import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jsos_helper/common/event_type_helper.dart';
import 'package:jsos_helper/models/grade.dart';
import 'package:jsos_helper/repositories/grade_repository.dart';
import 'package:jsos_helper/ui/components/custom_card.dart';
import 'package:jsos_helper/ui/components/loading_indicator.dart';

// TODO - show grades by semester
class GradesScreen extends StatefulWidget {
  final String title;

  GradesScreen({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  GradeRepository _gradeRepository = GradeRepository();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const SizedBox(height: 8.0),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  Widget _buildEventList() {
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
                  return CustomCard(leftWidgets: <Widget>[
                    Text(grade.ects.toString()),
                    Text('ECTS'),
                  ], rightLeftWidgets: <Widget>[
                    Text(grade.className),
                    Text(grade.lecturer),
                  ], rightRightWidgets: <Widget>[
                    Text(grade.classroom),
                    Text(describeEnum(grade.eventType)),
                  ], color: EventTypeHelper.getColor(grade.eventType));
                });
          }
        } else {
          return LoadingIndicator();
        }
      },
    );
  }
}
