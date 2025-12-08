// lib/core/connectivity_manager.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:timerflow/views/screens/internet_check/no_internet_screen.dart';

// Global navigator key - butun ilovada navigatsiyani boshqarish uchun
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ConnectivityManager {
  // Singleton
  static final ConnectivityManager _instance = ConnectivityManager._internal();
  factory ConnectivityManager() => _instance;
  ConnectivityManager._internal();

  final InternetConnection _internetConnection = InternetConnection();
  StreamSubscription? _statusSubscription;
  bool _isShowingNoInternet = false;

  void startListening() {
    // Tinglovchini boshlashdan oldin dastlabki holatni tekshirish
    checkInitialStatus();
    
    _statusSubscription = _internetConnection.onStatusChange.listen((InternetStatus status) {
      final currentContext = navigatorKey.currentContext;
      if (currentContext == null) return;

      if (status == InternetStatus.connected) {
        // Internet qaytdi
        if (_isShowingNoInternet) {
          // NoInternetPage ustida bo'lsak, uni yopib, avvalgi sahifaga qaytamiz
          // ignore: use_build_context_synchronously
          Navigator.of(currentContext).pop(); 
          _isShowingNoInternet = false;
        }
      } else {
        // Internet uzildi
        if (!_isShowingNoInternet) {
          // Yangi sahifa sifatida NoInternetPage ni push qilamiz
          // Bu avvalgi sahifani (masalan, HomeScreen) stackda saqlab qoladi.
          // ignore: use_build_context_synchronously
          Navigator.of(currentContext).push(
            MaterialPageRoute(builder: (context) => const NoInternetScreen()),
          );
          _isShowingNoInternet = true;
        }
      }
    });
  }
  
  // Ilova ishga tushganda dastlabki holatni tekshirish
  void checkInitialStatus() async {
    final bool hasInternet = await _internetConnection.hasInternetAccess;
    if (!hasInternet) {
      // Agar ilova internet yo'q holda ochilgan bo'lsa, uni darhol tekshirish
      // Lekin bu yerda bevosita navigate qila olmaymiz, chunki context hali tayyor emas. 
      // Shuning uchun bu ishni Tinglovchiga (Listener) qoldiramiz.
    }
  }

  void dispose() {
    _statusSubscription?.cancel();
  }
}