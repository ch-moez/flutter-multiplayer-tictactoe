import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/assets.dart';
import '../../../controllers/native_ad_controller.dart';
import '../../../helpers/ad_helper.dart';
import '../../../services/local_storage_service.dart';
import '../../../services/settings_service.dart';
import '../../../translations/messages.dart';
import '../../../widgets/ad_banner.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  NativeAdController nativeAdController = Get.put(NativeAdController());

  @override
  Widget build(BuildContext context) {
    nativeAdController.ad =
        AdHelper.loadNativeAd(adController: nativeAdController);

    SettingsService settingsService = SettingsService.instance;

    LocalStorageService localStorageService = LocalStorageService.instance;

    //AdHelper.showInterstitialAd(onComplete: () {});

    return Scaffold(
      appBar: AppBar(
        title: Text(Messages.notification.tr),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: SizedBox(
          width: 600.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //AdBanner(),
              //const Spacer(),
              SizedBox(
                height: 350,
                child:
                    Lottie.asset(Assets.lottieJsonNotifications, height: 350),
              ),
              const SizedBox(height: 30),
              Text(
                Messages.receiveNotification.tr,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: Text(
                  Messages.receiveNotificationMessage.tr,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              Obx(
                () => SwitchListTile(
                  title: Text(Messages.notification.tr),
                  activeColor: Colors.orange,
                  secondary: const Icon(Icons.notifications_active),
                  value: localStorageService.receiveNotification.value,
                  onChanged: (bool value) {
                    settingsService.setReceiveNotification(value);
                  },
                ),
              ),
              const Divider(),
              const Spacer(),
              nativeAdController.ad != null &&
                      nativeAdController.adLoaded.isTrue
                  ? SafeArea(
                      child: SizedBox(
                          height: 110,
                          child: AdWidget(ad: nativeAdController.ad!)))
                  : AdBanner(adSize: AdSize.largeBanner),
            ],
          ),
        ),
      ),
    );
  }
}
