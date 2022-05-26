import 'package:flutter/material.dart';
import 'package:keda_flutter/providers/base_bloc.dart';

import '../service/response/products_response.dart';
import '../utils/logger.dart';

class ExploreProvider extends BaseBloc with ChangeNotifier{

  final recentProducts = [];
  int recentPageCount = 0;
  final recommendedProducts = [];
  int recommendedPageCount = 0;

  Future<ProductsResponse?> fetchRecommendedProductsAPI({ bool? isPagination = false, bool? refresh = false}) async {
    if(isPagination == true){
      recommendedPageCount += 1;
    }

    if(refresh == true){
      recommendedProducts.clear();
      recommendedPageCount = 0;
    }

    Map<String, dynamic> map = {};
    map["limit"] = 10;
    map["lang"] = -122.084;
    map["lat"] = 37.4219983;
    map["record_count"] = recommendedPageCount;
    map["user_id"] = "91";
    ProductsResponse? response = await repository.fetchRecommendedProductsAPI(map);
    recommendedProducts.addAll(response?.items ?? []);
    notifyListeners();
    return response;
  }

  Future<ProductsResponse?> fetchRecentProductsAPI({ bool? isPagination = false, bool? refresh = false}) async {
    if(isPagination == true){
      recentPageCount += 1;
    }

    if(refresh == true){
      recentProducts.clear();
      recentPageCount = 0;
    }

    Map<String, dynamic> map = {};
    map["limit"] = 10;
    map["record_count"] = recentPageCount;
    map["user_id"] = "91";
    ProductsResponse? response = await repository.fetchRecentProducts(map);
    recentProducts.addAll(response?.items ?? []);
    Logger().v("Response size ${response?.items?.length}");
    Logger().v("Recent Products size ${recentProducts.length}");
    notifyListeners();
    return response;
  }

}