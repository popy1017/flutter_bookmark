import 'package:flutter/material.dart';
import 'package:flutter_bookmark/models/bookmark.dart';
import 'package:flutter_bookmark/repositories/bookmark_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'home.dart';

late final bookmarkRepository;

void main() async {
  await Hive.initFlutter();
  await _initBox();

  runApp(MyApp());
}

Future<void> _initBox() async {
  Hive.registerAdapter(BookmarkAdapter());
  final Box<Bookmark> _box = await Hive.openBox('bookmark');
  bookmarkRepository = Provider((ref) => BookmarkRepository(_box));
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
