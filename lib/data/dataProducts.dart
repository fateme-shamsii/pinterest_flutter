import 'dart:convert';
import 'package:http/http.dart' as http;

Future<ProductsList> fetchFruit() async {
  final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ProductsList.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}



class ProductsList {
  List<Product> product;
  ProductsList({required this.product});
  factory ProductsList.fromJson(List<dynamic> json) {
    List<Product> product;
    product = json.map((i) => Product.fromJson(i)).toList();
    return ProductsList(product: product);
  }
}

class Product {
  var id;
  var title;
  var price;
  var description;
  var category;
  var image;
  var rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        category: json['category'],
        image: json['image'],
        rating: Rating.fromJson(json['rating']));
  }
}

class Rating {
  var rate;
  var count;

  Rating(this.rate, this.count);
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(json['rate'], json['count']);
  }
}