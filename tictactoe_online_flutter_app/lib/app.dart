import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/constants.dart';

import 'screens/main_menu_screen.dart';
import 'services/local_storage_service.dart';
import 'services/settings_service.dart';
import 'translations/messages.dart';
import 'util/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocalStorageService localStorageService = LocalStorageService.instance;
    SettingsService settingsService = SettingsService.instance;

    return GetMaterialApp(
      title: Constants.appTitle,

      themeMode:
          localStorageService.isDark.value ? ThemeMode.dark : ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      debugShowCheckedModeBanner: false,
      translations: Messages(), // your translations
      locale: settingsService.selectedLocale,
      fallbackLocale: const Locale('en', 'US'),

      home: MainMenuScreen(),
    );
  }
}
