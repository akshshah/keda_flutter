import 'package:flutter/material.dart';
import 'package:keda_flutter/providers/base_bloc.dart';

import '../service/response/products_response.dart';
import '../ui/authentication/models/login_data_model.dart';
import '../utils/logger.dart';

class ExploreProvider extends BaseBloc with ChangeNotifier{

  final recentProducts = [];
  int recentPageCount = 0;
  bool isRecentLoading = false;

  final recommendedProducts = [];
  int recommendedPageCount = 0;
  bool isRecommendedLoading = false;


  Future<ProductsResponse?> fetchRecommendedProductsAPI({ bool? isPagination = false, bool? refresh = false}) async {
    if(isPagination == true){
      recommendedPageCount += 1;
      isRecommendedLoading = true;
      notifyListeners();
    }

    if(refresh == true){
      recommendedProducts.clear();
      recommendedPageCount = 0;
    }

    var user = await LoginData.getUserDetails();
    Map<String, dynamic> map = {};
    map["limit"] = 10;
    map["lang"] = -122.084;
    map["lat"] = 37.4219983;
    map["record_count"] = recommendedPageCount;
    map["user_id"] = user.id;
    ProductsResponse? response = await repository.fetchRecommendedProductsAPI(map);
    recommendedProducts.addAll(response?.items ?? []);
    isRecommendedLoading = false;
    notifyListeners();
    return response;
  }

  Future<ProductsResponse?> fetchRecentProductsAPI({ bool? isPagination = false, bool? refresh = false}) async {
    if(isPagination == true){
      recentPageCount += 1;
      isRecentLoading = true;
      notifyListeners();
    }

    if(refresh == true){
      recentProducts.clear();
      recentPageCount = 0;
    }

    var user = await LoginData.getUserDetails();
    Map<String, dynamic> map = {};
    map["limit"] = 10;
    map["record_count"] = recentPageCount;
    map["user_id"] = user.id;
    ProductsResponse? response = await repository.fetchRecentProducts(map);
    recentProducts.addAll(response?.items ?? []);
    Logger().v("Response size ${response?.items?.length}");
    Logger().v("Recent Products size ${recentProducts.length}");
    isRecentLoading = false;
    notifyListeners();
    return response;
  }



}