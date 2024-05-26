import 'package:flutter/material.dart';

import 'app_provider.dart';
import 'helpers/ad_helper.dart';
import 'services/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //AdHelper.initAds();

  //firebase initialization
  //await Firebase.initializeApp();

  await initServices(); // AWAIT SERVICES INITIALIZATION.

  runApp(AppProvider());
}
