import 'package:flutter/material.dart';
import 'package:keda_flutter/providers/base_bloc.dart';
import 'package:keda_flutter/service/response/products_response.dart';

import '../utils/logger.dart';

class SavedProvider extends BaseBloc with ChangeNotifier{

  Future<ProductsResponse?> fetchSavedProductsAPI() async {
    Map<String, dynamic> map = {};
    map["limit"] = 10;
    map["record_count"] = 0;
    ProductsResponse? response = await repository.fetchSavedProductsAPI(map);
    return response;
  }
}