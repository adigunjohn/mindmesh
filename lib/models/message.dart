import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindmesh/ui/common/date_time_format.dart';
part 'message.g.dart';

@HiveType(typeId: 0)
class Message extends HiveObject{
  @HiveField(0)
  final String? text;
  @HiveField(1)
  String? time = formatTime();
  @HiveField(2)
  final bool isUser;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final String? file;
  @HiveField(5)
  final String? filePath;

  Message({this.text, required this.isUser,this.image, this.file, this.filePath, String? time}) : time = time ?? formatTime();
}