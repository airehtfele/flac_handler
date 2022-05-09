import 'package:unflacgui/parser/command_parser.dart';
import 'package:unflacgui/parser/cue_info.dart';

class TitleCommandParser extends CommandParser {
  final CueInfo _cueInfo;
  TitleCommandParser(this._cueInfo);

  @override
  void parse(String rawCommand) {
    RegExp titleRegex = RegExp(r'(?<=")(.*?)(?=")');
    _cueInfo.title = titleRegex.stringMatch(rawCommand);
  }
}
