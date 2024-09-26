import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final VoidCallback onIncrementSelected;
  final VoidCallback onDecrementSelected;
  final Widget label;

  const CounterButton({
    Key? key,
    required this.onIncrementSelected,
    required this.onDecrementSelected,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: onDecrementSelected,
        ),
        label,
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: onIncrementSelected,
        ),
      ],
    );
  }
}
