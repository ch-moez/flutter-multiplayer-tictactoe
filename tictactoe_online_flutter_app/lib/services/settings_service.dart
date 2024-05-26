import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/assets.dart';
import '../constants/keys.dart';
import 'local_storage_service.dart';

class SettingsService extends GetxService {
  //Singletons
  static SettingsService get instance => Get.find<SettingsService>();

  LocalStorageService localStorageService = LocalStorageService.instance;

  Locale selectedLocale = const Locale('en_US');

  RxString themeIcon = Assets.imagesThemeLigthIcon.obs;

  Future<SettingsService> init() async {
    selectedLocale = Locale(
        localStorageService.selectedLanguage.value.split('_')[0],
        localStorageService.selectedLanguage.value.split('_')[1]);
    return this;
  }

  void changeTheme() {
    Get.changeThemeMode(
        localStorageService.isDark.value ? ThemeMode.light : ThemeMode.dark);

    localStorageService.setValue(
        Keys.isDarkTheme, !localStorageService.isDark.value);

    themeIcon = localStorageService.isDark.value
        ? Assets.imagesThemeDarkIcon.obs
        : Assets.imagesThemeLigthIcon.obs;

    Get.forceAppUpdate();
  }

  changeLanguage(String language) {
    Get.updateLocale(Locale(language.split('_')[0], language.split('_')[1]));
    localStorageService.saveSelectedLanguage(language);
    selectedLocale = Locale(language.split('_')[0], language.split('_')[1]);
  }

  void setReceiveNotification(bool receiveNotification) {
    localStorageService.setValue(Keys.receiveNotification,
        !localStorageService.receiveNotification.value);
    //localStorageService.receiveNotification.value = !localStorageService.receiveNotification.value;
  }
}
