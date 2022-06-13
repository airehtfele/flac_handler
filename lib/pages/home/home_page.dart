import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rift/pages/home/area_widget.dart';
import 'package:rift/pages/home/cue_data_info_widget.dart';
import 'package:rift/pages/home/cue_files_info_widget.dart';
import 'package:rift/pages/home/select_file_widget.dart';
import 'package:rift/parser/cue_info.dart';
import 'package:rift/viewmodel/cueinfo_viewmodel.dart';

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
          if (cueInfo != null)
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Row(
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * .25,
                        height: constraints.maxHeight,
                        child: AreaWidget(
                          title: 'Information',
                          child: CueDataInfoWidget(cueInfo: cueInfo),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * .75,
                        height: constraints.maxHeight,
                        child: AreaWidget(
                          title: 'Tracks',
                          margin: const EdgeInsets.only(
                            top: 8,
                            right: 8,
                            bottom: 8,
                          ),
                          child: CueFilesInfoWidget(files: cueInfo.files),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
