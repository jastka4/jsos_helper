import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jsos_helper/ui/components/custom_card.dart';

void main() {
  final CustomCard customCard = CustomCard(
    asideWidgets: <Widget>[Text('asideWidget')],
    rightWidgets: <Widget>[Text('rightWidget'), Text('rightWidget')],
    leftWidgets: <Widget>[Text('leftWidget')],
    color: Colors.red,
  );

  Widget buildTestableWidget(Widget widget) {
    return MediaQuery(data: MediaQueryData(), child: MaterialApp(home: widget));
  }

  testWidgets('CustomCard widget has aside, right and left widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(customCard));

    final asideFinder = find.text('asideWidget');
    final rightFinder = find.text('rightWidget');
    final leftFinder = find.text('leftWidget');

    expect(asideFinder, findsOneWidget);
    expect(rightFinder, findsNWidgets(2));
    expect(leftFinder, findsOneWidget);
  });

  testWidgets('CustomCard widget has a color', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(customCard));

    WidgetPredicate widgetColorPredicate = (Widget widget) =>
        widget is Container &&
        widget.decoration ==
            BoxDecoration(
                gradient: new LinearGradient(
                    stops: [0.02, 0.02],
                    colors: [customCard.color, Colors.white]),
                borderRadius: new BorderRadius.all(const Radius.circular(6.0)));

    expect(find.byWidgetPredicate(widgetColorPredicate), findsOneWidget);
  });
}
