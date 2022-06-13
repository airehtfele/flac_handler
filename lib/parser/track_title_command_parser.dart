import 'package:rift/parser/command_parser.dart';
import 'package:rift/parser/track_info.dart';

class TrackTitleCommandParser extends CommandParser {
  final TrackInfo? _trackInfo;
  TrackTitleCommandParser(this._trackInfo);

  @override
  void parse(String rawCommand) {
    RegExp titleRegex = RegExp(r'(?<=")(.*?)(?=")');
    _trackInfo?.title = titleRegex.stringMatch(rawCommand);
  }
}
