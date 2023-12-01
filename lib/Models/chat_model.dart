class ChatModel {
  final String msg;
  final int chatIndex;

  ChatModel({required this.msg, required this.chatIndex});

  Map<String, dynamic> tomap() {
    return {
      'msg': msg,
      'chatIndex': chatIndex,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      msg: map['msg'],
      chatIndex: map['chatIndex'],
    );
  }
}
