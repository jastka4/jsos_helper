import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final List<Widget> leftWidgets;
  final List<Widget> rightRightWidgets;
  final List<Widget> rightLeftWidgets;
  final Color color;

  CustomCard({
    @required this.leftWidgets,
    @required this.rightRightWidgets,
    @required this.rightLeftWidgets,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              children: leftWidgets,
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      stops: [0.02, 0.02], colors: [color, Colors.white]),
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(6.0))),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: rightLeftWidgets,
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: rightRightWidgets,
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
