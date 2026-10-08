import 'package:flutter_test/flutter_test.dart';
import 'package:binacare/main.dart';

void main() {
  testWidgets('BinaCare tampil', (WidgetTester tester) async {
    await tester.pumpWidget(const BinaCareApp());

    expect(find.text('BinaCare'), findsOneWidget);
    expect(find.text('Layanan Konseling Siswa'), findsOneWidget);
    expect(find.text('Masuk'), findsOneWidget);
  });
}