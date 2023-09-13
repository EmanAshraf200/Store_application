import 'dart:convert';

import 'package:store_app/helpers/api.dart';
import 'package:store_app/models/product_model.dart';
import 'package:http/http.dart' as http;

class CategoriesServices {
  Future<List<ProductModel>> getCategoriesProducts(
      {required String category_name}) async {
    List<dynamic> data = await Api()
        .get(url: 'https://fakestoreapi.com/products/category/$category_name');

    List<ProductModel> productslist = [];
    for (int i = 0; i < data.length; i++) {
      productslist.add(ProductModel.fromjson(data[i]));
    }
    return productslist;
  }
}
