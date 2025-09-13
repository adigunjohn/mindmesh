import 'package:flutter/material.dart';
import 'package:mindmesh/app/locator.dart';
import 'package:mindmesh/models/message.dart';
import 'package:mindmesh/services/navigation_service.dart';

class MeshChatViewModel extends ChangeNotifier{
  MeshChatViewModel();
  final NavigationService _navigate = locator<NavigationService>();

  final ScrollController _geminiScrollController = ScrollController();
  final ScrollController _chatGPTScrollController = ScrollController();
  final ScrollController _claudeScrollController = ScrollController();
  final ScrollController _deepseekScrollController = ScrollController();
  ScrollController get geminiScrollController => _geminiScrollController;
  ScrollController get chatGPTScrollController => _chatGPTScrollController;
  ScrollController get claudeScrollController => _claudeScrollController;
  ScrollController get deepseekScrollController => _deepseekScrollController;

  final TextEditingController _textController = TextEditingController();
  TextEditingController get textController => _textController;
  String geminiSelectedModelVersion = 'gemini v-1 mini';
  String claudeSelectedModelVersion = 'claude v-1 mini';
  String chatGPTSelectedModelVersion = 'openAI v-1 mini';
  String deepseekSelectedModelVersion = 'deepseek v-1 mini';

  final List<String> _geminiModelVersion =  [
    'gemini v-1 mini',
    'gemini v-2 flash',
    'gemini v2 pro',
  ];
  final List<String> _chatGPTModelVersion =  [
    'openAI v-1 mini',
    'openAI v-2 flash',
    'openAI v2 pro',
  ];  final List<String> _claudeModelVersion =  [
    'claude v-1 mini',
    'claude v-2 flash',
    'claude v2 pro',
  ];  final List<String> _deepseekModelVersion =  [
    'deepseek v-1 mini',
    'deepseek v-2 flash',
    'deepseek v2 pro',
  ];
  List<String> get geminiModelVersion => _geminiModelVersion;
  List<String> get chatGPTModelVersion => _chatGPTModelVersion;
  List<String> get claudeModelVersion => _claudeModelVersion;
  List<String> get deepseekModelVersion => _deepseekModelVersion;

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

  void updateGeminiSelectedModelVersion(String value){
    geminiSelectedModelVersion = value;
    notifyListeners();
  }
  void updateDeepseekSelectedModelVersion(String value){
    deepseekSelectedModelVersion = value;
    notifyListeners();
  }
  void updateClaudeSelectedModelVersion(String value){
    claudeSelectedModelVersion = value;
    notifyListeners();
  }
  void updateChatGPTSelectedModelVersion(String value){
    chatGPTSelectedModelVersion = value;
    notifyListeners();
  }

  void sendMessageToAll(){
    final message = _textController.text.trim();
    if(message.isNotEmpty){
      final chatMessages = Message(text: message, isUser: true,);
      _geminiMessages.add(chatMessages);
      _chatGPTMessages.add(chatMessages);
      _claudeMessages.add(chatMessages);
      _deepseekMessages.add(chatMessages);
      _textController.clear();
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