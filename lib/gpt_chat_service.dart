import 'dart:async';
import 'dart:convert';
import 'models/chat_message.dart';
import 'package:http/http.dart' as http;

class GptService {
  static const String apiKey = ''; //Cannot push api key
  static const String url = 'https://api.openai.com/v1/chat/completions';

  final _messagesStreamController = 
    StreamController<List<ChatMessage>>.broadcast();
  final List<ChatMessage> _messages = [];

  Stream<List<ChatMessage>> get messagesStream =>
    _messagesStreamController.stream;
  
  Future<void> fetchMessages() async {
    await Future.delayed(const Duration(seconds: 1));
    _messagesStreamController.add(List.of(_messages));
  }

  Future<void> fetchPromptResponse(String prompt) async {
    _messages.insert(0, ChatMessage(role: 'user', text: prompt));
    _messages.insert(
      0,
      ChatMessage(role: 'assistant', text: 'Generating response...'),
    );
    _messagesStreamController.add(List.from(_messages));

    var history = _messages
      .where((message) => message.text != 'Generating response...')
      .map((message) => {
            'role': message.role,
            'content': message.text,
          })
      .toList()
      .reversed
      .toList();
    
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo', // Specify the model you're using
        'messages': history,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch response: ${response.statusCode}');
    }

    var data = json.decode(utf8.decode(response.bodyBytes));
    var responses = data['choices'][0]['message']['content'].trim();
    _messages[0] = ChatMessage(role: 'assistant', text: responses);

    _messagesStreamController.add(List.from(_messages));
  }

  void dispose() {
    _messagesStreamController.close();
  }
}