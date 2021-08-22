import 'package:hive/hive.dart';

part 'bookmark.g.dart';

@HiveType(typeId: 0)
class Bookmark {
  Bookmark({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUri,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String imageUri;
}
