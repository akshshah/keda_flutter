import 'package:keda_flutter/utils/logger.dart';

import '../../ui/bottomNavigation/explore_module/models/product_model.dart';
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

