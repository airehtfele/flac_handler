import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unflacgui/parser/cue_info.dart';
import 'package:unflacgui/parser/cue_parser.dart';

final cueInfoViewModelProvider =
    StateNotifierProvider<CueInfoViewModel, CueInfo?>(
  (ref) => CueInfoViewModel(
    CueParser(),
  ),
);

StateProvider<TextEditingController> cuePathControllerStateProvider =
    StateProvider((ref) {
  String path = ref.watch(cueInfoViewModelProvider)?.cuePath ?? '';
  return TextEditingController(text: path);
});

class CueInfoViewModel extends StateNotifier<CueInfo?> {
  final CueParser _cueParser;
  CueInfoViewModel(this._cueParser) : super(null);
  void parseFile(File cueFile) {
    state = _cueParser.parse(cueFile);
  }
}
