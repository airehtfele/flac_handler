import 'package:unflacgui/parser/command_parser.dart';
import 'package:unflacgui/parser/track_info.dart';

class TrackIndexCommandParser extends CommandParser {
  final TrackInfo? _trackInfo;
  TrackIndexCommandParser(this._trackInfo);
  @override
  void parse(String rawCommand) {
    RegExp indexRegex = RegExp(r'(?<=INDEX )[0-9]+(?= )');
    String? indexString = indexRegex.stringMatch(rawCommand);
    if (indexString != null) {
      _trackInfo?.index = int.parse(indexString);
    }
  }
}
