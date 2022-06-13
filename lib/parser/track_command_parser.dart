import 'package:rift/parser/command_parser.dart';
import 'package:rift/parser/cue_parser.dart';
import 'package:rift/parser/track_info.dart';

class TrackCommandParser extends CommandParser {
  final TrackInfo? _trackInfo;

  TrackCommandParser(
    this._trackInfo,
  );
  @override
  void parse(String rawCommand) {
    RegExp indexRegex = RegExp(r'(?<=TRACK )[0-9]+(?= [A-Z]+)');
    RegExp typeRegex = RegExp(r'(?<=TRACK [0-9]+ )[A-Z]+');
    String? indexString = indexRegex.stringMatch(rawCommand);
    if (indexString != null) {
      _trackInfo?.index = int.parse(indexString);
    }
    _trackInfo?.type = typeRegex.stringMatch(rawCommand);
  }
}
