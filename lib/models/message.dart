import 'package:mindmesh/ui/common/date_time_format.dart';

class Message{
  final String? text;
  final String time = formatTime();
  final bool isUser;
  final String? image;
  final String? file;
  final String? filePath;

  Message({this.text, required this.isUser,this.image, this.file, this.filePath});
}