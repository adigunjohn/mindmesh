import 'dart:io';

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
    this.image,
    this.file,
  });
 final String aiImage;
 final String? time;
 final String? image;
 final String? file;
 final String? message;
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (image != null) ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                    child: Image.file(File(image.toString()), fit: BoxFit.contain,),),
                if (file != null) ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: kCGreyColor,
                      height: 50,
                      child: Center(
                        child: Text(file.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12, fontStyle: FontStyle.italic, color: Theme.of(context).textTheme.bodyMedium!.color),
                        ),),),),
                if(message != null) SizedBox(height: image != null ? 12 : 0,),
                if(message != null) SizedBox(height: file != null ? 12 : 0,),
                if(message != null) Text(
                  message.toString(),
                  maxLines: 100,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (image != null) ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(image.toString(), fit: BoxFit.contain,)),
                    if (file != null) ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        color: kCGreyColor,
                        height: 50,
                        child: Center(
                          child: Text(file.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12, fontStyle: FontStyle.italic, color: Theme.of(context).textTheme.bodyMedium!.color),
                          ),
                        ),),),
                    if(message != null) SizedBox(height: image != null ? 12 : 0,),
                    if(message != null) SizedBox(height: file != null ? 12 : 0,),
                    if(message != null) Text(
                      message.toString(),
                      maxLines: 100,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
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
          ),
        ],
      ),
    );
  }
}
