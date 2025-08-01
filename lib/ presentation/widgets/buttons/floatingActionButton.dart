// ignore: file_names
import 'package:flutter/material.dart';

Widget floatingActionButton({required VoidCallback ontap}) {
  return FloatingActionButton(
    onPressed: ontap,
    child: Icon(Icons.add),
  );
}
