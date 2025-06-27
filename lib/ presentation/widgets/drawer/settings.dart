import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:timerflow/%20presentation/providers/locale_provider.dart';
import 'package:timerflow/%20presentation/providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const List<Locale> supportedLocales = [
    Locale('uz', 'UZ'),
    Locale('ru', 'RU'),
    Locale('en', 'US'),
  ];

  static const Map<String, String> localeNames = {
    'uz_UZ': 'O‘zbek',
    'ru_RU': 'Русский',
    'en_US': 'English',
  };

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeViewModel>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLocale = localeProvider.locale;

    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
      ),
      body: ListView(
        children: [
          // 🌐 Language Picker
          ListTile(
            leading: const Icon(Icons.language),
            title: Text('language'.tr),
            trailing: DropdownButton<Locale>(
              value: supportedLocales.firstWhere(
                (locale) =>
                    locale.languageCode == currentLocale.languageCode &&
                    locale.countryCode == currentLocale.countryCode,
                orElse: () => supportedLocales.first,
              ),
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  localeProvider.setLocale(newLocale);
                  Get.updateLocale(newLocale);
                }
              },
              items: supportedLocales.map((locale) {
                final key = '${locale.languageCode}_${locale.countryCode}';
                return DropdownMenuItem<Locale>(
                  value: locale,
                  child: Text(localeNames[key]!),
                );
              }).toList(),
            ),
          ),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 12.0),
            child:  Divider(
              color: Theme.of(context).dividerColor,
            ),
          ),

          // 🌗 Dark Mode Switch
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: Text('theme_mode'.tr),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (_) => themeProvider.toggleTheme(),
            ),
          ),
        ],
      ),
    );
  }
}
