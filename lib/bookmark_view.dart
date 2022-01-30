import 'package:flutter/material.dart';
import 'package:flutter_bookmark/models/bookmark.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookmarkView extends StatelessWidget {
  BookmarkView(this._bookmark);

  final Bookmark _bookmark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_bookmark.title),
      ),
      body: WebView(
        initialUrl: _bookmark.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
