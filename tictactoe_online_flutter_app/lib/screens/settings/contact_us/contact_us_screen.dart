import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/assets.dart';
import '../../../constants/constants.dart';
import '../../../controllers/settings_controller.dart';
import '../../../translations/messages.dart';
import '../../../widgets/ad_banner.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Messages.contactUs.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 600.0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.lottieJsonSupport2, height: 280),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: Text(Messages.email.tr),
                    onTap: () {
                      // Add your email address handling logic here
                      ToolsController.launchUrlWithApp(
                          Constants.developerEmail);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text(Messages.call.tr),
                    onTap: () {
                      // Add your phone number handling logic here
                      ToolsController.launchUrlWithApp(
                          Constants.developerPhone);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.message),
                    title: Text(Messages.whatsApp.tr),
                    onTap: () {
                      // Add your WhatsApp number handling logic here
                      ToolsController.launchUrlWithApp(Constants.contactUs);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(Messages.visitOurWebsite.tr),
                    onTap: () {
                      // Add your website URL handling logic here
                      ToolsController.launchUrlWithApp(Constants.website);
                    },
                  ),
                  const Spacer(),
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
