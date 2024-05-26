import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/local_storage_service.dart';
import '../services/settings_service.dart';

class SwitchWidget extends GetView<LocalStorageService> {
  SwitchWidget({super.key});

  SettingsService settingsService = Get.put<SettingsService>(SettingsService());
  LocalStorageService localStorageService =
      Get.put<LocalStorageService>(LocalStorageService());

  //bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Switch(
        value: controller.isDark.value,
        activeColor: Colors.red,
        onChanged: (bool value) {
          settingsService.changeTheme();
          //isSelected = controller.isDark.value;
        },
      ),
    );
  }
}
