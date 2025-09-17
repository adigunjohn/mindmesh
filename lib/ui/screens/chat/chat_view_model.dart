import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindmesh/enums/ai.dart';
import 'package:mindmesh/models/message.dart';
import 'package:mindmesh/services/ai_service.dart';
import 'package:mindmesh/services/gemini_ai_service.dart';
import 'package:mindmesh/services/file_picker_service.dart';
import 'package:mindmesh/services/navigation_service.dart';
import 'package:mindmesh/ui/common/strings.dart';
import '../../../app/locator.dart';

class ChatViewModel extends ChangeNotifier {
  ChatViewModel();
  final FilePickerService _filePickerService = locator<FilePickerService>();
  final NavigationService _navigate = locator<NavigationService>();
  final GeminiAIService _geminiAIService = locator<GeminiAIService>();
  final OtherAIService _otherAIService = locator<OtherAIService>();
  final String? _chatGPTApiKey = dotenv.env['OPENAI_API_KEY'];
  final String? _openRouterApiKey = dotenv.env['OPEN_ROUTER_API_KEY'];

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;
  final TextEditingController _textController = TextEditingController();
  TextEditingController get textController => _textController;
  String chatTitle = 'Chat';
  String? chatImage;
  bool showOptions = false;
  bool showFile = false;
  String? selectedModelVersion;
  XFile? pickedImage;
  List<PlatformFile>? pickedFile;
   String geminiSelectedModelVersion = 'gemini-2.5-flash';
   String qwenSelectedModelVersion = 'qwen/qwen-plus-2025-07-28';
   String chatGPTSelectedModelVersion = 'gpt-5';
   String deepseekSelectedModelVersion = 'deepseek/deepseek-chat-v3-0324:free';

  List<String>? modelVersion;

  final List<String> _geminiModelVersion =  [
    'gemini-2.5-pro',
    'gemini-2.5-flash',
    'gemini-2.5-flash-lite',
  ];
  final List<String> _chatGPTModelVersion =  [
    'gpt-5',
    'gpt-5-mini',
    'gpt-5-nano',
    // 'openai/gpt-4o-mini', //to be used with open router
  ];
  final List<String> _deepseekModelVersion =  [
    'deepseek/deepseek-chat-v3-0324:free',
  ];
  final List<String> _qwenModelVersion =  [
    'qwen/qwen-plus-2025-07-28',
  ];

  List<Message> _messages = [];
  List<Message> get messages => _messages;

  final List<Message> _geminiMessages = [
    Message(
      text: AppStrings.geminiIntro,
      isUser: false,
    ),
  ];
  final List<Message> _chatGPTMessages = [
    Message(
      text: AppStrings.chatGPTIntro,
      isUser: false,
    ),
  ];
  final List<Message> _qwenMessages = [
    Message(
      text: AppStrings.qwenIntro,
      isUser: false,
    ),
  ];
  final List<Message> _deepseekMessages = [
    Message(
      text: AppStrings.deepseekIntro,
      isUser: false,
    ),
  ];

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

  void updateSelectedModelVersion(AI? ai,String value){
    if(ai == AI.gemini){
      geminiSelectedModelVersion = value;
    }
    else if(ai == AI.qwen){
      qwenSelectedModelVersion = value;
    }
    else if(ai == AI.chatGPT){
      chatGPTSelectedModelVersion = value;
    }
    else if(ai == AI.deepseek){
      deepseekSelectedModelVersion = value;
    }
    selectedModelVersion = value;
    notifyListeners();
  }

  void scrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0.0);
       // _scrollController.animateTo(0.0, duration: Duration(milliseconds: 50), curve: Curves.easeOut);
      }
    });
  }

  Future<void> sendMessage(AI? ai) async{
    final text = _textController.text.isNotEmpty ? _textController.text.trim() : null;
    if (text != null || pickedImage != null || pickedFile != null) {
      if(ai == AI.gemini){
        final history = await _geminiAIService.convertMessagesToContentHistory(_geminiMessages);
        _geminiMessages.add(Message(text: text, isUser: true, image: pickedImage?.path, file: pickedFile?.first.name, filePath: pickedFile?.first.path));
        _messages = [..._geminiMessages];
        showFile = false;
        _textController.clear();
        notifyListeners();
          _geminiMessages.add(Message(text: 'Gemini dey perform juju 😎🤌...', isUser: false, image: null, file: null),);
          _messages = [..._geminiMessages];
          notifyListeners();
        try{
          String? replyText;
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
          deleteFile();
            _geminiMessages.removeLast();
            _messages = [..._geminiMessages];
            notifyListeners();
          _geminiMessages.add(
            Message(text: replyText, isUser: false, image: null, file: null),
          );
          _messages = [..._geminiMessages];
          notifyListeners();
          scrollToBottom();
        }catch(e){
          log('Error in calling Gemini API from ChatViewModel: $e');
        }

      }
      else if(ai == AI.qwen){
        _qwenMessages.add(Message(text: text, isUser: true, image: pickedImage?.path, file: pickedFile?.first.name));
        _messages = [..._qwenMessages];
        _textController.clear();
        showFile = false;
        notifyListeners();
        final history = await _otherAIService.convertMessagesToContentHistory(_qwenMessages, AppStrings.qwenIntro);
        _qwenMessages.add(Message(text: 'Qwen dey perform juju 😎🤌...', isUser: false, image: null, file: null),);
        _messages = [..._qwenMessages];
        notifyListeners();
        try{
          String? replyText;
          if(text != null && (pickedImage == null && pickedFile == null)){
            replyText = await _otherAIService.sendChatMessage(history: history, model: qwenSelectedModelVersion, apiKey: _openRouterApiKey, baseUrl: AppStrings.openRouterUrl);
          }
          else if(pickedImage != null || pickedFile != null){
            replyText = await _otherAIService.sendMessageWithFile(history: history, file: File(pickedImage?.path ?? pickedFile!.first.path!), model: qwenSelectedModelVersion, baseUrl: AppStrings.openRouterUrl, apiKey: _openRouterApiKey);
          }
          deleteFile();
          _qwenMessages.removeLast();
          _messages = [..._qwenMessages];
          notifyListeners();
          _qwenMessages.add(
            Message(image: null,isUser: false, file: null, text: replyText),
          );
          _messages = [..._qwenMessages];
          notifyListeners();
          scrollToBottom();
        }catch(e){
          log('Error in calling Qwen API from ChatViewModel: $e');
        }

      }
      else if(ai == AI.chatGPT){
        _chatGPTMessages.add(Message(text: text, isUser: true, image: pickedImage?.path, file: pickedFile?.first.name));
        _messages = [..._chatGPTMessages];
        _textController.clear();
        showFile = false;
        notifyListeners();
        final history = await _otherAIService.convertMessagesToContentHistory(_chatGPTMessages, AppStrings.chatGPTIntro);
        _chatGPTMessages.add(Message(text: 'ChatGPT dey perform juju 😎🤌...', isUser: false, image: null, file: null),);
        _messages = [..._chatGPTMessages];
        notifyListeners();
        try{
          String? replyText;
          if(text != null && (pickedImage == null && pickedFile == null)){
            replyText = await _otherAIService.sendChatMessage(history: history, model: chatGPTSelectedModelVersion, apiKey: _chatGPTApiKey, baseUrl: AppStrings.openAIUrl);
           //  replyText = await _otherAIService.generateImageWithOpenAI(prompt: text, apiKey: _chatGPTApiKey);
          }
          else if(pickedImage != null || pickedFile != null){
            replyText = await _otherAIService.sendMessageWithFile(history: history, file: File(pickedImage?.path ?? pickedFile!.first.path!), model: chatGPTSelectedModelVersion, baseUrl: AppStrings.openAIUrl, apiKey: _chatGPTApiKey);
          }
        deleteFile();
        _chatGPTMessages.removeLast();
        _messages = [..._chatGPTMessages];
        notifyListeners();
        _chatGPTMessages.add(
          Message(image: null,isUser: false, file: null, text: replyText),
        );
        _messages = [..._chatGPTMessages];
        notifyListeners();
        scrollToBottom();
        }catch(e){
          log('Error in calling chatGPT API from ChatViewModel: $e');
        }
      }
      else if(ai == AI.deepseek){
        _deepseekMessages.add(Message(text: text, isUser: true, image: pickedImage?.path, file: pickedFile?.first.name));
        _messages = [..._deepseekMessages];
        _textController.clear();
        showFile = false;
        notifyListeners();
        final history = await _otherAIService.convertMessagesToContentHistory(_deepseekMessages, AppStrings.deepseekIntro);
        _deepseekMessages.add(Message(text: 'Deepseek dey perform juju 😎🤌...', isUser: false, image: null, file: null),);
        _messages = [..._deepseekMessages];
        notifyListeners();
        try{
          String? replyText;
          if(text != null && (pickedImage == null && pickedFile == null)){
             replyText = await _otherAIService.sendChatMessage(history: history, model: deepseekSelectedModelVersion, apiKey: _openRouterApiKey, baseUrl: AppStrings.openRouterUrl);
          }
          else if(pickedImage != null || pickedFile != null){
            replyText = await _otherAIService.sendMessageWithFile(history: history, file: File(pickedImage?.path ?? pickedFile!.first.path!), model: deepseekSelectedModelVersion, baseUrl: AppStrings.openRouterUrl, apiKey: _openRouterApiKey);
          }
          deleteFile();
          _deepseekMessages.removeLast();
          _messages = [..._deepseekMessages];
          notifyListeners();
          _deepseekMessages.add(
            Message(image: null,isUser: false, file: null, text: replyText),
          );
          _messages = [..._deepseekMessages];
          notifyListeners();
          scrollToBottom();
        }catch(e){
          log('Error in calling Deepseek API from ChatViewModel: $e');
        }
      }
    }
  }

  void chatType(AI? ai){
    if(ai == AI.gemini){
      chatTitle = AppStrings.geminiAI;
      chatImage = AppStrings.gemini;
      _messages = _geminiMessages;
      modelVersion = _geminiModelVersion;
      selectedModelVersion = geminiSelectedModelVersion;
    }
    else if(ai == AI.qwen){
      chatTitle = AppStrings.qwenAI;
      _messages = _qwenMessages;
      chatImage = AppStrings.qwen;
      modelVersion = _qwenModelVersion;
      selectedModelVersion = qwenSelectedModelVersion;
    }
    else if(ai == AI.chatGPT){
      chatTitle = AppStrings.chatGPTAI;
      _messages = _chatGPTMessages;
      chatImage = AppStrings.openAI;
      modelVersion = _chatGPTModelVersion;
      selectedModelVersion = chatGPTSelectedModelVersion;
    }
    else if(ai == AI.deepseek){
      chatTitle = AppStrings.deepseekAI;
      _messages = _deepseekMessages;
      chatImage = AppStrings.deepseek;
      modelVersion = _deepseekModelVersion;
      selectedModelVersion = deepseekSelectedModelVersion;
    }
    notifyListeners();
    scrollToBottom();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

