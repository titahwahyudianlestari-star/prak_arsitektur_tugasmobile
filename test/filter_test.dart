import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prak_arsitektur_tugas/main.dart';

void main() {
  for (final mode in ['MVC', 'MVVM']) {
    testWidgets('$mode memfilter tugas belum selesai',
        (tester) async {
      await tester.pumpWidget(const AplikasiTugas());

      await tester.tap(find.text('Buka $mode'));
      await tester.pumpAndSettle();

      final input = find.byKey(const ValueKey('judul-tugas'));
      final tambah = find.text('Tambah tugas');

      // Tambahkan dua tugas.
      await tester.enterText(input, 'Rancang UI Flutter');
      await tester.tap(tambah);
      await tester.pumpAndSettle();

      await tester.enterText(input, 'Catat hasil pengujian');
      await tester.tap(tambah);
      await tester.pumpAndSettle();

      // Centang tugas pertama.
      await tester.tap(
        find.widgetWithText(
          CheckboxListTile,
          'Rancang UI Flutter',
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('1 dari 2 selesai'), findsOneWidget);

      // Aktifkan filter.
      await tester.tap(
        find.byKey(const ValueKey('filter-belum-selesai')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Rancang UI Flutter'), findsNothing);
      expect(find.text('Catat hasil pengujian'), findsOneWidget);
      expect(find.text('1 dari 2 selesai'), findsOneWidget);

      // Matikan filter.
      await tester.tap(
        find.byKey(const ValueKey('filter-belum-selesai')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Rancang UI Flutter'), findsOneWidget);
      expect(find.text('Catat hasil pengujian'), findsOneWidget);
      expect(find.text('1 dari 2 selesai'), findsOneWidget);

      // Aktifkan filter lagi dan selesaikan tugas kedua.
      await tester.tap(
        find.byKey(const ValueKey('filter-belum-selesai')),
      );
      await tester.pumpAndSettle();

      await tester.tap(
        find.widgetWithText(
          CheckboxListTile,
          'Catat hasil pengujian',
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('Tidak ada tugas yang belum selesai.'),
        findsOneWidget,
      );
      expect(find.text('2 dari 2 selesai'), findsOneWidget);
    });
  }
}