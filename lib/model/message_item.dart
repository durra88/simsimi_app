import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageItem {
  String? message;
  bool? fromUser, isTyping;
  MessageItem(
      {required this.message, required this.fromUser, required this.isTyping});
}

class MessageList extends StateNotifier<List<MessageItem>> {
  MessageList(List<MessageItem> ?state) : super(state ?? []);
  void add(MessageItem messageItem) {
    state = [
      ...state, //!old data;
      messageItem, //!new Data
    ];
  }

  void removeJumpingDots() {
    state = state.where((element) => element.isTyping! == false).toList();
  }
}
