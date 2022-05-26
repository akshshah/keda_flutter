
import 'package:keda_flutter/utils/logger.dart';

import 'base_response.dart';

class ProductsResponse extends BaseResponse {
  List<Product>? items;
  int? totalRecords;
  List<dynamic>? data;

  ProductsResponse({int? status, String? message, this.data, this.totalRecords}) : super(status: status, message: message){
    totalRecords = totalRecords;
    final data = this.data;
    if(data != null){
      items = List<Product>.from(data.map((model) => Product.fromJson(model)));
    }
  }
}

class Product {
  int? id;
  int? userId;
  String? userName;
  String? profilePicture;
  int? categoryId;
  String? title;
  String? description;
  List<ProductMedias>? productMedias;
  num? price;
  num? pricePerDay;
  num? depositAmount;
  String? userEmail;
  String? userMobile;
  String? userCountryCode;
  String? bankAccStatus;
  int? isAccAdded;
  int? isCardAdded;
  int? userProductCount;
  int? minimumDuration;
  int? minDurationDays;
  String? minDurationUnit;
  String? rentDurationUnit;
  String? deliveryType;
  int? addressId;
  String? productAddress;
  String? productStatus;
  double? lat;
  double? lang;
  String? categoryName;
  String? addressType;
  String? flatNo;
  String? userAvgRating;
  num? userTotalRatingandreview;
  int? isFavorite;
  String? aboutUs;
  String? requestStatus;
  String? timezone;
  String? offsetTime;
  String? earliestTime;
  String? latestTime;

  Product(
      {id,
        userId,
        userName,
        profilePicture,
        categoryId,
        title,
        description,
        productMedias,
        price,
        pricePerDay,
        depositAmount,
        userEmail,
        userMobile,
        userCountryCode,
        bankAccStatus,
        isAccAdded,
        isCardAdded,
        userProductCount,
        minimumDuration,
        minDurationDays,
        minDurationUnit,
        rentDurationUnit,
        deliveryType,
        addressId,
        productAddress,
        productStatus,
        lat,
        lang,
        categoryName,
        addressType,
        flatNo,
        userAvgRating,
        userTotalRatingandreview,
        isFavorite,
        aboutUs,
        requestStatus,
        timezone,
        offsetTime,
        earliestTime,
        latestTime});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    profilePicture = json['profile_picture'];
    categoryId = json['category_id'];
    title = json['title'];
    description = json['description'];
    if (json['product_medias'] != null) {
      productMedias = <ProductMedias>[];
      json['product_medias'].forEach((v) {
        productMedias!.add(ProductMedias.fromJson(v));
      });
    }
    price = json['price'];
    pricePerDay = json['price_per_day'];
    depositAmount = json['deposit_amount'];
    userEmail = json['user_email'];
    userMobile = json['user_mobile'];
    userCountryCode = json['user_countryCode'];
    bankAccStatus = json['bank_acc_status'];
    isAccAdded = json['is_acc_added'];
    isCardAdded = json['is_card_added'];
    userProductCount = json['user_product_count'];
    minimumDuration = json['minimum_duration'];
    minDurationDays = json['min_duration_days'];
    minDurationUnit = json['min_duration_unit'];
    rentDurationUnit = json['rent_duration_unit'];
    deliveryType = json['delivery_type'];
    addressId = json['address_id'];
    productAddress = json['product_address'];
    productStatus = json['product_status'];
    lat = json['lat'];
    lang = json['lang'];
    categoryName = json['categoryName'];
    addressType = json['address_type'];
    flatNo = json['flat_no'];
    userAvgRating = json['user_avg_rating'];
    userTotalRatingandreview = json['user_total_ratingandreview'];
    isFavorite = json['isFavorite'];
    aboutUs = json['about_us'];
    requestStatus = json['request_status'];
    timezone = json['timezone'];
    offsetTime = json['offset_time'];
    earliestTime = json['earliest_time'];
    latestTime = json['latest_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['profile_picture'] = profilePicture;
    data['category_id'] = categoryId;
    data['title'] = title;
    data['description'] = description;
    if (productMedias != null) {
      data['product_medias'] =
          productMedias!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['price_per_day'] = pricePerDay;
    data['deposit_amount'] = depositAmount;
    data['user_email'] = userEmail;
    data['user_mobile'] = userMobile;
    data['user_countryCode'] = userCountryCode;
    data['bank_acc_status'] = bankAccStatus;
    data['is_acc_added'] = isAccAdded;
    data['is_card_added'] = isCardAdded;
    data['user_product_count'] = userProductCount;
    data['minimum_duration'] = minimumDuration;
    data['min_duration_days'] = minDurationDays;
    data['min_duration_unit'] = minDurationUnit;
    data['rent_duration_unit'] = rentDurationUnit;
    data['delivery_type'] = deliveryType;
    data['address_id'] = addressId;
    data['product_address'] = productAddress;
    data['product_status'] = productStatus;
    data['lat'] = lat;
    data['lang'] = lang;
    data['categoryName'] = categoryName;
    data['address_type'] = addressType;
    data['flat_no'] = flatNo;
    data['user_avg_rating'] = userAvgRating;
    data['user_total_ratingandreview'] = userTotalRatingandreview;
    data['isFavorite'] = isFavorite;
    data['about_us'] = aboutUs;
    data['request_status'] = requestStatus;
    data['timezone'] = timezone;
    data['offset_time'] = offsetTime;
    data['earliest_time'] = earliestTime;
    data['latest_time'] = latestTime;
    return data;
  }
}

class ProductMedias {
  int? id;
  String? mediaPath;
  String? mediaType;
  String? mediaName;

  ProductMedias({id, mediaPath, mediaType, mediaName});

  ProductMedias.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mediaPath = json['media_path'];
    mediaType = json['media_type'];
    mediaName = json['media_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['media_path'] = mediaPath;
    data['media_type'] = mediaType;
    data['media_name'] = mediaName;
    return data;
  }
}