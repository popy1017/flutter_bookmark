import 'package:flutter_bookmark/models/bookmark.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookmarkRepository {
  BookmarkRepository(this._box);

  final Box<Bookmark> _box;

  Box<Bookmark> get box => _box;

  List<Bookmark> get bookmarks => _box.values.toList();

  Future<void> create(Bookmark bookmark) async {
    return _box.put(bookmark.id, bookmark);
  }

  Future<Bookmark?> read(String id) async {
    return _box.get(id);
  }

  Future<void> update(Bookmark bookmark) async {
    return _box.put(bookmark.id, bookmark);
  }

  Future<void> delete(Bookmark bookmark) async {
    return _box.delete(bookmark.id);
  }
}
