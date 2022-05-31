import '../../ui/bottomNavigation/profileModule/models/user_rate_review_model.dart';
import 'base_response.dart';

class UserRateReviewResponse extends BaseResponse{
  UserRateReview? userRateReview;
  Map<String, dynamic>? json;

  UserRateReviewResponse({int? status, String? message, this.json}) : super(status: status, message: message){
    if(json != null){
      userRateReview = UserRateReview.fromJson(json!);
    }
  }
}


