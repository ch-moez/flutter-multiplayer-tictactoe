import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/keys.dart';

class LocalStorageService extends GetxService {
  //Singleton
  static LocalStorageService get instance => Get.find();

  late SharedPreferences _pref;

  RxBool isDark = false.obs;
  RxString token = ''.obs;
  RxString selectedLanguage = 'en_US'.obs;
  RxBool receiveNotification = true.obs;

  Future<LocalStorageService> init() async {
    _pref = await SharedPreferences.getInstance();
    await getAllStoredValues();
    return this;
  }

  getAllStoredValues() {
    token = _pref.getString(Keys.token.name)?.obs ?? ''.obs;
    isDark = (null == _pref.getBool(Keys.isDarkTheme.name))
        ? false.obs
        : _pref.getBool(Keys.isDarkTheme.name)!.obs;

    selectedLanguage = getSelectedLanguage().obs;

    receiveNotification = (null == _pref.getBool(Keys.receiveNotification.name))
        ? true.obs
        : _pref.getBool(Keys.receiveNotification.name)!.obs;

    Get.forceAppUpdate();
  }

  setValue(Keys key, dynamic value) {
    switch (value.runtimeType) {
      case List:
        _pref.setStringList(key.name, value);
        break;
      case String:
        _pref.setString(key.name, value);
        break;
      case bool:
        _pref.setBool(key.name, value);
        break;
      case int:
        _pref.setInt(key.name, value);
        break;
      case double:
        _pref.setDouble(key.name, value);
        break;
      default:
        break;
    }

    getAllStoredValues();
    debugPrint(
        'pref.setValue key ${value.runtimeType}: ${key.name} value : $value');
  }

  String getSelectedLanguage() {
    return _pref.getString(Keys.selectedLanguage.name) ?? 'en_US';
  }

  void saveSelectedLanguage(String language) async {
    await _pref.setString(Keys.selectedLanguage.name, language);
  }

  bool getIsLoggedIn() {
    return _pref.getBool(Keys.isLoggedIn.name) ?? false;
  }

  void saveIsLoggedIn(bool isLoggedIn) async {
    await _pref.setBool(Keys.isLoggedIn.name, isLoggedIn);
  }

  Future<bool> setString(String key, String value) async {
    return await _pref.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _pref.setBool(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await _pref.setInt(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _pref.setDouble(key, value);
  }

  Future<bool> setList(String key, List<String> value) async {
    return await _pref.setStringList(key, value);
  }

  Future<String?> getString(String key) async {
    return _pref.getString(key);
  }

  Future<bool?> getBool(String key) async {
    return _pref.getBool(key);
  }

  Future<int?> getInt(String key) async {
    return _pref.getInt(key);
  }

  Future<double?> getDouble(String key) async {
    return _pref.getDouble(key);
  }

  Future<List<String>?> getList(String key) async {
    return _pref.getStringList(key);
  }
}
