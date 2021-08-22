import 'package:flutter/material.dart';
import 'package:flutter_bookmark/models/bookmark.dart';

class BookmarkCard extends StatelessWidget {
  BookmarkCard(this.bookmark);

  final Bookmark bookmark;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(bookmark.imageUri.toString()),
            ListTile(
              title: Text(bookmark.title),
              subtitle: Text(bookmark.description),
            ),
          ],
        ),
      ),
    );
  }
}