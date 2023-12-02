import 'package:meta/meta.dart';
import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  List<Category> categories;

  CategoryModel({
    required this.categories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categories: List<Category>.from(
            json["Categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  String name;
  List<String> subCategories;

  Category({
    required this.name,
    required this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        subCategories: List<String>.from(json["subCategories"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "subCategories": List<dynamic>.from(subCategories.map((x) => x)),
      };
}
