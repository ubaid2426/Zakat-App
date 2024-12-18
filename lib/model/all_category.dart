// import 'package:flutter/material.dart';

class AllCategoryModel {
  const AllCategoryModel({
    required this.id,
    required this.title,
    required this.image,
    required this.route,
  });

  final String id;
  final String title;
  final String image;
  final String route;



  // A factory method to create a CategoryModel from JSON
  factory AllCategoryModel.fromJson(Map<String, dynamic> json) {
    return AllCategoryModel(
      id: json['id'],
      title: json['title'],
      image: json['image'], // Relative path
      route: json['route'],
    );
  }
}