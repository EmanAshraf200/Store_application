import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/cart_model.dart';
import 'package:store_app/models/favorite_model.dart';
import 'package:store_app/models/product_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:store_app/screens/updateproduct.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  List<ProductModel> selectedProducts = [];
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final String title = arguments['title'];
    final RatingModel rating = arguments['rating'];
    final double price = arguments['price'];
    final String image = arguments['image'];
    final String description = arguments['description'];
    final int id = arguments['id'];
    final String category = arguments['category'];

    final selectedProductsModel = Provider.of<SelectedProductsModel>(context);
    // Define the product variable here
    final ProductModel product = ProductModel(
        id: id,
        title: title,
        price: price,
        description: description,
        image: image,
        rating: rating,
        category: category);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Color(0xff4c53a5),
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Product Details',
          style: TextStyle(
            color: Color(0xff4c53a5),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.edit,
                color: Color(0xff4c53a5)), // Icon for updating the product
            onPressed: () {
              // Navigate to the UpdateProductPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateProductPage(product: product),
                ),
              );
            },
          ),
          // IconButton(
          //   icon: Icon(
          //     Icons.shopping_cart,
          //     size: 30,
          //     color: Color(0xff4c53a5),
          //   ),
          //   onPressed: () {
          //     // Navigate to the CartScreen and pass the cartItems list
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => CartScreen(cartItems),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.network(image, height: 230),
          ),
          // SizedBox(height: 16.0),
          Arc(
              arcType: ArcType.CONVEY,
              edge: Edge.TOP,
              height: 30,
              child: Container(
                width: double.infinity,
                height: min(600, 700),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 60, bottom: 20, left: 30, right: 30),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4c53a5),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '\$${price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xff4c53a5),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Rating: ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4c53a5),
                        ),
                      ),
                      SizedBox(height: 10),
                      RatingBar.builder(
                        initialRating: rating.rate,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: 25,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        onRatingUpdate: (index) {},
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Description:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4c53a5),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff4c53a5),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    // const Color.fromARGB(255, 7, 230, 15),
                                    Color(0xff4c53a5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30.0), // Adjust the radius as needed
                                ),
                              ),
                              onPressed: () {
                                selectedProductsModel.addToSelectedProducts(
                                  ProductModel(
                                      id:
                                          id, // Provide a unique ID for the product
                                      title: title,
                                      price: price,
                                      description: description,
                                      image: image,
                                      rating: rating,
                                      category:
                                          category // Provide the image URL if needed
                                      ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    size: 20,
                                  ),
                                  Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    // const Color.fromARGB(255, 7, 230, 15),
                                    Color(0xff4c53a5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      30.0), // Adjust the radius as needed
                                ),
                              ),
                              onPressed: () {
                                final favoritesModel =
                                    Provider.of<FavoritesModel>(context,
                                        listen: false);
                                favoritesModel.addToFavoriteProducts(product);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    size: 20,
                                  ),
                                  Text(
                                    'Add to Favorites',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
