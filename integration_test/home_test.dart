import 'package:flutter/material.dart';
import 'package:flutter_bookmark/components/bookmark_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../test/init.dart';

import 'package:flutter_bookmark/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await initialiseHive();
  });

  testWidgets("Adding a bookmark and delete it.", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final fab = find.byType(FloatingActionButton);
    expect(fab, findsOneWidget);

    await tester.tap(fab);
    await tester.pumpAndSettle();

    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    // TextFieldにURLを入力
    await tester.enterText(textField, 'https://flutter.dev/');
    await tester.pumpAndSettle();

    final ok = find.text('OK');
    expect(ok, findsOneWidget);

    // OKボタンを押して、ブックマークを登録
    await tester.tap(ok);
    await tester.pumpAndSettle();

    // ブックマークが表示されるか確認
    final bookmark = find.byType(BookmarkCard);
    expect(bookmark, findsOneWidget);

    // ブックマークを左にスワイプ
    await tester.fling(bookmark, Offset(-1000, 0), 5000);
    await tester.pumpAndSettle();

    // ブックマークが消えているか確認
    expect(bookmark, findsNothing);
  });
}
