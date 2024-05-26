import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService extends GetxService {
  bool isShowingDialog = false;

  Future<ConnectivityService> init() async {
    return this;
  }

  @override
  void onInit() async {
    super.onInit();
    var result = await Connectivity().checkConnectivity();
    if (result[0] == ConnectivityResult.none) {
      isShowingDialog = true;
      showDialog();
    }

    onConnectivityChangedListen();
  }

  checkConnectivity() async {
    if (!GetPlatform.isMobile) return ConnectivityResult.wifi;
    var result = await Connectivity().checkConnectivity();
    debugPrint('checkConnectivity : $result');
    if (result[0] == ConnectivityResult.none) {
      isShowingDialog = true;
      showDialog();
      onConnectivityChangedListen();
    }

    return result.first;
  }

  void onConnectivityChangedListen() {
    Connectivity().onConnectivityChanged.listen((event) {
      if (event.first == ConnectivityResult.none) {
        isShowingDialog = true;
        showDialog();
      } else {
        if (isShowingDialog) {
          Get.back();
          isShowingDialog = false;
        }
      }
    });
  }

  void showDialog() {
    Get.dialog(
      CupertinoAlertDialog(
          title: const Text(
              'Please turn on network connection to continue using this app'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Ok'),
              onPressed: () {
                Get.back();
                isShowingDialog = false;
              },
            ),
          ],
          content: const SizedBox.shrink()),
      barrierDismissible: false,
    );
  }
}
