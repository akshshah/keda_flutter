class ChatModel{
  int? id;
  int? senderId;
  int? receiverId;
  int? productId;
  String? dateTime;
  String? profilePicture;
  String? message;
  int? messageType;
  String? productName;
  String? userName;

  ChatModel(
      {this.id,
        this.senderId,
        this.receiverId,
        this.productId,
        this.dateTime,
        this.profilePicture,
        this.message,
        this.messageType,
        this.productName,
        this.userName});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    productId = json['product_id'];
    dateTime = json['date_time'];
    profilePicture = json['profile_picture'];
    message = json['message'];
    messageType = json['message_type'];
    productName = json['product_name'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['product_id'] = productId;
    data['date_time'] = dateTime;
    data['profile_picture'] = profilePicture;
    data['message'] = message;
    data['message_type'] = messageType;
    data['product_name'] = productName;
    data['user_name'] = userName;
    return data;
  }
}