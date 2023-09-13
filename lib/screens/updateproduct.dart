import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/update_product.dart';

class UpdateProductPage extends StatefulWidget {
  final ProductModel product;

  UpdateProductPage({required this.product});

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Populate the text controllers with existing product data
    titleController.text = widget.product.title;
    // Parse the price from a String to double
    priceController.text = widget.product.price.toStringAsFixed(2);
    descriptionController.text = widget.product.description;
    imageController.text = widget.product.image;
  }

  @override
  Widget build(BuildContext context) {
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
          'Update Product',
          style: TextStyle(
            color: Color(0xff4c53a5),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Customized TextFormField with circular border
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: Color(0xff4c53a5), // Set label text color
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Color(0xff4c53a5), // Set outline border color
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            // Customized TextFormField with circular border
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Price',
                labelStyle: TextStyle(
                  color: Color(0xff4c53a5), // Set label text color
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Color(0xff4c53a5), // Set outline border color
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            // Customized TextFormField with circular border
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                  color: Color(0xff4c53a5), // Set label text color
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Color(0xff4c53a5), // Set outline border color
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            // Customized TextFormField with circular border
            TextFormField(
              controller: imageController,
              decoration: InputDecoration(
                labelText: 'Image URL',
                labelStyle: TextStyle(
                  color: Color(0xff4c53a5), // Set label text color
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Color(0xff4c53a5), // Set outline border color
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            // ElevatedButton with elevated elevation
            Container(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  // Get the updated product data from the text controllers
                  final String updatedTitle = titleController.text;
                  final String updatedPrice = priceController.text;
                  final String updatedDescription = descriptionController.text;
                  final String updatedImage = imageController.text;

                  // Check if price can be converted to double
                  double updatedPriceAsDouble;
                  try {
                    updatedPriceAsDouble = double.parse(updatedPrice);
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Invalid Price'),
                        content: Text('Please enter a valid numeric price.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                    return;
                  }

                  // Call the updateProduct method from your service
                  final updatedProduct = await UpdateProduct().updateproduct(
                    id: widget.product.id,
                    title: updatedTitle,
                    price: updatedPriceAsDouble,
                    description: updatedDescription,
                    image: updatedImage,
                    category: widget.product.category,
                  );

                  // Handle the response (e.g., show a success message)
                  if (updatedProduct != null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Product Updated'),
                        content: Text('The product has been updated.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Handle the case where the update fails
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Update Failed'),
                        content: Text('Failed to update the product.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text(
                  'Update Product',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      // const Color.fromARGB(255, 7, 230, 15),
                      Color(0xff4c53a5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        30.0), // Adjust the radius as needed
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
///////////////////////
  