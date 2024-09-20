// import 'package:flutter/material.dart';

class DonateModel {
  const DonateModel( {
    required this.id,
    required this.title,
    required this.image,
    required this.route,
    required this.des,
    required this.price,
    // required this.projectvalue,
    // required this.paid,
  });

  final String id;
  final String title;
  final String des;
  final String image;
  final String route;
  // final double projectvalue;
  // final double paid;
  final double price;
}
