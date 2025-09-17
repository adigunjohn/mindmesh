import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindmesh/app/locator.dart';
import 'package:mindmesh/models/message.dart';
import 'package:mindmesh/services/ai_service.dart';
import 'package:mindmesh/services/file_picker_service.dart';
import 'package:mindmesh/services/gemini_ai_service.dart';
import 'package:mindmesh/services/navigation_service.dart';
import 'package:mindmesh/ui/common/strings.dart';

class MeshChatViewModel extends ChangeNotifier{
  MeshChatViewModel();
  final NavigationService _navigate = locator<NavigationService>();
  final FilePickerService _filePickerService = locator<FilePickerService>();
  final GeminiAIService _geminiAIService = locator<GeminiAIService>();
  final OtherAIService _otherAIService = locator<OtherAIService>();
  final String? _chatGPTApiKey = dotenv.env['OPENAI_API_KEY'];
  final String? _openRouterApiKey = dotenv.env['OPEN_ROUTER_API_KEY'];

  final ScrollController _geminiScrollController = ScrollController();
  final ScrollController _chatGPTScrollController = ScrollController();
  final ScrollController _qwenScrollController = ScrollController();
  final ScrollController _deepseekScrollController = ScrollController();
  ScrollController get geminiScrollController => _geminiScrollController;
  ScrollController get chatGPTScrollController => _chatGPTScrollController;
  ScrollController get qwenScrollController => _qwenScrollController;
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
      text: 'Hi! I\'m ChatGPT.\nHow can I help you?',
      isUser: false,
    ),
  ];
  final List<Message> _qwenMessages = [
    Message(
      text: 'Hi! I\'m Qwen.\nHow can I help you?',
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
  List<Message> get qwenMessages => _qwenMessages;
  List<Message> get deepseekMessages => _deepseekMessages;

  String geminiSelectedModelVersion = 'gemini-2.5-flash';
  String qwenSelectedModelVersion = 'qwen/qwen-plus-2025-07-28';
  String chatGPTSelectedModelVersion = 'gpt-5';
  String deepseekSelectedModelVersion = 'deepseek/deepseek-chat-v3-0324:free';

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

  Future<String> _geminiResponse(String? text) async {
    final history = await _geminiAIService.convertMessagesToContentHistory(_geminiMessages);
    _geminiMessages.add(Message(text: 'Gemini dey perform juju 😎🤌...', isUser: false, image: null, file: null),);
    notifyListeners();
    String? replyText;
    try{
      if(text != null && (pickedImage == null && pickedFile == null)){
        replyText = await _geminiAIService.geminiGenerateWithText(prompt: text, modelName: geminiSelectedModelVersion, conversationHistory: history,);
      }
      else if(pickedImage != null && pickedFile == null){
        final convertedImage = await _geminiAIService.convertImageToDataPart(pickedImage);
        replyText = await _geminiAIService.geminiGenerateWithTextAndImage(prompt: text.toString(), imageBytes: convertedImage!.bytes, imageMimeType: convertedImage.mimeType, modelName: geminiSelectedModelVersion, conversationHistory: history);
      }
      else if(pickedFile != null && pickedImage == null){
        final convertedFile = await _geminiAIService.convertFileToDataPart(pickedFile!.first);
        replyText = await _geminiAIService.geminiGenerateWithTextAndFile(prompt: text.toString(), fileBytes: convertedFile!.bytes, fileMimeType: convertedFile.mimeType, modelName: geminiSelectedModelVersion, conversationHistory: history);
      }
      _geminiMessages.removeLast();
      notifyListeners();
      return replyText!;
    }catch(e){
      log('GeminiResponse failed: $e');
      return 'GEMINI ERROR: $e';
    }
  }

  Future<String> _qwenResponse(String? text) async {
    final history = await _otherAIService.convertMessagesToContentHistory(_qwenMessages, AppStrings.qwenIntro);
    _qwenMessages.add(Message(text: 'Qwen dey perform juju 😎🤌...', isUser: false, image: null, file: null),);
    notifyListeners();
    String? replyText;
    try{
      if(text != null && (pickedImage == null && pickedFile == null)){
        replyText = await _otherAIService.sendChatMessage(history: history, model: qwenSelectedModelVersion, apiKey: _openRouterApiKey, baseUrl: AppStrings.openRouterUrl);
      }
      else if(pickedImage != null || pickedFile != null){
        replyText = await _otherAIService.sendMessageWithFile(history: history, file: File(pickedImage?.path ?? pickedFile!.first.path!), model: qwenSelectedModelVersion, baseUrl: AppStrings.openRouterUrl, apiKey: _openRouterApiKey);
      }
      _qwenMessages.removeLast();
      notifyListeners();
      return replyText!;
    }catch(e){
      log('Qwen Response failed: $e');
      return 'QWEN ERROR: $e';
    }
  }

  Future<String> _deepseekResponse(String? text) async {
    final history = await _otherAIService.convertMessagesToContentHistory(_deepseekMessages, AppStrings.deepseekIntro);
    _deepseekMessages.add(Message(text: 'Deepseek dey perform juju 😎🤌...', isUser: false, image: null, file: null),);
    notifyListeners();
    String? replyText;
    try{
      if(text != null && (pickedImage == null && pickedFile == null)){
        replyText = await _otherAIService.sendChatMessage(history: history, model: deepseekSelectedModelVersion, apiKey: _openRouterApiKey, baseUrl: AppStrings.openRouterUrl);
      }
      else if(pickedImage != null || pickedFile != null){
        replyText = await _otherAIService.sendMessageWithFile(history: history, file: File(pickedImage?.path ?? pickedFile!.first.path!), model: deepseekSelectedModelVersion, baseUrl: AppStrings.openRouterUrl, apiKey: _openRouterApiKey);
      }
      _deepseekMessages.removeLast();
      notifyListeners();
      return replyText!;
    }catch(e){
      log('Deepseek Response failed: $e');
      return 'DEEPSEEK ERROR: $e';
    }
  }

  Future<String> _chatGPTResponse(String? text) async {
    final history = await _otherAIService.convertMessagesToContentHistory(_chatGPTMessages, AppStrings.chatGPTIntro);
    _chatGPTMessages.add(Message(text: 'ChatGPT dey perform juju 😎🤌...', isUser: false, image: null, file: null),);
    notifyListeners();
    String? replyText;
    try{
      if(text != null && (pickedImage == null && pickedFile == null)){
        replyText = await _otherAIService.sendChatMessage(history: history, model: chatGPTSelectedModelVersion, apiKey: _chatGPTApiKey, baseUrl: AppStrings.openAIUrl);
        //  replyText = await _otherAIService.generateImageWithOpenAI(prompt: text, apiKey: _chatGPTApiKey);
      }
      else if(pickedImage != null || pickedFile != null){
        replyText = await _otherAIService.sendMessageWithFile(history: history, file: File(pickedImage?.path ?? pickedFile!.first.path!), model: chatGPTSelectedModelVersion, baseUrl: AppStrings.openAIUrl, apiKey: _chatGPTApiKey);
      }
      _chatGPTMessages.removeLast();
      notifyListeners();
      return replyText!;
    }catch(e){
      log('ChatGPT Response failed: $e');
      return 'CHATGPT ERROR: $e';
    }
  }

  void sendMessageToAll() {
    final text = _textController.text.isNotEmpty ? _textController.text.trim() : null;
    if(text != null || pickedImage != null || pickedFile != null){
      final chatMessages = Message(text: text, isUser: true, image: pickedImage?.path, file: pickedFile?.first.name);
      _geminiMessages.add(chatMessages);
      _chatGPTMessages.add(chatMessages);
      _qwenMessages.add(chatMessages);
      _deepseekMessages.add(chatMessages);
      _textController.clear();
      showFile = false;
      notifyListeners();

     _geminiResponse(text).then((value){
       _geminiMessages.add(Message(isUser: false, text: value));
       notifyListeners();
       scrollToBottom(_geminiScrollController);
     }).catchError((e){
       log("Error fetching Gemini response: $e");
       _geminiMessages.add(Message(text: "Error from Gemini: $e", isUser: false));
       notifyListeners();
       scrollToBottom(_geminiScrollController);
     });

      _qwenResponse(text).then((value){
        _qwenMessages.add(Message(isUser: false, text: value));
        notifyListeners();
        scrollToBottom(_qwenScrollController);
      }).catchError((e){
        log("Error fetching Qwen response: $e");
        _qwenMessages.add(Message(text: "Error from Qwen: $e", isUser: false));
        notifyListeners();
        scrollToBottom(_qwenScrollController);
      });

      _deepseekResponse(text).then((value){
        _deepseekMessages.add(Message(isUser: false, text: value));
        notifyListeners();
        scrollToBottom(_deepseekScrollController);
      }).catchError((e){
        log("Error fetching Deepseek response: $e");
        _deepseekMessages.add(Message(text: "Error from Deepseek: $e", isUser: false));
        notifyListeners();
        scrollToBottom(_deepseekScrollController);
      });

      _chatGPTResponse(text).then((value){
        _chatGPTMessages.add(Message(isUser: false, text: value));
        notifyListeners();
        scrollToBottom(_chatGPTScrollController);
      }).catchError((e){
        log("Error fetching ChatGPT response: $e");
        _chatGPTMessages.add(Message(text: "Error from ChatGPT: $e", isUser: false));
        notifyListeners();
        scrollToBottom(_chatGPTScrollController);
      });

     deleteFile();
     notifyListeners();
    }
  }

  @override
  void dispose() {
    _geminiScrollController.dispose();
    _chatGPTScrollController.dispose();
    _qwenScrollController.dispose();
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