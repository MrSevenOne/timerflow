import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?) onChanged;

  const CustomDropdownButton({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownButtonFormField<T>(
      
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      icon: Icon(Icons.keyboard_arrow_down),
      dropdownColor: Colors.white,
      style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
    );
  }
}
