import 'package:flutter_bookmark/models/bookmark.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookmarkRepository {
  BookmarkRepository(this._box);

  final Box<Bookmark> _box;

  Future<int> create(Bookmark bookmark) async {
    return _box.add(bookmark);
  }

  Future<Bookmark?> read(int id) async {
    return _box.getAt(id);
  }

  Future<void> update(int id, Bookmark bookmark) async {
    return _box.putAt(id, bookmark);
  }

  Future<void> delete(int id) async {
    return _box.deleteAt(id);
  }
}
