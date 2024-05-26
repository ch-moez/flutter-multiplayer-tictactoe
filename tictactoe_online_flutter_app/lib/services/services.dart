import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_service.dart';
import 'connectivity_service.dart';
import 'local_storage_service.dart';
import 'settings_service.dart';

Future<void> initServices() async {
  debugPrint('starting services ...');

  //await Get.putAsync(() => DbService().init());
  await Get.putAsync(() => LocalStorageService().init());
  await Get.putAsync(() => SettingsService().init());
  await Get.putAsync(() => ConnectivityService().init());
  await Get.putAsync(() => AuthService().init());
  debugPrint('All services started...');
}

class DbService extends GetxService {
  Future<DbService> init() async {
    debugPrint('$runtimeType delays 2 sec');
    await 2.delay();
    debugPrint('$runtimeType ready!');
    return this;
  }
}
