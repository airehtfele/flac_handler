import 'package:flutter/material.dart';
import 'package:rift/pages/home/cue_track_info_widget.dart';
import 'package:rift/parser/file_info.dart';

class CueFilesInfoWidget extends StatelessWidget {
  final List<FileInfo> files;
  const CueFilesInfoWidget({super.key, required this.files});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        shrinkWrap: true,
        controller: ScrollController(),
        physics: ScrollPhysics(),
        itemBuilder: ((context, index) {
          final file = files[index];
          final fileTracks = file.tracks;
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white.withAlpha(10)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        const Text(
                          ('File name: '),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          file.name ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      file.type ?? '',
                      style: const TextStyle(
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return CueTrackInfoWidget(trackInfo: fileTracks[index]);
                  },
                  itemCount: fileTracks.length,
                )
              ],
            ),
          );
        }),
        itemCount: files.length);
  }
}
