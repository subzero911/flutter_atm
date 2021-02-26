import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_atm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('verify app', (WidgetTester tester) async {
    app.main();

    await tester.pump();    // draw the 1st frame

    await tester.enterText(find.byType(TextField), '10');
    await tester.pump(Duration(milliseconds: 500));       // let the user see what's happening

    await tester.tap(find.text('Give out amount'));
    await tester.pump();    // redraw

    // it should show the error message
    expect(find.text('The ATM cannot issue the requested amount!'), findsOneWidget);

    print('cannot give money - passed!');
    await tester.pump(Duration(milliseconds: 500));

    // it should have a certain initial money amount of every type
    expect(find.text('10 X ₽5000'), findsOneWidget);
    expect(find.text('100 X ₽2000'), findsOneWidget);
    expect(find.text('10 X ₽1000'), findsOneWidget);
    expect(find.text('5 X ₽500'), findsOneWidget);
    expect(find.text('100 X ₽200'), findsOneWidget);
    expect(find.text('50 X ₽100'), findsOneWidget);

    print('₽5000 to ₽100 appeared - passed!');
    await tester.pump(Duration(milliseconds: 2000));

    // let's inspect 3600 withdrawal for example
    // ATM should issue 1 x 2000 + 1 x 1000 + 1 x 500 + 1 x 100

    await tester.enterText(find.byType(TextField), '3600');
    await tester.pump(Duration(milliseconds: 500));

    await tester.tap(find.text('Give out amount'));
    await tester.pump();

    expect(find.text('1 X ₽2000'), findsOneWidget);
    expect(find.text('1 X ₽1000'), findsOneWidget);
    expect(find.text('1 X ₽500'), findsOneWidget);
    expect(find.text('1 X ₽100'), findsOneWidget);

    print('Give 3600 - passed!');

    expect(find.text('99 X ₽2000'), findsOneWidget);
    expect(find.text('9 X ₽1000'), findsOneWidget);
    expect(find.text('4 X ₽500'), findsOneWidget);
    expect(find.text('49 X ₽100'), findsOneWidget);

    print('Less amount left - passed!');

    await tester.pump(Duration(seconds: 10));   // time to freely click around
  });
}
