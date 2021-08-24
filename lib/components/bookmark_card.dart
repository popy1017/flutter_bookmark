import 'package:flutter/material.dart';
import 'package:flutter_bookmark/bookmark_view.dart';
import 'package:flutter_bookmark/models/bookmark.dart';

class BookmarkCard extends StatelessWidget {
  BookmarkCard(this._bookmark);

  final Bookmark _bookmark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => BookmarkView(_bookmark)));
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                _bookmark.imageUri.toString(),
                fit: BoxFit.fitWidth,
                width: double.infinity,
                height: 200,
              ),
              ListTile(
                title: Text(_bookmark.title),
                subtitle: Text(
                  _bookmark.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
