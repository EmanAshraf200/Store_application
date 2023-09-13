import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/models/product_model.dart';

class SelectedProductsModel extends ChangeNotifier {
  List<ProductModel> _selectedProducts = [];

  // Constructor to load selected products when the model is created
  SelectedProductsModel() {
    loadSelectedProducts();
  }

  // Getter to access the selected products
  List<ProductModel> get selectedProducts => _selectedProducts;

  // Load selected products from SharedPreferences
  Future<void> loadSelectedProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final selectedProductsJson = prefs.getString('selectedProducts');

    if (selectedProductsJson != null) {
      try {
        final List<Map<String, dynamic>> selectedProductsData =
            List<Map<String, dynamic>>.from(json.decode(selectedProductsJson));

        // Convert the dynamic data to ProductModel objects
        _selectedProducts = selectedProductsData
            .map((data) => ProductModel.fromjson(data))
            .toList();

        notifyListeners();
      } catch (e) {
        print('Error loading selected products: $e');
      }
    }
  }

  // Add a product to the selected products list
  void addToSelectedProducts(ProductModel product) {
    _selectedProducts.add(product);
    // Notify listeners and save to SharedPreferences
    notifyListeners();
    saveSelectedProducts();
  }

  // Remove a product from the selected products list
  void removeFromSelectedProducts(ProductModel product) {
    _selectedProducts.remove(product);
    // Notify listeners and save to SharedPreferences
    notifyListeners();
    saveSelectedProducts();
  }

  // Save selected products to SharedPreferences
  Future<void> saveSelectedProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final selectedProductsJson = json.encode(
      _selectedProducts.map((product) => product.toJson()).toList(),
    );
    await prefs.setString('selectedProducts', selectedProductsJson);
  }

  // Clear all selected products
  void clearSelectedProducts() {
    _selectedProducts.clear();
    // Notify listeners and clear from SharedPreferences
    notifyListeners();
    saveSelectedProducts();
  }
}
