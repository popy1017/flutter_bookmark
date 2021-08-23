import 'package:flutter/material.dart';
import 'package:flutter_bookmark/components/text_form_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/bookmark_list.dart';

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
            builder: (_) => TextFormDialog(title: 'Add bookmark'),
          );

          if (url != null) {
            print(url);
          }
        },
      ),
    );
  }
}
