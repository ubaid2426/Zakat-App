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
  final String addres;
  final String titlenotice;
  final double? latitude;
  final double? longitude;
  DonationModel( {
    required this.addres,
    required this.titlenotice,
    required this.latitude,
    required this.longitude,
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
    return DonationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      titlenotice: json['title_notice'] ?? '', // Default to an empty string if null
      description: json['description'] ?? '',
      imageUrl: json['image'] ?? '',
      remainingValue: _toDouble(json['remainingValue']) ??
          0.0, // Default to 0.0 if null or empty
      projectValue: _toDouble(json['project_value']),
      paidValue: _toDouble(json['paid_value']),
      category: json['category'],
      date: _toDateTime(json['date']),
      addres: json['address'] ?? '',
      latitude: _toDouble(json['latitude']) ?? 0,
      longitude: _toDouble(json['longitude']) ?? 0,
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
