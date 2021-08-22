class Bookmark {
  Bookmark({
    required this.title,
    required this.description,
    required String uri,
  }) : imageUri = Uri.parse(uri);

  String title;
  String description;
  Uri imageUri;
}
