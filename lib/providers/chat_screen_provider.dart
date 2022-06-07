import 'package:flutter/material.dart';
import 'package:keda_flutter/providers/base_bloc.dart';
import 'package:keda_flutter/service/request/send_chat_request.dart';
import 'package:keda_flutter/service/response/chat_response.dart';
import 'package:intl/intl.dart';
import 'package:keda_flutter/utils/app_date_format.dart';

class ChatProvider extends BaseBloc with ChangeNotifier{

  Future<ChatResponse> sendChatMessageAPI() async {
    SendChatRequest chatRequest = SendChatRequest();
    chatRequest.dateTime = DateFormat(AppDateFormat.serverDateTimeFormat1).format(DateTime.now());
    chatRequest.message = "Testing";
    chatRequest.messageType = 0;
    chatRequest.productId = 125;
    chatRequest.senderId = 91;
    chatRequest.receiverId = 103;
    ChatResponse response = await repository.sendChatMessageAPI(chatRequest);
    return response;
  }
}