import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/assets.dart';
import '../../../controllers/native_ad_controller.dart';
import '../../../helpers/ad_helper.dart';

import '../../../translations/messages.dart';
import '../../../widgets/ad_banner.dart';
import '../../../widgets/language_selector.dart';

class LanguagesScreen extends StatelessWidget {
  LanguagesScreen({super.key});

  NativeAdController nativeAdController = Get.put(NativeAdController());

  @override
  Widget build(BuildContext context) {
    nativeAdController.ad =
        AdHelper.loadNativeAd(adController: nativeAdController);

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
              // AdBanner(),
              const SizedBox(height: 5),
              SizedBox(
                height: 350,
                child: Lottie.asset(Assets.lottieJsonLanguage),
              ),
              const SizedBox(height: 30),
              Text(
                Messages.changeLanguage.tr,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: Text(
                  Messages.changeLanguageMessage.tr,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(Messages.changeLanguage.tr),
                trailing: const LanguageSelector(),
                onTap: () {
                  Get.to(LanguagesScreen());
                },
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
