import 'package:flutter/material.dart';
import 'package:unflacgui/parser/track_info.dart';

class CueTrackInfoWidget extends StatelessWidget {
  final TrackInfo trackInfo;
  const CueTrackInfoWidget({super.key, required this.trackInfo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          trackInfo.index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          trackInfo.type ?? '',
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          trackInfo.performer != null
              ? '${trackInfo.performer} - ${trackInfo.title}'
              : trackInfo.title ?? 'No track information',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
