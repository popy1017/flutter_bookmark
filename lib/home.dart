import 'package:flutter/material.dart';
import 'package:flutter_bookmark/components/bookmark_card.dart';
import 'package:flutter_bookmark/models/bookmark.dart';

final Bookmark _sampleBookmark = Bookmark(
  title: 'Flutter - Beautiful native apps in record time',
  description:
      "Flutter SDK is Google's UI toolkit for crafting beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.",
  uri: 'https://flutter.dev/images/flutter-logo-sharing.png',
);

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BookmarkCard(_sampleBookmark),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
