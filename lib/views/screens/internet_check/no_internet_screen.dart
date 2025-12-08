// lib/views/screens/no_internet/no_internet_screen.dart

import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Qaytish tugmasini o'chirib qo'yamiz, chunki ulanish qaytganda avtomatik qaytamiz
    return const PopScope(
      canPop: false, // Foydalanuvchi Back tugmasi bilan chiqib keta olmaydi
      child: Scaffold(
        backgroundColor: Color(0xFFE53935), // Qizil rang
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 90, color: Colors.white),
              SizedBox(height: 30),
              Text(
                'Ulanish Uzildi!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Internet ulanishingizni tekshiring.',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}