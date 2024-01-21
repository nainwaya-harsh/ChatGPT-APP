import 'dart:developer';

import 'package:chatgpt_integration/constants/constants.dart';
import 'package:chatgpt_integration/models/chat_model.dart';
import 'package:chatgpt_integration/services/api_services.dart';
import 'package:chatgpt_integration/services/services.dart';
import 'package:chatgpt_integration/widgets/chat_widget.dart';
import 'package:chatgpt_integration/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../providers/models_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late TextEditingController _textEditingController = TextEditingController();
  late FocusNode focusNode;
  late ScrollController _scrollController;

  void initState() {
    _scrollController = ScrollController();
    _textEditingController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  List<ChatModel> chatList = [];
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/chatgpt.png'),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await Services.showModalSheet(context: context);
                },
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                ))
          ],
          title: Text('ChatGPT'),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Flexible(
                child: chatList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Kindly Start Your Conversation',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              'Made with ❤️ By Harsh Nainwaya',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: chatList.length,
                        itemBuilder: (context, index) {
                          return ChatWidget(
                              msg: chatList[index].msg,
                              chatIndex: chatList[index].chatIndex);
                        })),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              )
            ],
            // SizedBox(
            //   height: 20,
            // ),
            Container(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration.collapsed(
                          hintText: "How can i help you?",
                          hintStyle: TextStyle(color: Colors.grey)),
                      controller: _textEditingController,
                      focusNode: focusNode,
                      onSubmitted: (val) async {
                        await sendMessageFCT(modelsProvider: modelsProvider);
                      },
                    )),
                    IconButton(
                        onPressed: () async {
                          await sendMessageFCT(modelsProvider: modelsProvider);
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          ],
        )));
  }

  Future<void> sendMessageFCT({required ModelsProvider modelsProvider}) async {
    try {
      setState(() {
        _isTyping = true;
        chatList.add(ChatModel(msg: _textEditingController.text, chatIndex: 0));
      });
      chatList.addAll(await ApiService.sendMessage(
          message: _textEditingController.text,
          modelId: modelsProvider.getCurrentModel));
      setState(() {
        _textEditingController.clear();
        focusNode.unfocus();
      });
    } catch (e) {
      print('error occured $e');
    } finally {
      setState(() {
        _isTyping = false;
        ScrollToEnd();
      });
    }
  }

  void ScrollToEnd() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 2), curve: Curves.easeOut);
  }
}
