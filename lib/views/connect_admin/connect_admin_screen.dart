import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectAdminPage extends StatelessWidget {
  const ConnectAdminPage({super.key});

  // Telegram link
  final String telegramUrl = "https://t.me/mirvohid";

  void _launchTelegram() async {
    if (await canLaunchUrl(Uri.parse(telegramUrl))) {
      await launchUrl(Uri.parse(telegramUrl), mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $telegramUrl");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive layout
          double width = constraints.maxWidth;
          double padding = width > 900
              ? 100
              : width > 600
                  ? 50
                  : 20;
          double fontSize = width > 900
              ? 36
              : width > 600
                  ? 28
                  : 22;
          double buttonWidth = width > 900
              ? 300
              : width > 600
                  ? 250
                  : 200;
          double buttonHeight = width > 900
              ? 60
              : width > 600
                  ? 50
                  : 45;

          return Center(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Connect with Admin",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton.icon(
                      onPressed: _launchTelegram,
                      icon: const Icon(Icons.telegram),
                      label: const Text("Connect"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        textStyle: TextStyle(
                          fontSize: fontSize * 0.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
