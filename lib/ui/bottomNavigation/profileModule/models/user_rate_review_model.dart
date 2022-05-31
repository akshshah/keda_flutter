import '../../../../utils/logger.dart';

class UserRateReview {
  int? toUserId;
  double? rating;
  int? isReviewAdded;
  String? userAvgRating;
  int? userTotalRatingandreview;

  UserRateReview(
      {this.toUserId,
        this.rating,
        this.isReviewAdded,
        this.userAvgRating,
        this.userTotalRatingandreview});

  UserRateReview.fromJson(Map<String, dynamic> json) {

    userAvgRating = json['user_avg_rating'];
    toUserId = json['to_user_id'];
    rating = json['rating'];
    isReviewAdded = json['is_review_added'];
    userTotalRatingandreview = json['user_total_ratingandreview'];
    Logger().v("Rate & Review In JSON" );
  }

}