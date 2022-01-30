import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bookmark/components/bookmark_card.dart';
import 'package:flutter_bookmark/components/bookmark_list.dart';
import 'package:flutter_bookmark/components/text_form_dialog.dart';
import 'package:flutter_bookmark/models/bookmark.dart';
import 'package:flutter_bookmark/repositories/bookmark_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_bookmark/home.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'init.dart';

class MockBox extends Mock implements Box<Bookmark> {}

class MockBookmarkRepository extends Mock implements BookmarkRepository {
  final List<Bookmark> _bookmarks = [
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

  final StreamController<BoxEvent> _streamController =
      StreamController<BoxEvent>();

  @override
  List<Bookmark> get bookmarks => _bookmarks;

  @override
  Stream<BoxEvent> get stream => _streamController.stream;

  @override
  Future<void> create(Bookmark bookmark) async {
    _bookmarks.add(bookmark);

    // Box変更イベントを発火（BoxEventの中身はなんでもよい）
    _streamController.add(BoxEvent(bookmark.id, '', true));
  }
}

void main() {
  final BookmarkRepository _fakeRepository = MockBookmarkRepository();
  late FutureProvider<BookmarkRepository> _fakeRepositoryProvider;

  setUp(() async {
    await initialiseHive();
    _fakeRepositoryProvider = FutureProvider((ref) async {
      return _fakeRepository;
    });
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

  testWidgets('登録されているBookmarkが表示される', (WidgetTester tester) async {
    // NetworkImageがエラーになるのでモック化
    mockNetworkImagesFor(() async {
      await tester.pumpWidget(MaterialApp(
        home: ProviderScope(
          child: Home(),
          overrides: [
            bookmarkRepositoryProvider
                .overrideWithProvider(_fakeRepositoryProvider),
          ],
        ),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump();

      // 厳密に調べる
      expect(
        tester.firstWidget(find.byType(BookmarkCard)),
        isA<BookmarkCard>()
            .having((b) => b.bookmark.id, 'Id', '123')
            .having((b) => b.bookmark.title, 'Title', 'Flutter'),
      );

      // なんとなく調べる
      final Finder bookmark2 = find.text('Famitsu');
      expect(bookmark2, findsOneWidget);

      // 新しいBookmarkを追加
      await _fakeRepository.create(Bookmark(
        id: '789',
        url: 'https://firebase.google.com/',
        title: 'Firebase',
        description: 'Firebase Web site',
        imageUri: 'https://firebase.google.com/images/social.png',
      ));
      await tester.pump();

      // なんとなく調べる
      final Finder bookmark3 = find.text('Firebase');
      expect(bookmark3, findsOneWidget);
    });
  });
}
