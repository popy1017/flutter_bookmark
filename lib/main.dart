import 'package:flutter/material.dart';
import 'package:flutter_bookmark/models/bookmark.dart';
import 'package:flutter_bookmark/repositories/bookmark_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'home.dart';

bool _initted = false;

final bookmarkRepository = FutureProvider<BookmarkRepository>((ref) async {
  if (!_initted) {
    await Hive.initFlutter();
  }
  Hive.registerAdapter(BookmarkAdapter());
  final Box<Bookmark> _box = await Hive.openBox('bookmark');
  return BookmarkRepository(_box);
});

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ProviderScope(child: Home()),
    );
  }
}
