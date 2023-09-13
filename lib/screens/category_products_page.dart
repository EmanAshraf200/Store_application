import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/categories_service.dart';

class CategoryProductsPage extends StatefulWidget {
  final String categoryName;

  CategoryProductsPage({required this.categoryName});

  @override
  _CategoryProductsPageState createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  late Future<List<ProductModel>> _products;

  @override
  void initState() {
    super.initState();
    _products = CategoriesServices().getCategoriesProducts(
      category_name: widget.categoryName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Color(0xff4c53a5),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
        title: Text(
          widget.categoryName,
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
              // Handle cart action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff4c53a5),
              ),
            ),
            SizedBox(height: 15),
            Builder(builder: (context) {
              return Expanded(
                child: FutureBuilder<List<ProductModel>>(
                  future: _products,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text(
                          'No products available for ${widget.categoryName}.');
                    } else {
                      final products = snapshot.data!;
                      return GridView.builder(
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
                                  'id': product.id
                                },
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(33),
                              child: Card(
                                elevation: 10,
                                child: Container(
                                  height:
                                      235, // Set a maximum height for the container
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
                                          onPressed: () {},
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
                      );
                    }
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
