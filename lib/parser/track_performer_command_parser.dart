import 'package:rift/parser/command_parser.dart';
import 'package:rift/parser/cue_parser.dart';
import 'package:rift/parser/track_info.dart';

class TrackPerformerCommandParser extends CommandParser {
  final TrackInfo? _trackInfo;
  TrackPerformerCommandParser(this._trackInfo);

  @override
  void parse(String rawCommand) {
    RegExp performerRegex = RegExp(r'(?<=PERFORMER ")(.*?)(?=")');
    _trackInfo?.performer = performerRegex.stringMatch(rawCommand);
  }
}
