import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unflacgui/viewmodel/cueinfo_viewmodel.dart';

class SelectFileWidget extends ConsumerWidget {
  const SelectFileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: ref.watch(cuePathControllerStateProvider),
            decoration: const InputDecoration(
              label: Text('Cue Path'),
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform
                .pickFiles(type: FileType.custom, allowedExtensions: [
              'cue',
            ]);
            String? pickedFilePath = result?.files.first.path;
            if (pickedFilePath != null) {
              ref
                  .read(cueInfoViewModelProvider.notifier)
                  .parseFile(File(pickedFilePath));
            }
          },
          icon: const Icon(Icons.open_in_new),
        )
      ],
    );
  }
}
