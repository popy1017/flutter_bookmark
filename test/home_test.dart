import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bookmark/components/text_form_dialog.dart';
import 'package:flutter_bookmark/models/bookmark.dart';
import 'package:flutter_bookmark/repositories/bookmark_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_bookmark/home.dart';

import 'init.dart';

class MockBox extends Mock implements Box<Bookmark> {}

class MockBookmarkRepository extends Mock implements BookmarkRepository {
  @override
  List<Bookmark> get bookmarks => [
        Bookmark(
          id: '123',
          url: 'https://flutter.dev/',
          title: 'Flutter',
          description: 'Flutter web site',
          imageUri:
              'https://storage.googleapis.com/cms-storage-bucket/70760bf1e88b184bb1bc.png',
        ),
        Bookmark(
          id: '456',
          url: 'https://www.famitsu.com/news/202201/28249315.html',
          title: 'Famitsu',
          description: 'Famitsu web site',
          imageUri:
              'https://www.famitsu.com/images/000/249/315/z_61f265395b2da.jpg',
        )
      ];

  @override
  // TODO: implement stream
  Stream<BoxEvent> get stream => StreamController<BoxEvent>().stream;

  add() {}
}

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
