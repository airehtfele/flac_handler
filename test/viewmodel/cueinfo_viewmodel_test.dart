import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:unflacgui/parser/cue_info.dart';
import 'package:unflacgui/parser/cue_parser.dart';
import 'package:unflacgui/viewmodel/cueinfo_viewmodel.dart';

import 'cueinfo_viewmodel_test.mocks.dart';

@GenerateMocks([File, CueParser])
void main() {
  test('Cue info is null at initialization', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final cueViewModel = container.read(cueInfoViewModelProvider);
    expect(cueViewModel, null);
  });

  test('CueInfo is not null when a file is present', () {
    final container = generateProviderContainer();
    addTearDown(container.dispose);
    File cueFile = generateStubbedCueFile();
    container.read(cueInfoViewModelProvider.notifier).parseFile(cueFile);
    final cueInfo = container.read(cueInfoViewModelProvider);
    expect(cueInfo, isNotNull);
  });

  test('CueFile has been readed', () {
    final container = generateProviderContainer();
    File cueFile = generateStubbedCueFile();
    container.read(cueInfoViewModelProvider.notifier).parseFile(cueFile);
    verify(cueFile.readAsLinesSync()).called(1);
  });

  test('Cue file has been parsed', () {
    final cueParser = MockCueParser();
    final container = generateProviderContainer(overrides: [
      cueInfoViewModelProvider.overrideWithValue(CueInfoViewModel(cueParser))
    ]);
    File mockedCueFile = generateStubbedCueFile();
    final mockedCueInfo = CueInfo(cuePath: '');
    when(cueParser.parse(mockedCueFile)).thenReturn(mockedCueInfo);
    container.read(cueInfoViewModelProvider.notifier).parseFile(mockedCueFile);
    var read = container.read(cueInfoViewModelProvider);
    var mockedCueInfo2 = mockedCueInfo;
    expect(read, mockedCueInfo2);
  });

  test('Cue path controller is not empty after parse a file', () {
    final container = generateProviderContainer();
    final cueFile = generateStubbedCueFile();
    container.read(cueInfoViewModelProvider.notifier).parseFile(cueFile);
    final pathController = container.read(cuePathControllerStateProvider);
    expect(pathController.text, isNotEmpty);
  });
}

File generateStubbedCueFile() {
  final file = MockFile();
  when(file.readAsLinesSync()).thenReturn([]);
  when(file.path).thenReturn('/home/specific_user/some_file.cue');
  return file;
}

ProviderContainer generateProviderContainer({
  List<Override> overrides = const [],
}) {
  ProviderContainer container = ProviderContainer(
    overrides: overrides,
  );
  addTearDown(container.dispose);
  return container;
}
