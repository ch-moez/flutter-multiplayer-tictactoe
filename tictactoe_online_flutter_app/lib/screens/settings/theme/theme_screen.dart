
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../controllers/native_ad_controller.dart';
import '../../../helpers/ad_helper.dart';
import '../../../services/local_storage_service.dart';
import '../../../services/settings_service.dart';
import '../../../translations/messages.dart';
import '../../../widgets/ad_banner.dart';

class ThemeScreen extends StatelessWidget {
  ThemeScreen({super.key});

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
        title: Text(Messages.theme.tr),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: SizedBox(
          width: 600.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SizedBox(
                height: 150,
                child: Obx(() => Image.asset(settingsService.themeIcon.value)),
              ),
              const SizedBox(height: 70),
              Text(
                Messages.changetheme.tr,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: Text(
                  Messages.changethemeMessage.tr,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: Text(Messages.themeDark.tr),
                activeColor: Colors.orange,
                secondary: const Icon(Icons.nightlight_round),
                value: localStorageService.isDark.value,
                onChanged: (bool value) {
                  settingsService.changeTheme();
                },
              ),
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
