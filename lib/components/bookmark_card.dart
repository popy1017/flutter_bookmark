import 'package:flutter/material.dart';
import 'package:flutter_bookmark/bookmark_view.dart';
import 'package:flutter_bookmark/models/bookmark.dart';

class BookmarkCard extends StatelessWidget {
  BookmarkCard(this.bookmark);

  final Bookmark bookmark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => BookmarkView(bookmark)));
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
                bookmark.imageUri.toString(),
                fit: BoxFit.fitWidth,
                width: double.infinity,
                height: 200,
              ),
              ListTile(
                title: Text(bookmark.title),
                subtitle: Text(
                  bookmark.description,
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
