class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final RatingModel rating;

  final String category;

  ProductModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.image,
      required this.rating,
      required this.category});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'image': image,
      'rating': rating.toJson(),
      'category': category,
    };
  }

  factory ProductModel.fromjson(jsonData) {
    return ProductModel(
        id: jsonData['id'],
        title: jsonData['title'],
        // price: jsonData['price'].toDouble(),
        price: double.tryParse(jsonData['price'].toString()) ?? 0.0,
        description: jsonData['description'],
        image: jsonData['image'],
        category: jsonData['category'],
        rating: RatingModel.fromjson(jsonData['rating']));
  }
}

class RatingModel {
  final double rate;
  final int count;

  RatingModel({required this.rate, required this.count});

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }

  factory RatingModel.fromjson(Map<String, dynamic>? jsonData) {
    if (jsonData == null || jsonData['rate'] == null) {
      // Handle the case where 'rating' is null or 'rate' is missing in JSON
      return RatingModel(rate: 0.0, count: 0);
    }
    return RatingModel(
        rate: jsonData['rate'].toDouble(), count: jsonData['count']);
  }
}
