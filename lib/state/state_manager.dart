import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simsimi_app/model/message_item.dart';

final messageListProvider = StateNotifierProvider((ref) {
  return MessageList([]);
});
