import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soft_studio_project/models/chat_message.dart';
import 'calendar_page.dart';
import 'task_page.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'gpt_assistant_service.dart';

class GPTPage extends StatefulWidget {
  @override
  State<GPTPage> createState() => _GPTPageState();
}

class _GPTPageState extends State<GPTPage> {
  final TextEditingController _controller = TextEditingController();
  final GptService _gptService = GptService();

  @override
  void initState() {
    super.initState();
    _gptService.fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<ChatMessage>>(
                stream: _gptService.messagesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError){
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      reverse: true,
                      itemCount: 
                        snapshot.data!.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const SizedBox(height: 16);
                        }
                        final message = snapshot.data![index - 1];
                        return ListTile(
                          title: Text(message.role[0].toUpperCase() +
                            message.role.substring(1)),
                          subtitle: Text(message.text),
                        );
                      }
                    );
                  } else {
                    return const Center(
                      child: Text('Ask your questions...')
                    );
                  }

                }
              )
              
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.secondary,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: 'Ask your question', hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
                      maxLines: null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        _gptService
                            .fetchPromptResponse(_controller.text.trim());
                        _controller.clear();
                      }
                    },
                    child: const Text('Send'),
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}