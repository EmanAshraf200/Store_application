import 'dart:convert';

import 'package:store_app/helpers/api.dart';

import 'package:http/http.dart' as http;
import 'package:store_app/models/product_model.dart';

class UpdateProduct {
  Future<ProductModel> updateproduct(
      {required int id,
      required String title,
      required double price,
      required String description,
      required String image,
      required String category}) async {
    Map<String, dynamic> data = await Api().put(
      url: 'https://fakestoreapi.com/products/$id',
      body: {
        'title': title,
        'price': price.toString(),
        'description': description,
        'image': image,
        'category': category
      },
    );

    return ProductModel.fromjson(data);
  }
}
