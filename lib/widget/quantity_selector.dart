import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  const QuantitySelector({super.key});

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  int _quantity = 1;

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: Icon(Icons.remove), onPressed: _decrement),
        Text(
          '$_quantity',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        IconButton(icon: Icon(Icons.add), onPressed: _increment),
      ],
    );
  }
}
