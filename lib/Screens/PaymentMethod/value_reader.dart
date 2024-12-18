import 'package:flutter/material.dart';

class ValueReader extends StatelessWidget {
  final String text;
  
  const ValueReader(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
