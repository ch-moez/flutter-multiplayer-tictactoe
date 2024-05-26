import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../constants/constants.dart';
import '../../../controllers/settings_controller.dart';
import '../../../translations/messages.dart';
import '../../../widgets/ad_banner.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ToolsController toolsController = Get.put(ToolsController());

    return Scaffold(
      appBar: AppBar(
        title: Text(Messages.aboutUs.tr),
      ),
      body: Center(
        child: SizedBox(
          width: 600.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Welcome to Our Company!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Our company is dedicated to creating innovative and user-friendly mobile applications for our customers. We strive to provide high-quality products that enhance the user experience and make everyday tasks easier.',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Add your website URL here
                    ToolsController.launchUrlWithApp(Constants.website);
                  },
                  child: const Text('Visit Our Website'),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        // Add your Google Play URL here
                        ToolsController.launchUrlWithApp(Constants.playStore);
                      },
                      child: const Text('Google Play'),
                    ),
                    const SizedBox(width: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        // Add your App Store URL here
                        ToolsController.launchUrlWithApp(Constants.appStore);
                      },
                      child: const Text('App Store'),
                    ),
                  ],
                ),
                const Spacer(),
                AdBanner(adSize: AdSize.largeBanner),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AboutUsScreen(),
  ));
}
