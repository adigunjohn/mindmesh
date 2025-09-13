import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindmesh/ui/common/styles.dart';
import 'package:mindmesh/ui/common/ui_helpers.dart';


class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key,
  required this.aiImage,
    this.time,
   required this.message,
    required this.isUser,
  });
 final String aiImage;
 final String? time;
 final String message;
 final bool isUser;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 15.0, vertical: 5.0),
      child: isUser == true ? Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: screenWidth(context)/1.3),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                border: Border.all(color: kCGrey300Color, width: 2),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25))
            ),
            child: Text(
              message,
              maxLines: 100,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          SizedBox(height: 4,),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Text(
              time.toString(),
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12),
            ),
          ),
        ],
      ) : Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: kCGrey300Color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(aiImage,fit: BoxFit.contain,),
            ),
          ),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: screenWidth(context)/1.3),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(color: kCGrey300Color, width: 2),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(25),bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25))
                ),
                child: Text(
                  message,
                  maxLines: 100,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              SizedBox(height: 4,),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Text(
                  time ?? '5:48 am',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
