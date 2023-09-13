import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/models/product_model.dart';

class FavoritesModel extends ChangeNotifier {
  List<ProductModel> _favoriteProducts = [];

  // Constructor to load favorite products when the model is created
  FavoritesModel() {
    loadFavoriteProducts();
  }

  // Getter to access the favorite products
  List<ProductModel> get favoriteProducts => _favoriteProducts;

  // Load favorite products from SharedPreferences
  Future<void> loadFavoriteProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoriteProductsJson = prefs.getString('favoriteProducts');

    if (favoriteProductsJson != null) {
      try {
        final List<Map<String, dynamic>> favoriteProductsData =
            List<Map<String, dynamic>>.from(json.decode(favoriteProductsJson));

        // Convert the dynamic data to ProductModel objects
        _favoriteProducts = favoriteProductsData
            .map((data) => ProductModel.fromjson(data))
            .toList();

        notifyListeners();
      } catch (e) {
        print('Error loading favorite products: $e');
      }
    }
  }

  // Add a product to the favorite products list
  void addToFavoriteProducts(ProductModel product) {
    _favoriteProducts.add(product);
    // Notify listeners and save to SharedPreferences
    notifyListeners();
    saveFavoriteProducts();
  }

  // Remove a product from the favorite products list
  void removeFromFavoriteProducts(ProductModel product) {
    _favoriteProducts.remove(product);
    // Notify listeners and save to SharedPreferences
    notifyListeners();
    saveFavoriteProducts();
  }

  // Save favorite products to SharedPreferences
  Future<void> saveFavoriteProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final favoriteProductsJson = json.encode(
      _favoriteProducts.map((product) => product.toJson()).toList(),
    );
    await prefs.setString('favoriteProducts', favoriteProductsJson);
  }

  // Clear all favorite products
  void clearFavoriteProducts() {
    _favoriteProducts.clear();
    // Notify listeners and clear from SharedPreferences
    notifyListeners();
    saveFavoriteProducts();
  }
}
