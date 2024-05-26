import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:webscoket_app/screens/main_menu_screen.dart';

import '../../constants/assets.dart';
import '../../controllers/native_ad_controller.dart';
import '../../helpers/ad_helper.dart';
import '../../services/auth_service.dart';
import '../../services/settings_service.dart';
import '../../translations/messages.dart';
import '../../widgets/ad_banner.dart';
import '../../widgets/language_selector.dart';
import '../../widgets/switch.dart';

import 'about_us/about_us.dart';
import 'contact_us/contact_us_screen.dart';
import 'laguages/languages_screen.dart';
import 'notifications/notifications_screen.dart';
import 'terms_and_conditions/terms_and_conditions_screen.dart';
import 'theme/theme_screen.dart';

class SettingsScreen extends GetView<SettingsService> {
  SettingsScreen({super.key});

  final _adController = NativeAdController();

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService.instance;

    _adController.ad = AdHelper.loadNativeAd(adController: _adController);

    return Scaffold(
      appBar: AppBar(
        title: Text(Messages.settings.tr),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 600.0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //AdBanner(),
                  Lottie.asset(Assets.lottieJsonSettings, height: 180),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Icons.light_mode),
                    title: Text(Messages.changetheme.tr),
                    trailing: SwitchWidget(),
                    onTap: () => Get.to(ThemeScreen()),
                  ),
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
                  ListTile(
                    leading: const Icon(Icons.notifications_outlined),
                    title: Text(Messages.receiveNotification.tr),
                    onTap: () {
                      Get.to(NotificationsScreen());
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.list_alt),
                    title: Text(Messages.termsAndConditions.tr),
                    onTap: () {
                      Get.to(TermsAndConditionsScreen());
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: Text(Messages.aboutUs.tr),
                    onTap: () {
                      Get.to(AboutUsScreen());
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.support_agent),
                    title: Text(Messages.contactUs.tr),
                    onTap: () {
                      Get.to(const ContactUsScreen());
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: Text(Messages.signOut.tr),
                    onTap: () {
                      Get.defaultDialog(
                          title: Messages.logout.tr,
                          middleText: Messages.areYouSure.tr,
                          textConfirm: Messages.yes.tr,
                          textCancel: Messages.no.tr,
                          onConfirm: () {
                            authService.logout();
                            Get.offAll(() => MainMenuScreen());
                          },
                          onCancel: () {
                            //Get.back();
                          });
                    },
                  ),
                  const SizedBox(height: 20),
                  AdBanner(adSize: AdSize.largeBanner),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
