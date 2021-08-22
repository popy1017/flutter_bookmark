import 'package:hive/hive.dart';

part 'bookmark.g.dart';

@HiveType(typeId: 0)
class Bookmark {
  Bookmark({
    required this.title,
    required this.description,
    required String uri,
  }) : imageUri = Uri.parse(uri);

  Bookmark.fromHive({
    required this.title,
    required this.description,
    required this.imageUri,
  });

  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  Uri imageUri;
}
