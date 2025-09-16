import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindmesh/app/locator.dart';
import 'package:mindmesh/models/message.dart';
import 'package:mindmesh/services/file_picker_service.dart';
import 'package:mindmesh/services/navigation_service.dart';

class MeshChatViewModel extends ChangeNotifier{
  MeshChatViewModel();
  final NavigationService _navigate = locator<NavigationService>();
  final FilePickerService _filePickerService = locator<FilePickerService>();

  final ScrollController _geminiScrollController = ScrollController();
  final ScrollController _chatGPTScrollController = ScrollController();
  final ScrollController _claudeScrollController = ScrollController();
  final ScrollController _deepseekScrollController = ScrollController();
  ScrollController get geminiScrollController => _geminiScrollController;
  ScrollController get chatGPTScrollController => _chatGPTScrollController;
  ScrollController get claudeScrollController => _claudeScrollController;
  ScrollController get deepseekScrollController => _deepseekScrollController;
  bool showOptions = false;
  bool showFile = false;
  final TextEditingController _textController = TextEditingController();
  TextEditingController get textController => _textController;
  XFile? pickedImage;
  List<PlatformFile>? pickedFile;

  final List<Message> _geminiMessages = [
    Message(
      text: 'Hi! I\'m Gemini.\nHow can I help you?',
      isUser: false,
    ),
  ];
  final List<Message> _chatGPTMessages = [
    Message(
      text: 'Hi! I\'m chatGPT.\nHow can I help you?',
      isUser: false,
    ),
  ];
  final List<Message> _claudeMessages = [
    Message(
      text: 'Hi! I\'m Claude.\nHow can I help you?',
      isUser: false,
    ),
  ];
  final List<Message> _deepseekMessages = [
    Message(
      text: 'Hi! I\'m Deepseek.\nHow can I help you?',
      isUser: false,
    ),
  ];
  List<Message> get geminiMessages => _geminiMessages;
  List<Message> get chatGPTMessages => _chatGPTMessages;
  List<Message> get claudeMessages => _claudeMessages;
  List<Message> get deepseekMessages => _deepseekMessages;

  void pop() {
    _navigate.pop();
  }
  void updateShowOptions(){
    showOptions =! showOptions;
    notifyListeners();
  }
  void deleteFile(){
    showFile = false;
    pickedFile = null;
    pickedImage = null;
    notifyListeners();
  }

  void pickImage(ImageSource source) async{
    final image = await _filePickerService.pickImage(source: source);
    if(image != null){
      deleteFile();
      pickedImage = image;
      showFile = true;
      log(pickedImage!.path);
      notifyListeners();
    }
    else{
      log('Error: unable to pick image from $source');
    }
  }

  void pickFile() async{
    final file = await _filePickerService.pickFile();
    if(file != null){
      deleteFile();
      pickedFile = file;
      showFile = true;
      log('File Name: ${pickedFile!.first.name}, File Path: ${pickedFile!.first.path.toString()}');
      notifyListeners();
    }
    else{
      log('Error: unable to pick file');
    }
  }


  void scrollToBottom(ScrollController scrollController) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(0.0);
      }
    });
  }

  void sendMessageToAll(){
    final message = _textController.text.isNotEmpty ? _textController.text.trim() : null;
    if(message != null || pickedImage != null || pickedFile != null){
      final chatMessages = Message(text: message, isUser: true, image: pickedImage?.path, file: pickedFile?.first.name);
      _geminiMessages.add(chatMessages);
      _chatGPTMessages.add(chatMessages);
      _claudeMessages.add(chatMessages);
      _deepseekMessages.add(chatMessages);
      _textController.clear();
      showFile = false;
      deleteFile();
      notifyListeners();

      Future.delayed(Duration(seconds: 2), (){
        final reply1 = Message(text: 'Aye Aye John Doe, Gemini at your service! 😍👍', isUser: false,);
        final reply2 = Message(text: 'Aye Aye John Doe, ChatGPT is waiting to answer all your questions! 😁👍', isUser: false,);
        final reply3 = Message(text: 'Aye Aye John Doe, Claude responding! 😘👍', isUser: false,);
        final reply4 = Message(text: 'Aye Aye John Doe, Deepseek saying hello! 😎👍', isUser: false,);
        _geminiMessages.add(reply1);
        _chatGPTMessages.add(reply2);
        _claudeMessages.add(reply3);
        _deepseekMessages.add(reply4);
        notifyListeners();

        scrollToBottom(_geminiScrollController);
        scrollToBottom(_chatGPTScrollController);
        scrollToBottom(_claudeScrollController);
        scrollToBottom(_deepseekScrollController);
      });
    }
  }

  @override
  void dispose() {
    _geminiScrollController.dispose();
    _chatGPTScrollController.dispose();
    _claudeScrollController.dispose();
    _deepseekScrollController.dispose();
    _textController.dispose();
    super.dispose();
  }
}


//  // Gemini
//     _fetchGeminiResponse(userChatMessage).then((response) {
//       _geminiMessages.add(response);
//       notifyListeners();
//       scrollToBottom(_geminiScrollController);
//     }).catchError((error) {
//       log("Error fetching Gemini response: $error");
//       _geminiMessages.add(Message(text: "Error from Gemini.", isUser: false));
//       notifyListeners();
//       scrollToBottom(_geminiScrollController);
//     });
//
//     // ChatGPT
//     _fetchChatGPTResponse(userChatMessage).then((response) {
//       _chatGPTMessages.add(response);
//       notifyListeners();
//       scrollToBottom(_chatGPTScrollController);
//     }).catchError((error) {
//       log("Error fetching ChatGPT response: $error");
//       _chatGPTMessages.add(Message(text: "Error from ChatGPT.", isUser: false));
//       notifyListeners();
//       scrollToBottom(_chatGPTScrollController);
//     });