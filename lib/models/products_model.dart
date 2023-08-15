import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/models/rating.dart';
import 'package:get/get.dart';

class Product {
  // ignore: unused_field
  int? _totalSize;
  late List<ProductModel> _products;
  List<ProductModel> get products => _products;

  Product(
      {required totalSize,
      required typeId,
      required offset,
      required products}) {
    _totalSize = totalSize;

    _products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];

    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel {
  int? id;
  String? id2;
  String? name;
  String? description;
  late List<String> images;
  String? category;
  int? price;
  int? quantity;
  String? cpu;
  String? gpu;
  String? ram;
  String? storage;
  String? userId;
  String? username;
  String? userimage;
  List<Rating>? rating;
  ProductModel(
      {this.id,
      this.id2,
      this.name,
      this.description,
      required this.quantity,
      required this.images,
      required this.category,
      required this.price,
      this.storage,
      this.cpu,
      this.gpu,
      this.ram,
      this.userId,
      this.username,
      this.userimage,
      this.rating});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id2 = json['_id'];
    name = json['name'];
    description = json['description'];
    cpu = json['cpu'] ?? '';
    gpu = json['gpu'] ?? '';
    ram = json['ram'] ?? '';
    category = json['category'] ?? '';
    price = json['price'] ?? 0.0;
    images = List<String>.from(json['images'] ?? '');
    quantity = json['quantity'] ?? 0;
    storage = json['storage'] ?? '';
    userId = json['user'] ?? '';
    username = "name";
    userimage = "image";
    rating = json['ratings'] != null
        ? List<Rating>.from(
            json['ratings']?.map(
              (x) => Rating.fromMap(x),
            ),
          )
        : null;
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      'cpu': cpu,
      'gpu': gpu,
      'ram': ram,
      'storage': storage,
      'user': userId,
      '_id': id2,
      'rating': rating,
    };
  }
}
