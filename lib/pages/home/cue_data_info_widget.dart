import 'package:flutter/material.dart';
import 'package:unflacgui/parser/cue_info.dart';

class DataValue {
  final String title;
  final String value;
  const DataValue(this.title, this.value);
}

class CueDataInfoWidget extends StatelessWidget {
  final CueInfo cueInfo;
  const CueDataInfoWidget({super.key, required this.cueInfo});

  List<DataValue> get _infoItems {
    List<DataValue> infoItems = [];
    if (cueInfo.performer != null) {
      infoItems.add(DataValue('Title', cueInfo.title.toString()));
    }
    if (cueInfo.performer != null) {
      infoItems.add(DataValue('Performer', cueInfo.performer.toString()));
    }
    if (cueInfo.date != null) {
      infoItems.add(DataValue('Year', cueInfo.date.toString()));
    }
    if (cueInfo.discId != null) {
      infoItems.add(DataValue('Disc ID', cueInfo.discId.toString()));
    }
    if (cueInfo.genre != null) {
      infoItems.add(DataValue('Genre', cueInfo.genre.toString()));
    }
    infoItems.add(DataValue('File count', cueInfo.files.length.toString()));

    return infoItems;
  }

  @override
  Widget build(BuildContext context) {
    final dataItems = _infoItems;
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final currentItem = dataItems[index];
        return Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              currentItem.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              currentItem.value,
              style: const TextStyle(
                color: Colors.white,
              ),
            )
          ]),
        );
      },
      itemCount: dataItems.length,
    );
  }
}
