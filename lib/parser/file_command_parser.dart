import 'package:unflacgui/parser/command_parser.dart';
import 'package:unflacgui/parser/file_info.dart';

class FileCommandParser extends CommandParser {
  final FileInfo _fileInfo;
  FileCommandParser(this._fileInfo);

  @override
  void parse(String rawCommand) {
    RegExp fileNameRegExp = RegExp(r'(?<=FILE ")(.*?)(?=")');
    String? fileName = fileNameRegExp.stringMatch(rawCommand);
    RegExp fileTypeRegex = RegExp(r'(?<=" )[A-Z]+');
    String? fileType = fileTypeRegex.stringMatch(rawCommand);
    _fileInfo.name = fileName;
    _fileInfo.type = fileType;
  }
}
