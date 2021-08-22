import 'package:flutter/material.dart';
import 'package:flutter_bookmark/components/bookmark_card.dart';
import 'package:flutter_bookmark/main.dart';
import 'package:flutter_bookmark/models/bookmark.dart';
import 'package:flutter_bookmark/repositories/bookmark_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

Bookmark get _sampleBookmark => Bookmark(
      id: Uuid().v4(),
      title: 'Flutter - Beautiful native apps in record time',
      description:
          "Flutter SDK is Google's UI toolkit for crafting beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.",
      imageUri: 'https://flutter.dev/images/flutter-logo-sharing.png',
    );

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: BookmarkList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          ref
              .read<BookmarkRepository>(bookmarkRepository)
              .create(_sampleBookmark);
        },
      ),
    );
  }
}

class BookmarkList extends ConsumerWidget {
  const BookmarkList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BookmarkRepository _bookmarkRepository =
        ref.read<BookmarkRepository>(bookmarkRepository);
    return ValueListenableBuilder<Box<Bookmark>>(
      valueListenable: _bookmarkRepository.box.listenable(),
      builder: (BuildContext context, _, __) {
        final List<Bookmark> _bookmarks = _bookmarkRepository.bookmarks;

        if (_bookmarks.isEmpty) {
          return Center(
            child: Text('No bookmarks...'),
          );
        }

        return ListView.builder(
          itemBuilder: (_, int index) {
            return Dismissible(
              key: Key(_bookmarks[index].id),
              child: BookmarkCard(_bookmarks[index]),
              onDismissed: (DismissDirection direction) async {
                print(_bookmarks[index].id);
                await _bookmarkRepository.delete(_bookmarks[index]);
              },
            );
          },
          itemCount: _bookmarks.length,
        );
      },
    );
  }
}
