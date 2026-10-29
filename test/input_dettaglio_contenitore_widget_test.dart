import 'package:cibo/constants/app_constants.dart';
import 'package:cibo/widgets/input_dettaglio_contenitore_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('screen readers read the label as part of the field', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: appDesignSize,
        builder: (_, _) => MaterialApp(
          home: Scaffold(
            body: InputDettaglioContenitoreWidget(
              label: 'Peso',
              controller: TextEditingController(),
            ),
          ),
        ),
      ),
    );

    expect(tester.getSemantics(find.byType(TextField)).label, 'Peso');
    expect(find.bySemanticsLabel('Peso'), findsOneWidget);
    semantics.dispose();
  });
}
