import 'package:rift/parser/command_parser.dart';
import 'package:rift/parser/cue_info.dart';
import 'package:rift/parser/cue_parser.dart';

class RemCommandParser extends CommandParser {
  final CueInfo _cueInfo;
  RemCommandParser(this._cueInfo);
  @override
  parse(String rawCommand) {
    RegExp remCommandExp = RegExp(r'(?<=REM )[A-Z]+(?=.)');
    String? remCommand = remCommandExp.stringMatch(rawCommand);
    RegExp commandContentRegex = RegExp(r'((?<=REM \w+\s).+)');
    String? commandContent = commandContentRegex.stringMatch(rawCommand);
    if (commandContent != null &&
        commandContent[0] == '"' &&
        commandContent[commandContent.length - 1] == '"') {
      commandContent = commandContent.substring(1, commandContent.length - 1);
    }

    if (remCommand == 'GENRE') {
      _cueInfo.genre = commandContent;
    } else if (remCommand == 'DATE' && commandContent != null) {
      _cueInfo.date = int.parse(commandContent);
    } else if (remCommand == 'DISCID') {
      _cueInfo.discId = commandContent;
    } else if (remCommand == "COMMENT") {
      _cueInfo.comment = commandContent;
    }
  }
}
