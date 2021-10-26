import 'package:flutter/material.dart';
import 'package:flutter_bookmark/components/text_form_dialog.dart';
import 'package:flutter_bookmark/models/bookmark.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_bookmark/home.dart';

import 'init.dart';

class MockBox extends Mock implements Box<Bookmark> {}

void main() {
  setUp(() async {
    await initialiseHive();
  });

  testWidgets('FloatingActionButtonをタップすると、TextFormDialogが表示される。',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: ProviderScope(child: Home())));

    final Finder fab = find.byType(FloatingActionButton);
    expect(fab, findsOneWidget);

    expect(find.byType(TextFormDialog), findsNothing);

    await tester.tap(fab);
    await tester.pump();

    expect(find.byType(TextFormDialog), findsOneWidget);
  });

  testWidgets('データがない場合は、No bookmarks...と表示される', (widgetTester) async {});
}
