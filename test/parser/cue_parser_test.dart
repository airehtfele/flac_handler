import 'dart:io';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:unflacgui/parser/cue_parser.dart';
import 'package:unflacgui/parser/cue_info.dart';
import 'package:unflacgui/parser/file_info.dart';
import 'package:unflacgui/parser/track_info.dart';

import 'cue_parser_test.mocks.dart';

const String _cueContent = '''REM GENRE "Alt. Rock"
REM DATE 2009
REM DISCID 1B030A03
REM COMMENT "ExactAudioCopy v0.99pb4"
PERFORMER "Linkin Park"
TITLE "New Divide"
FILE "01 - New Divide.flac" WAVE
  TRACK 01 AUDIO
    TITLE "New Divide"
    PERFORMER "Linkin Park"
    INDEX 01 00:00:00
FILE "02 - New Divide (Instrumental Version).flac" WAVE
  TRACK 02 AUDIO
    TITLE "New Divide (Instrumental Version)"
    PERFORMER "Linkin Park"
    INDEX 01 00:00:00
FILE "03 - New Divide (Acappella Version).flac" WAVE
  TRACK 03 AUDIO
    TITLE "New Divide (Acappella Version)"
    PERFORMER "Linkin Park"
    INDEX 01 00:00:00''';

final List<String> _cueContentLines = _cueContent.split('\n');

@GenerateMocks([File])
void main() {
  test('Check CueInfo\'s genre is "Alt. Rock"', () {
    final File mockedCueFile = generateMockedCueFile();
    final CueParser parser = CueParser();
    CueInfo? cueInfo = parser.parse(mockedCueFile);
    expect(cueInfo?.genre, "Alt. Rock");
  });

  test('Check CueInfo\'s date is 2009', () {
    final File mockedCueFile = generateMockedCueFile();
    final CueParser parser = CueParser();
    CueInfo? cueInfo = parser.parse(mockedCueFile);
    expect(cueInfo?.date, 2009);
  });

  test('Check CueInfo\'s DISCID is 1B030A03', () {
    final File mockedCueFile = generateMockedCueFile();
    final CueParser parser = CueParser();
    CueInfo? cueInfo = parser.parse(mockedCueFile);
    expect(cueInfo?.discId, "1B030A03");
  });

  test('Check CueInfo\'s COMMENT is "ExactAudioCopy v0.99pb4"', () {
    final File mockedCueFile = generateMockedCueFile();
    final CueParser parser = CueParser();
    CueInfo? cueInfo = parser.parse(mockedCueFile);
    expect(cueInfo?.comment, "ExactAudioCopy v0.99pb4");
  });

  test('Check CueInfo\'s PERFORMER is "Linkin Park"', () {
    final File mockedCueFile = generateMockedCueFile();
    final CueParser parser = CueParser();
    CueInfo? cueInfo = parser.parse(mockedCueFile);
    expect(cueInfo?.performer, "Linkin Park");
  });

  test('Check CueInfo\'s TITLE is "New Divide"', () {
    final File mockedCueFile = generateMockedCueFile();
    final CueParser parser = CueParser();
    CueInfo? cueInfo = parser.parse(mockedCueFile);
    expect(cueInfo?.title, "New Divide");
  });

  test('Check CueInfo constains one file', () {
    final File mockedCueFile = generateMockedCueFile();
    final CueParser parser = CueParser();
    CueInfo? cueInfo = parser.parse(mockedCueFile);
    expect(cueInfo?.files.length, 3);
  });

  test('First file name is "01 - New Divide.flac"', () {
    final File mockedCueFile = generateMockedCueFile();
    final CueParser parser = CueParser();
    CueInfo? cueInfo = parser.parse(mockedCueFile);
    FileInfo? firstFile = cueInfo?.files.first;
    expect(firstFile?.name, "01 - New Divide.flac");
  });

  test('First file type is WAVE', () {
    final File mockedCueFile = generateMockedCueFile();
    final CueParser parser = CueParser();
    CueInfo? cueInfo = parser.parse(mockedCueFile);
    FileInfo? firstFile = cueInfo?.files.first;
    expect(firstFile?.type, "WAVE");
  });

  test('First file has one track', () {
    final File mockedCueFile = generateMockedCueFile();
    final CueParser parser = CueParser();
    CueInfo? cueInfo = parser.parse(mockedCueFile);
    FileInfo? firstFile = cueInfo?.files.first;
    expect(firstFile?.tracks.length, 1);
  });

  test('First track has index 1', () {
    final File mockedCueFile = generateMockedCueFile();
    final CueParser parser = CueParser();
    CueInfo? cueInfo = parser.parse(mockedCueFile);
    FileInfo? firstFile = cueInfo?.files.first;
    TrackInfo? firstTrack = firstFile?.tracks.first;
    expect(firstTrack?.index, 1);
  });

  test('First track has "AUDIO" type', () {
    final File mockedCueFile = generateMockedCueFile();
    final CueParser parser = CueParser();
    CueInfo? cueInfo = parser.parse(mockedCueFile);
    FileInfo? firstFile = cueInfo?.files.first;
    TrackInfo? firstTrack = firstFile?.tracks.first;
    expect(firstTrack?.type, "AUDIO");
  });

  test('Second track TITLE is "New Divide (Instrumental Version)"', () {
    final File mockedCueFile = generateMockedCueFile();
    final CueParser parser = CueParser();
    CueInfo? cueInfo = parser.parse(mockedCueFile);
    FileInfo? firstFile = cueInfo?.files[1];
    TrackInfo? track = firstFile?.tracks.first;
    expect(track?.title, "New Divide (Instrumental Version)");
  });

  test('Second track PERFORMER is "New Divide (Instrumental Version)"', () {
    final File mockedCueFile = generateMockedCueFile();
    final CueParser parser = CueParser();
    CueInfo? cueInfo = parser.parse(mockedCueFile);
    FileInfo? firstFile = cueInfo?.files[1];
    TrackInfo? track = firstFile?.tracks.first;
    expect(track?.performer, "Linkin Park");
  });

  test('Second track INDEX is 1', () {
    final File mockedCueFile = generateMockedCueFile();
    final CueParser parser = CueParser();
    CueInfo? cueInfo = parser.parse(mockedCueFile);
    FileInfo? firstFile = cueInfo?.files[1];
    TrackInfo? track = firstFile?.tracks.first;
    expect(track?.index, 1);
  });

  test('Cue file has a valid path', () {
    final mockedCueFile = generateMockedCueFile();
    CueParser cueParser = CueParser();
    CueInfo? cueInfo = cueParser.parse(mockedCueFile);
    expect(cueInfo?.cuePath, isNotEmpty);
  });
}

File generateMockedCueFile() {
  final mockedCueFile = MockFile();
  when(mockedCueFile.path).thenReturn('/home/some_user/cue_file.cue');
  when(mockedCueFile.readAsLinesSync()).thenReturn(_cueContentLines);
  return mockedCueFile;
}
