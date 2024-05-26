import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../translations/messages.dart';
import '../../../widgets/ad_banner.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Messages.termsAndConditions.tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(26.0),
        child: Center(
            child: SizedBox(
          width: 600.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                Messages.termsAndConditions.tr,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const ExpansionTile(
                title: Text(
                    '1. You must be at least 13 years old to use this app or game.'),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Age requirement: Users must be at least 13 years old to use this app or game.'),
                  ),
                ],
              ),
              const ExpansionTile(
                title: Text(
                    '2. You agree not to engage in any illegal activities while using this app or game.'),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Prohibited activities: Users are not allowed to engage in any illegal activities while using this app or game.'),
                  ),
                ],
              ),
              const ExpansionTile(
                title: Text(
                    '3. You are responsible for maintaining the confidentiality of your account information.'),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Account security: Users are responsible for keeping their account information confidential.'),
                  ),
                ],
              ),
              const ExpansionTile(
                title: Text(
                    '4. You agree not to distribute or share any content from this app or game without permission.'),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Content sharing: Users must not distribute or share any content from the app without permission.'),
                  ),
                ],
              ),
              const ExpansionTile(
                title: Text(
                    '5. We reserve the right to suspend or terminate your account if you violate these terms and conditions.'),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Account suspension/termination: The app reserves the right to suspend or terminate accounts for violations.'),
                  ),
                ],
              ),
              const ExpansionTile(
                title: Text(
                    '6. By using this app or game, you agree to our Privacy Policy.'),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Privacy agreement: Users agree to the app\'s Privacy Policy by using the app.'),
                  ),
                ],
              ),
              const ExpansionTile(
                title: Text(
                    '7. These terms and conditions are subject to change without prior notice.'),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'Changes to terms: The terms and conditions may be updated without prior notice.'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              AdBanner(adSize: AdSize.largeBanner),
            ],
          ),
        )),
      ),
    );
  }
}
