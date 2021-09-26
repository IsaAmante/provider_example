import 'dart:convert';

import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  double price;
  @HiveField(3)
  String imgUrl;
  @HiveField(4)
  String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imgUrl,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imgUrl': imgUrl,
      'description': description,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      imgUrl: map['imgUrl'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? imgUrl,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imgUrl: imgUrl ?? this.imgUrl,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.imgUrl == imgUrl &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        imgUrl.hashCode ^
        description.hashCode;
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, imgUrl: $imgUrl, description: $description)';
  }
}
