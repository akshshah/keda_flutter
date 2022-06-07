import 'package:keda_flutter/ui/bottomNavigation/chatModule/models/chat_model.dart';

import 'base_response.dart';

class ChatResponse extends BaseResponse{
  ChatModel? chatModel;
  Map<String, dynamic>? json;

  ChatResponse({int? status, String? message, this.json}) : super(status: status, message: message){
    if(json != null){
      chatModel = ChatModel.fromJson(json!);
    }
  }
}

