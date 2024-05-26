import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/settings_service.dart';
import '../translations/messages.dart';

class LanguageSelector extends GetView<SettingsService> {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: Messages.languagesList[Get.locale.toString()],
      items: Messages.languageList
          .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
      onChanged: (String? newValue) {
        Messages.languagesList.forEach((k, v) {
          if (v == newValue) {
            //Get.updateLocale(Locale(k.split('_')[0], k.split('_')[1]));
            controller.changeLanguage(k);
            return;
          }
        });
      },
    );
  }
}
