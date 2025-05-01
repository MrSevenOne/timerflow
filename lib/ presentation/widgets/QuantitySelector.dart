import 'package:flutter/material.dart';

class QuantitySelector extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  const QuantitySelector({
    super.key,
    this.initialValue = 1,
    required this.onChanged,
    this.min = 1,
    this.max = 1000,
  });

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialValue;
  }

  void _increment() {
    if (_quantity < widget.max) {
      setState(() {
        _quantity++;
      });
      widget.onChanged(_quantity);
    }
  }

  void _decrement() {
    if (_quantity > widget.min) {
      setState(() {
        _quantity--;
      });
      widget.onChanged(_quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: _decrement,
          icon: const Icon(Icons.remove),
        ),
        Text(
          '$_quantity',
          style: const TextStyle(fontSize: 18),
        ),
        IconButton(
          onPressed: _increment,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
