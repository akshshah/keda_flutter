import 'package:flutter/material.dart';
import 'package:keda_flutter/providers/base_bloc.dart';
import 'package:keda_flutter/service/response/products_response.dart';

import '../utils/logger.dart';

class SavedProvider extends BaseBloc with ChangeNotifier{
  final savedProducts = [];
  int pageCount = 0;
  bool isLoading = false;


  Future<ProductsResponse?> fetchSavedProductsAPI({ bool? isPagination = false, bool? refresh = false}) async {

    if(isPagination == true){
      pageCount += 1;
      isLoading = true;
      notifyListeners();
    }

    if(refresh == true){
      savedProducts.clear();
      pageCount = 0;
    }


    Map<String, dynamic> map = {};
    map["limit"] = 10;
    map["record_count"] = pageCount;
    ProductsResponse? response = await repository.fetchSavedProductsAPI(map);
    savedProducts.addAll(response?.items ?? []);
    isLoading = false;
    notifyListeners();
    return response;
  }
}