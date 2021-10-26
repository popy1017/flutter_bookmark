import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/bookmark.dart';

class BookmarkNotifier extends StateNotifier<List<Bookmark>> {
  BookmarkNotifier() : super([]);
}
