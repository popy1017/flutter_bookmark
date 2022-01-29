import 'package:flutter_bookmark/models/bookmark.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookmarkRepository {
  late Box<Bookmark> _box;

  Box<Bookmark> get box => _box;
  List<Bookmark> get bookmarks => _box.values.toList();

  static Future<BookmarkRepository> open() async {
    final repos = BookmarkRepository();
    await repos._initHive();
    return repos;
  }

  Future<BookmarkRepository> _initHive() async {
    Hive.registerAdapter(BookmarkAdapter());
    _box = await Hive.openBox('bookmark');
    return this;
  }

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
