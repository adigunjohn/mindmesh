import 'package:flutter/material.dart';
import 'package:mindmesh/enums/ai.dart';
import 'package:mindmesh/models/message.dart';
import 'package:mindmesh/services/navigation_service.dart';
import 'package:mindmesh/ui/common/strings.dart';

import '../../../app/locator.dart';

class ChatViewModel extends ChangeNotifier {
  // ChatViewModel();

  final NavigationService _navigate = locator<NavigationService>();

  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;
  final TextEditingController _textController = TextEditingController();
  TextEditingController get textController => _textController;
  String chatTitle = 'Chat';
  String? chatImage;
  bool showOptions = false;
  String? selectedModelVersion;
   String geminiSelectedModelVersion = 'gemini v-1 mini';
   String claudeSelectedModelVersion = 'claude v-1 mini';
   String chatGPTSelectedModelVersion = 'openAI v-1 mini';
   String deepseekSelectedModelVersion = 'deepseek v-1 mini';

  List<String>? modelVersion;

  final List<String> _geminiModelVersion =  [
    'gemini v-1 mini',
    'gemini v-2 flash',
    'gemini v2 pro',
  ];
  final List<String> _chatGPTModelVersion =  [
    'openAI v-1 mini',
    'openAI v-2 flash',
    'openAI v2 pro',
  ];
  final List<String> _claudeModelVersion =  [
    'claude v-1 mini',
    'claude v-2 flash',
    'claude v2 pro',
  ];
  final List<String> _deepseekModelVersion =  [
    'deepseek v-1 mini',
    'deepseek v-2 flash',
    'deepseek v2 pro',
  ];

  List<Message> _messages = [];
  List<Message> get messages => _messages;

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
  // List<Message> get geminiMessages => _geminiMessages;
  // List<Message> get chatGPTMessages => _chatGPTMessages;
  // List<Message> get claudeMessages => _claudeMessages;
  // List<Message> get deepseekMessages => _deepseekMessages;

  void pop() {
    _navigate.pop();
  }

  void updateShowOptions(){
    showOptions =! showOptions;
    notifyListeners();
  }

  void updateSelectedModelVersion(AI? ai,String value){
    if(ai == AI.gemini){
      geminiSelectedModelVersion = value;
    }
    else if(ai == AI.claude){
      claudeSelectedModelVersion = value;
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

  void sendMessage(AI? ai) {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      if(ai == AI.gemini){
        _geminiMessages.add(Message(text: text, isUser: true));
        _messages = [..._geminiMessages];
        _textController.clear();
        notifyListeners();

        Future.delayed(const Duration(milliseconds: 1000), () {
          _geminiMessages.add(
            Message(text: 'This is an AI response from Gemini.', isUser: false),
          );
          _messages = [..._geminiMessages];
          notifyListeners();
        });
      }
      else if(ai == AI.claude){
        _claudeMessages.add(Message(text: text, isUser: true));
        _messages = [..._claudeMessages];
        _textController.clear();
        notifyListeners();

        Future.delayed(const Duration(milliseconds: 1000), () {
          _claudeMessages.add(
            Message(text: 'This is an AI response from claude.', isUser: false),
          );
          _messages = [..._claudeMessages];
          notifyListeners();
        });
      }
      else if(ai == AI.chatGPT){
        _chatGPTMessages.add(Message(text: text, isUser: true));
        _messages = [..._chatGPTMessages];
        _textController.clear();
        notifyListeners();

        Future.delayed(const Duration(milliseconds: 1000), () {
          _chatGPTMessages.add(
            Message(text: 'This is an AI response from ChatGPT.', isUser: false),
          );
          _messages = [..._chatGPTMessages];
          notifyListeners();
        });
      }
      else if(ai == AI.deepseek){
        _deepseekMessages.add(Message(text: text, isUser: true));
        _messages = [..._deepseekMessages];
        _textController.clear();
        notifyListeners();

        Future.delayed(const Duration(milliseconds: 1000), () {
          _deepseekMessages.add(
            Message(text: 'This is an AI response from Deepseek.', isUser: false),
          );
          _messages = [..._deepseekMessages];
          notifyListeners();
        });
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
    else if(ai == AI.claude){
      chatTitle = AppStrings.claudeAI;
      _messages = _claudeMessages;
      chatImage = AppStrings.claude;
      modelVersion = _claudeModelVersion;
      selectedModelVersion = claudeSelectedModelVersion;
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
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
