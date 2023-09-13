import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/screens/cart_screen.dart';
import 'package:store_app/screens/category_products_page.dart';
import 'package:store_app/screens/favoritesscreen.dart';

import 'package:store_app/services/all_categories_service.dart';
import 'package:store_app/services/get_all_product_services.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  late List<dynamic> categories;
  late List<ProductModel> products;
  List<ProductModel> selectedProducts =
      []; // Create a list for selected products

  // @override
  // void initState() {
  //   super.initState();
  //   fetchCategoriesAndProducts();
  // }

  // Future<void> fetchCategoriesAndProducts() async {
  //   final List<dynamic> fetchedCategories =
  //       await AllCategoriesServices().getAllCategories();
  //   final List<ProductModel> fetchedProducts =
  //       await AllProductServices().getAllProducts();

  //   setState(() {
  //     categories = fetchedCategories;
  //     products = fetchedProducts;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'New Trend',
          style: TextStyle(
            color: Color(0xff4c53a5),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            color: Color(0xff4c53a5),
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the CartScreen and pass the selectedProducts list
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
          IconButton(
            color: Color(0xff4c53a5),
            icon: Icon(Icons.favorite),
            onPressed: () {
              // Navigate to the CartScreen and pass the selectedProducts list
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff4c53a5),
              ),
            ),
            SizedBox(height: 10),
            buildCategoryList(),
            SizedBox(height: 20),
            Text(
              'Products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff4c53a5),
              ),
            ),
            SizedBox(height: 10),
            buildProductGrid(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.add),
      //   backgroundColor: Color(0xff4c53a5),
      // ),
    );
  }

  Widget buildCategoryList() {
    return FutureBuilder<List<dynamic>>(
      future: AllCategoriesServices().getAllCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No categories available.');
        } else {
          List<String> categoryImages = [
            "https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg",
            "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg", // Add the URL for category 1
            "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg", // Add the URL for category 2
            "https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg"
          ];
          final categories = snapshot.data as List<dynamic>;
          return SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final categoryImageUrl = categoryImages[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryProductsPage(categoryName: category),
                      ),
                    );
                  },
                  child: Container(
                    width: 180,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.network(
                                categoryImageUrl,
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          Text(
                            category,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff4c53a5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget buildProductGrid() {
    return FutureBuilder<List<ProductModel>>(
      // Replace FutureFunction with your actual function that fetches products
      future: AllProductServices().getAllProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the Future is still running, display a loading indicator
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // If there was an error, display an error message
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // If there's no data or the data is empty, display a message
          return Text('No products available.');
        } else {
          // If the data is available, build the product grid
          final products = snapshot.data!;
          return Expanded(
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'ProductDetails',
                      arguments: {
                        'title': product.title,
                        'rating': product.rating,
                        'price': product.price,
                        'image': product.image,
                        'description': product.description,
                        'id': product.id,
                        'category': product.category
                      },
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(33),
                    child: Card(
                      elevation: 10,
                      child: Container(
                        height: 235, // Set a maximum height for the container
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                product.image,
                                height: 100,
                                width: 100,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "${product.title.substring(0, 8)}...",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff4c53a5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff4c53a5),
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  // Add the product to the selectedProducts list

                                  // selectedProducts.add(product);
                                  // print("Added to cart: ${product.title}");
                                },
                                icon: Icon(Icons.favorite),
                                color: Colors.red,
                                iconSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
