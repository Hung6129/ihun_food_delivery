// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FoodModel {
  final String id;
  final String name;
  final String title;
  final String category;
  final String images;
  final String rating;
  final String loved;
  final int price;
  final String description;
  FoodModel({
    required this.id,
    required this.name,
    required this.title,
    required this.category,
    required this.images,
    required this.rating,
    required this.loved,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'title': title,
      'category': category,
      'images': images,
      'rating': rating,
      'loved': loved,
      'price': price,
      'description': description,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      images: map['images'] ?? '',
      rating: map['rating'] ?? '',
      loved: map['loved'] ?? '',
      price: map['price'] ?? 0,
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) => FoodModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FoodModel(id: $id, name: $name, title: $title, category: $category, images: $images, rating: $rating, loved: $loved, price: $price, description: $description)';
  }
}
