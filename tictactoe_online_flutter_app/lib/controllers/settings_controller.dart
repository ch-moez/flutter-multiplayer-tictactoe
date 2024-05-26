import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ToolsController extends GetxController {
  static ToolsController get instance => Get.find();

  static launchUrlWithApp(uri) async {
    final Uri url = Uri.parse(uri);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
