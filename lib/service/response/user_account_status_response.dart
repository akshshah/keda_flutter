import 'package:keda_flutter/service/response/base_response.dart';
import '../../ui/bottomNavigation/profileModule/models/user_account_model.dart';

class UserAccountStatusResponse extends BaseResponse{
  UserAccount? userAccount;
  Map<String, dynamic>? json;

  UserAccountStatusResponse({int? status, String? message, this.json}) : super(status: status, message: message){
    if(json != null){
      userAccount = UserAccount.fromJson(json!);
    }
  }
}

