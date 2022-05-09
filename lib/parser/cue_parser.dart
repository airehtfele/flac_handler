import 'dart:io';

import 'package:flutter/cupertino.dart';

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

class CueInfo {
  String? genre;
  int? date;
  String? discId;
  String? comment;
  String? performer;
  String? title;

  final List<FileInfo> files = [];
}

class FileInfo {
  String? name;
  String? type;
  final List<TrackInfo> tracks = [];
}

class TrackInfo {
  late int index;
  String? type;
  String? title;
  String? performer;
}

abstract class CommandParser {
  void parse(String rawCommand);
}

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

class PerformerCommandParser extends CommandParser {
  final CueInfo _cueInfo;
  PerformerCommandParser(this._cueInfo);

  @override
  void parse(String rawCommand) {
    RegExp performerRegex = RegExp(r'(?<=")(.*?)(?=")');
    _cueInfo.performer = performerRegex.stringMatch(rawCommand);
  }
}

class TitleCommandParser extends CommandParser {
  final CueInfo _cueInfo;
  TitleCommandParser(this._cueInfo);

  @override
  void parse(String rawCommand) {
    RegExp titleRegex = RegExp(r'(?<=")(.*?)(?=")');
    _cueInfo.title = titleRegex.stringMatch(rawCommand);
  }
}

class TrackTitleCommandParser extends CommandParser {
  TrackInfo? _trackInfo;
  TrackTitleCommandParser(this._trackInfo);

  @override
  void parse(String rawCommand) {
    RegExp titleRegex = RegExp(r'(?<=")(.*?)(?=")');
    _trackInfo?.title = titleRegex.stringMatch(rawCommand);
  }
}

class FileCommandParser extends CommandParser {
  FileInfo _fileInfo;
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

class TrackCommandParser extends CommandParser {
  final TrackInfo? _trackInfo;

  TrackCommandParser(
    this._trackInfo,
  );
  @override
  void parse(String rawCommand) {
    RegExp indexRegex = RegExp(r'(?<=TRACK )[0-9]+(?= [A-Z]+)');
    RegExp typeRegex = RegExp(r'(?<=TRACK [0-9]+ )[A-Z]+');
    String? indexString = indexRegex.stringMatch(rawCommand);
    if (indexString != null) {
      _trackInfo?.index = int.parse(indexString);
    }
    _trackInfo?.type = typeRegex.stringMatch(rawCommand);
  }
}

class TrackPerformerCommandParser extends CommandParser {
  TrackInfo? _trackInfo;
  TrackPerformerCommandParser(this._trackInfo);

  @override
  void parse(String rawCommand) {
    RegExp performerRegex = RegExp(r'(?<=PERFORMER ")(.*?)(?=")');
    _trackInfo?.performer = performerRegex.stringMatch(rawCommand);
  }
}

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
