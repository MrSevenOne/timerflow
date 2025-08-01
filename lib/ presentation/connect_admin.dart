import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactAdminPage extends StatelessWidget {
  const ContactAdminPage({super.key});

  final String adminPhone = '+998880814071';
  final String telegramUsername = 'raxmonbekof'; // faqat username
  final String fullName = 'Mirvoxid';

  Future<void> _openTelegramChat() async {
    final telegramUrl = Uri.parse("https://t.me/$telegramUsername");

    if (await canLaunchUrl(telegramUrl)) {
      await launchUrl(telegramUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Telegram chatni ochib bo‘lmadi");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Admin bilan bog‘lanish")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Ismi: $fullName", style: theme.textTheme.titleLarge),
            const SizedBox(height: 10),
            Text("Telefon: $adminPhone", style: theme.textTheme.titleMedium),
            const SizedBox(height: 10),
            Text("Telegram: @$telegramUsername", style: theme.textTheme.titleMedium),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _openTelegramChat,
              label: const Text("Telegram orqali bog‘lanish"),
            ),
          ],
        ),
      ),
    );
  }
}
