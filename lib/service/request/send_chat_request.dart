class SendChatRequest {
  String? dateTime;
  int? limit;
  String? message;
  int? messageType;
  int? productId;
  int? receiverId;
  int? recordCount;
  int? senderId;

  SendChatRequest(
      {this.dateTime,
        this.limit,
        this.message,
        this.messageType,
        this.productId,
        this.receiverId,
        this.recordCount,
        this.senderId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_time'] = dateTime;
    data['limit'] = limit;
    data['message'] = message;
    data['message_type'] = messageType;
    data['product_id'] = productId;
    data['receiver_id'] = receiverId;
    data['record_count'] = recordCount;
    data['sender_id'] = senderId;
    return data;
  }
}