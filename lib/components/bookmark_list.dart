import 'package:flutter/material.dart';
import 'package:flutter_bookmark/main.dart';
import 'package:flutter_bookmark/models/bookmark.dart';
import 'package:flutter_bookmark/repositories/bookmark_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'bookmark_card.dart';

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
