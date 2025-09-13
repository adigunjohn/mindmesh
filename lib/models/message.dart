
import 'package:mindmesh/ui/common/date_time_format.dart';

class Message{
  final String text;
  final String time = formatTime();
  final bool isUser;

  Message({required this.text, required this.isUser,});
}