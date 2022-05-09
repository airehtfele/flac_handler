import 'package:unflacgui/parser/command_parser.dart';
import 'package:unflacgui/parser/cue_parser.dart';
import 'package:unflacgui/parser/track_info.dart';

class TrackPerformerCommandParser extends CommandParser {
  final TrackInfo? _trackInfo;
  TrackPerformerCommandParser(this._trackInfo);

  @override
  void parse(String rawCommand) {
    RegExp performerRegex = RegExp(r'(?<=PERFORMER ")(.*?)(?=")');
    _trackInfo?.performer = performerRegex.stringMatch(rawCommand);
  }
}
