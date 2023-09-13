import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/models/cart_model.dart';
import 'package:store_app/models/product_model.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App is going into the background, save selected products here
      saveSelectedProducts();
    }
  }

  Future<void> saveSelectedProducts() async {
    final selectedProductsModel =
        Provider.of<SelectedProductsModel>(context, listen: false);
    final selectedProducts = selectedProductsModel.selectedProducts;

    try {
      final prefs = await SharedPreferences.getInstance();
      final selectedProductsJson =
          selectedProducts.map((product) => product.toJson()).toList();
      await prefs.setString(
          'selectedProducts', json.encode(selectedProductsJson));
    } catch (e) {
      print('Error saving selected products: $e');
    }
  }

  double calculateTotalPrice(List<ProductModel> selectedProducts) {
    // Calculate the total price
    double totalPrice =
        selectedProducts.fold(0.0, (sum, product) => sum + product.price);
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final selectedProductsModel = Provider.of<SelectedProductsModel>(context);
    final selectedProducts = selectedProductsModel.selectedProducts;

    // Calculate the total price
    double totalPrice = calculateTotalPrice(selectedProducts);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff4c53a5),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        title: Text(
          'My Cart',
          style:
              TextStyle(color: Color(0xff4c53a5), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            color: Color(0xff4c53a5),
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the CartScreen and pass the selectedProducts list
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: ListView.builder(
          itemCount: selectedProducts.length,
          itemBuilder: (ctx, index) {
            final cartItem = selectedProducts[index];

            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(33),
                  child: Card(
                    child: Container(
                      height: 136,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListTile(
                            leading: Image.network(cartItem.image),
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                cartItem.title,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff4c53a5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              '\$${cartItem.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff4c53a5),
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.remove_shopping_cart),
                              onPressed: () {
                                // Remove the item from the cart
                                selectedProductsModel
                                    .removeFromSelectedProducts(cartItem);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Divider(
                //   thickness: 1,
                //   indent: 20,
                //   endIndent: 20,
                //   //color: const Color.fromARGB(255, 95, 92, 92),
                // )
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Color(0xff4c53a5),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Color(0xff4c53a5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                // Handle the "Order Now" button click
              },
              child: Text(
                'Order Now',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
