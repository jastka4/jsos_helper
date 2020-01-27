import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final List<Widget> asideWidgets;
  final List<Widget> rightWidgets;
  final List<Widget> leftWidgets;
  final Color color;

  CustomCard({
    @required this.asideWidgets,
    @required this.rightWidgets,
    @required this.leftWidgets,
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
              children: asideWidgets,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: leftWidgets,
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: rightWidgets,
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
