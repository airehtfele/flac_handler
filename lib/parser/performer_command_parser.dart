import 'package:rift/parser/command_parser.dart';
import 'package:rift/parser/cue_info.dart';

class PerformerCommandParser extends CommandParser {
  final CueInfo _cueInfo;
  PerformerCommandParser(this._cueInfo);

  @override
  void parse(String rawCommand) {
    RegExp performerRegex = RegExp(r'(?<=")(.*?)(?=")');
    _cueInfo.performer = performerRegex.stringMatch(rawCommand);
  }
}
