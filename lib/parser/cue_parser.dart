import 'dart:io';
import 'package:unflacgui/parser/command_parser.dart';
import 'package:unflacgui/parser/cue_info.dart';
import 'package:unflacgui/parser/file_command_parser.dart';
import 'package:unflacgui/parser/file_info.dart';
import 'package:unflacgui/parser/performer_command_parser.dart';
import 'package:unflacgui/parser/rem_parser.dart';
import 'package:unflacgui/parser/title_command_parser.dart';
import 'package:unflacgui/parser/track_command_parser.dart';
import 'package:unflacgui/parser/track_index_command_parser.dart';
import 'package:unflacgui/parser/track_info.dart';
import 'package:unflacgui/parser/track_performer_command_parser.dart';
import 'package:unflacgui/parser/track_title_command_parser.dart';

class CueParser {
  final CueInfo _cueInfo = CueInfo();
  final trackIsOpen = false;
  bool cueInfoTitleSettled = false;
  FileInfo? currentParsingFile;
  TrackInfo? currentTrackInfo;

  CueInfo? parse(File cueFile) {
    final lines = cueFile.readAsLinesSync();
    for (String line in lines) {
      CommandParser? commandParser;
      RegExp commandRegex = RegExp(r'[A-Z]+(?=\s.)');
      String? command = commandRegex.stringMatch(line);

      if (command == 'REM') {
        commandParser = RemCommandParser(_cueInfo);
      } else if (command == 'PERFORMER') {
        if (currentTrackInfo == null) {
          commandParser = PerformerCommandParser(_cueInfo);
        } else {
          commandParser = TrackPerformerCommandParser(currentTrackInfo);
        }
      } else if (command == 'TITLE') {
        if (currentTrackInfo != null) {
          commandParser = TrackTitleCommandParser(currentTrackInfo);
        } else {
          commandParser = TitleCommandParser(_cueInfo);
        }
      } else if (command == 'FILE') {
        currentParsingFile = FileInfo();
        _cueInfo.files.add(currentParsingFile!);
        commandParser = FileCommandParser(currentParsingFile!);
      } else if (command == 'TRACK') {
        currentTrackInfo = TrackInfo();
        currentParsingFile?.tracks.add(currentTrackInfo!);
        commandParser = TrackCommandParser(currentTrackInfo);
      } else if (command == 'INDEX') {
        commandParser = TrackIndexCommandParser(currentTrackInfo);
      }
      commandParser?.parse(line);
    }
    return _cueInfo;
  }
}
