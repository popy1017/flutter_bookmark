import 'package:flutter/material.dart';
import 'package:flutter_bookmark/main.dart';
import 'package:flutter_bookmark/models/bookmark.dart';
import 'package:flutter_bookmark/repositories/bookmark_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'components/bookmark_list.dart';

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
