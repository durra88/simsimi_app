import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/All.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:simsimi_app/model/message_item.dart';
import 'package:simsimi_app/network/network.dart';
import 'package:simsimi_app/state/state_manager.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var list = watch(messageListProvider.state);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          //!chat Content
          children: [
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return list[index].isTyping!
                          ? Container(
                              width: 50,
                              height: 50,
                              child: JumpingDotsProgressIndicator(
                                fontSize: 40.0,
                              ),
                            )
                          : list[index].fromUser!
                              ? Bubble(
                                  margin: const BubbleEdges.only(top: 10),
                                  alignment: Alignment.topRight,
                                  nip: BubbleNip.rightBottom,
                                  color: Colors.black54,
                                  child: Text(
                                    '${list[index].message}',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.right,
                                  ),
                                )
                              : Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/simsimi.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                    Bubble(
                                      margin: const BubbleEdges.only(top: 10),
                                      alignment: Alignment.topLeft,
                                      nip: BubbleNip.leftBottom,
                                      color: Colors.yellow,
                                      child: Text(
                                        '${list[index].message}',
                                        style: TextStyle(color: Colors.black),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                );
                    })),
            //!chat layout
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Enter your message'),
                    controller: _textEditingController,
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      var userChatContent = _textEditingController.text;
                      _textEditingController.clear();
                      //!add chat to list
                      context.read(messageListProvider).add(MessageItem(
                          message: userChatContent,
                          fromUser: true,
                          isTyping: false));
                      //!add jumping dots animation
                      context.read(messageListProvider).add(MessageItem(
                          message: 'Typing...',
                          fromUser: true,
                          isTyping: true));
                      //!fetch Api
                      var response =
                          await getSimsimiResponse(userChatContent, 'en');
                      //!remove jumping after having response
                      context.read(messageListProvider).removeJumpingDots();
                      //Add Response
                      context.read(messageListProvider).add(MessageItem(
                          message: response.toString(),
                          fromUser: false,
                          isTyping: false));
                      //!Auto scroll chat layout to the end
                      Timer(const Duration(milliseconds: 100), () {
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeOut);
                      });
                    },
                    icon: const Icon(Icons.send)),
              ],
            )
          ],
        ),
      )),
    );
  }

  Future<String> getSimsimiResponse(String userChatContent, String lang) async {
    return await fetchSimsimiAPI(userChatContent, lang);
  }
}
