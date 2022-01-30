import 'package:flutter/material.dart';
import 'package:flutter_bookmark/components/text_form_dialog.dart';
import 'package:flutter_bookmark/repositories/bookmark_repository.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:uuid/uuid.dart';
import 'package:validators/validators.dart';

import 'components/bookmark_list.dart';
import 'models/bookmark.dart';

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: BookmarkList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final String? url = await showDialog<String?>(
            context: context,
            builder: (_) => TextFormDialog(
              title: 'Add bookmark',
              isValid: (String text) {
                return isURL(text);
              },
            ),
          );

          if (url != null) {
            await _createBookmark(url, ref);
          }
        },
      ),
    );
  }

  Future<void> _createBookmark(String url, WidgetRef ref) async {
    EasyLoading.show();

    final Metadata? metadata = await MetadataFetch.extract(url);

    if (metadata != null) {
      final BookmarkRepository _bookmarkRepository =
          await ref.read(bookmarkRepositoryProvider.future);
      final Bookmark _newBookmark = Bookmark(
        id: Uuid().v4(),
        url: url,
        title: metadata.title ?? '',
        imageUri: metadata.image ??
            'https://flutter.dev/images/flutter-logo-sharing.png',
        description: metadata.description ?? '',
      );
      await _bookmarkRepository.create(_newBookmark);
    }
    EasyLoading.dismiss();
  }
}
