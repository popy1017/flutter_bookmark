import 'dart:io';

import 'package:hive/hive.dart';

Future<void> initialiseHive() async {
  final String path = Directory.current.path;
  Hive.init(path);
  Hive.deleteFromDisk(); // 常に空の状態で開始する
}
