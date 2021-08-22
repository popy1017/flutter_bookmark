import 'package:flutter/material.dart';
import 'package:flutter_bookmark/models/bookmark.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'home.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(BookmarkAdapter());

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
      home: Home(),
    );
  }
}
