import 'package:rift/parser/file_info.dart';

class CueInfo {
  String? genre;
  int? date;
  String? discId;
  String? comment;
  String? performer;
  String? title;
  final List<FileInfo> files = [];
  String cuePath;
  CueInfo({
    required this.cuePath,
  });
}
