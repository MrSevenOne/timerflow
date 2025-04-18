import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarWidget {
  static void showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      colorText: Colors.black,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      icon: const Icon(Icons.check, color: Colors.green),
    );
  }

  static void showInfo({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      borderRadius: 8.0,
      duration: const Duration(seconds: 3),
    );
  }

  static void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }
}
