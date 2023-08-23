import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/widgets/index.dart'; // Replace with your actual path

void main() {
  testWidgets('WindTile displays the correct compass direction',
      (WidgetTester tester) async {
    // North
    await tester.pumpWidget(
        const MaterialApp(home: WindTile(windSpeed: 10, windDirection: 10)));
    expect(find.text('N'), findsOneWidget);

    // North-East
    await tester.pumpWidget(
        const MaterialApp(home: WindTile(windSpeed: 10, windDirection: 45)));
    expect(find.text('NE'), findsOneWidget);

    // East
    await tester.pumpWidget(
        const MaterialApp(home: WindTile(windSpeed: 10, windDirection: 90)));
    expect(find.text('E'), findsOneWidget);

    // and so on for other directions...
  });

  testWidgets('WindTile displays the correct wind speed',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: WindTile(windSpeed: 5, windDirection: 10)));
    expect(find.text('5 kph'), findsOneWidget);

    await tester.pumpWidget(
        const MaterialApp(home: WindTile(windSpeed: 20, windDirection: 10)));
    expect(find.text('20 kph'), findsOneWidget);
  });

  testWidgets('WindTile renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: WindTile(windSpeed: 5, windDirection: 10)));

    // Check for the circle border
    expect(find.byType(Container),
        findsWidgets); // at least two Containers (outer and circle)
    expect(find.text('N'), findsOneWidget);
    expect(find.text('5 kph'), findsOneWidget);
  });
}
