import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/models/favorite_model.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesModel = Provider.of<FavoritesModel>(context);
    final favoriteProducts = favoritesModel.favoriteProducts;

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
          'Favorites',
          style:
              TextStyle(color: Color(0xff4c53a5), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            color: Color(0xff4c53a5),
            icon: Icon(Icons.favorite),
            onPressed: () {
              // Navigate to the CartScreen and pass the selectedProducts list
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: ListView.builder(
          itemCount: favoriteProducts.length,
          itemBuilder: (ctx, index) {
            final favoriteItem = favoriteProducts[index];

            return ClipRRect(
              borderRadius: BorderRadius.circular(33),
              child: Card(
                child: Container(
                  height: 136,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Image.network(favoriteItem.image),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            favoriteItem.title,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff4c53a5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          '\$${favoriteItem.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff4c53a5),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            // Remove the item from favorites
                            favoritesModel
                                .removeFromFavoriteProducts(favoriteItem);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
