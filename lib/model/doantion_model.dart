// import 'package:flutter/material.dart';

class DonationModel {
  final String id;
  final String title;
  final String description;
  final double? projectValue;
  final double? paidValue;
  final double remainingValue;
  final DateTime date;
  final String? category;
  final String imageUrl;

  DonationModel( {
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.projectValue,
    required this.paidValue,
    required this.remainingValue,
    required this.date,

    required this.imageUrl,
  });

  // Factory method to create a DonationModel from JSON
  factory DonationModel.fromJson(Map<String, dynamic> json) {
    // print(json['image']);
    // print(json['title']);
    return DonationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '', // Default to an empty string if null
      description: json['description'] ?? '',
      imageUrl: json['image'] ?? '',
      remainingValue: _toDouble(json['remainingValue']) ??
          0.0, // Default to 0.0 if null or empty
      projectValue: _toDouble(json['project_value']),
      paidValue: _toDouble(json['paid_value']),
      category: json['category'],
      date: _toDateTime(json['date']),
    );
  }

  // Helper method to convert to double or null
  static double? _toDouble(dynamic value) {
    if (value == null) {
      return null;
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value);
    } else {
      return null;
    }
  }

  // Helper method to convert to DateTime, with null safety
  static DateTime _toDateTime(dynamic value) {
    if (value == null) {
      return DateTime.now(); // Default to current date if null
    } else if (value is String) {
      return DateTime.tryParse(value) ??
          DateTime.now(); // Try parsing, else default to now
    } else if (value is DateTime) {
      return value;
    } else {
      return DateTime.now();
    }
  }
}
