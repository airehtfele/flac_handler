import 'dart:io';
import 'package:rift/parser/command_parser.dart';
import 'package:rift/parser/cue_info.dart';
import 'package:rift/parser/file_command_parser.dart';
import 'package:rift/parser/file_info.dart';
import 'package:rift/parser/performer_command_parser.dart';
import 'package:rift/parser/rem_parser.dart';
import 'package:rift/parser/title_command_parser.dart';
import 'package:rift/parser/track_command_parser.dart';
import 'package:rift/parser/track_index_command_parser.dart';
import 'package:rift/parser/track_info.dart';
import 'package:rift/parser/track_performer_command_parser.dart';
import 'package:rift/parser/track_title_command_parser.dart';

class CueParser {
  final trackIsOpen = false;
  bool cueInfoTitleSettled = false;
  FileInfo? currentParsingFile;
  TrackInfo? currentTrackInfo;

  CueInfo? parse(File cueFile) {
    final CueInfo cueInfo = CueInfo(cuePath: cueFile.path);
    final lines = cueFile.readAsLinesSync();
    for (String line in lines) {
      CommandParser? commandParser;
      RegExp commandRegex = RegExp(r'[A-Z]+(?=\s.)');
      String? command = commandRegex.stringMatch(line);

      if (command == 'REM') {
        commandParser = RemCommandParser(cueInfo);
      } else if (command == 'PERFORMER') {
        if (currentTrackInfo == null) {
          commandParser = PerformerCommandParser(cueInfo);
        } else {
          commandParser = TrackPerformerCommandParser(currentTrackInfo);
        }
      } else if (command == 'TITLE') {
        if (currentTrackInfo != null) {
          commandParser = TrackTitleCommandParser(currentTrackInfo);
        } else {
          commandParser = TitleCommandParser(cueInfo);
        }
      } else if (command == 'FILE') {
        currentParsingFile = FileInfo();
        cueInfo.files.add(currentParsingFile!);
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
    return cueInfo;
  }
}
