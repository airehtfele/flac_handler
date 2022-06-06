import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unflacgui/pages/home/cue_data_info_widget.dart';
import 'package:unflacgui/pages/home/select_file_widget.dart';
import 'package:unflacgui/parser/cue_info.dart';
import 'package:unflacgui/viewmodel/cueinfo_viewmodel.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CueInfo? cueInfo = ref.watch(cueInfoViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unflac GUI'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SelectFileWidget(),
          ),
          if (cueInfo != null) CueDataInfoWidget(cueInfo: cueInfo)
        ],
      ),
    );
  }
}
