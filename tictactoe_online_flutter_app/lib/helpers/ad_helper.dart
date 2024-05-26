import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../controllers/native_ad_controller.dart';

import '../widgets/my_dialogs.dart';

/* Configuration for Google Mobile Ads SDK

https://docs.flutter.dev/cookbook/plugins/google-mobile-ads

*) Android:

In Manifest file (eg. android/app/src/main/AndroidManifest.xml):

    <uses-permission android:name="android.permission.INTERNET"/>

    <!-- Ads Permission for Android 12 or higher -->
    <uses-permission android:name="com.google.android.gms.permission.AD_ID"/>

    <application android:label="${applicationName}" android:name="${applicationName}" android:icon="@mipmap/launcher_icon">
        <meta-data android:name="com.google.android.gms.ads.APPLICATION_ID" android:value="ca-app-pub-8259451733265123~8439662918" />


*) iOS:

In Info.plist file (eg. ios/Runner/Info.plist):

    <key>GADApplicationIdentifier</key>
    <string>ca-app-pub-3940256099942544~1458002511</string>



*) Main.dart file:
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AdHelper.initAds();
  runApp(const MyApp());
}

*/

class AdHelper {
  // for initializing ads sdk
  static Future<void> initAds() async {
    if (kIsWeb || !GetPlatform.isMobile) return;

    await MobileAds.instance.initialize();

    AdHelper.precacheInterstitialAd();
    AdHelper.precacheNativeAd();
    AdHelper.precacheBannerAd();
  }

//TODO: Update Ad Ids here with your own Ad Ids
  static String interstitialAd = "ca-app-pub-8259451733265123/3514639292";
  static String nativeAd = "ca-app-pub-8259451733265123/8439662918";
  static String rewardedAd = "ca-app-pub-8259451733265123/9696904266";
  static String bannerAdAndroid = "ca-app-pub-8259451733265123/2257397942";
  static String bannerAdIOS = "ca-app-pub-4466121461805518/5066033308";

  //*****************Ads Status******************
  static bool get _showAd => GetPlatform.isMobile;
  static bool get hideAds => !_showAd;

  static String get bannerAdId =>
      (!kIsWeb && Platform.isAndroid) ? bannerAdAndroid : bannerAdIOS;

  static InterstitialAd? _interstitialAd;
  static bool _interstitialAdLoaded = false;

  static NativeAd? _nativeAd;
  static bool _nativeAdLoaded = false;

  //static BannerAd? _bannerAd;
  //static bool _bannerAdLoaded = false;

  //***************************************************
  //*****************Banner Ad******************
  static void precacheBannerAd() {
    log('Precache Banner Ad - Id: $bannerAdId');

    if (hideAds) return;

    BannerAd(
      adUnitId: bannerAdId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('$BannerAd loaded.');
          //_bannerAdLoaded = true;
        },
        onAdFailedToLoad: (ad, error) {
          log('$BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    ).load();
  }

  //******************************************************
  //*****************Interstitial Ad******************

  static void precacheInterstitialAd() {
    log('Precache Interstitial Ad - Id: $interstitialAd');

    if (hideAds) return;

    InterstitialAd.load(
      adUnitId: interstitialAd,
      //adUnitId: 'ca-app-pub-4466121461805518/4533247509',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          //ad listener
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            _resetInterstitialAd();
            precacheInterstitialAd();
          });
          _interstitialAd = ad;
          _interstitialAdLoaded = true;
        },
        onAdFailedToLoad: (err) {
          _resetInterstitialAd();
          log('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  static void _resetInterstitialAd() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _interstitialAdLoaded = false;
  }

  static void showInterstitialAd({required VoidCallback onComplete}) {
    log('Interstitial Ad Id: $interstitialAd');

    if (hideAds) {
      onComplete();
      return;
    }

    if (_interstitialAdLoaded && _interstitialAd != null) {
      _interstitialAd?.show();
      onComplete();
      return;
    }

    MyDialogs.showProgress();

    InterstitialAd.load(
      adUnitId: interstitialAd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          //ad listener
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            onComplete();
            _resetInterstitialAd();
            precacheInterstitialAd();
          });
          Get.back();
          ad.show();
        },
        onAdFailedToLoad: (err) {
          Get.back();
          log('Failed to load an interstitial ad: ${err.message}');
          onComplete();
        },
      ),
    );
  }

  //**********************************************
  //*****************Native Ad******************

  static void precacheNativeAd() {
    log('Precache Native Ad - Id: $nativeAd');

    //if (hideAds) return;

    _nativeAd = NativeAd(
        adUnitId: nativeAd,
        //adUnitId: 'ca-app-pub-4466121461805518/8078375300',
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            _nativeAdLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.small))
      ..load();
  }

  static void _resetNativeAd() {
    _nativeAd?.dispose();
    _nativeAd = null;
    _nativeAdLoaded = false;
  }

  static NativeAd? loadNativeAd({required NativeAdController adController}) {
    log('Native Ad Id: $nativeAd');

    if (hideAds) return null;

    if (_nativeAdLoaded && _nativeAd != null) {
      adController.adLoaded.value = true;
      return _nativeAd;
    }

    return NativeAd(
        adUnitId: nativeAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            adController.adLoaded.value = true;
            _resetNativeAd();
            precacheNativeAd();
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.small))
      ..load();
  }

  //**********************************************
  //*****************Rewarded Ad******************

  static void showRewardedAd({required VoidCallback onComplete}) {
    log('Rewarded Ad Id: $rewardedAd');

    if (hideAds) {
      onComplete();
      return;
    }

    MyDialogs.showProgress();

    RewardedAd.load(
      adUnitId: rewardedAd,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          Get.back();

          //reward listener
          ad.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
            onComplete();
          });
        },
        onAdFailedToLoad: (err) {
          Get.back();
          log('Failed to load an interstitial ad: ${err.message}');
          // onComplete();
        },
      ),
    );
  }
}
