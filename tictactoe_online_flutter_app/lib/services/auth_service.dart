import 'package:get/get.dart';

import 'local_storage_service.dart';

class AuthService extends GetxService {
  static AuthService get instance => Get.find();

  /// Mocks a login process
  final isLoggedIn = false.obs;
  bool get isLoggedInValue => localStorageService.getIsLoggedIn();

  LocalStorageService localStorageService = LocalStorageService.instance;

  Future<AuthService> init() async {
    return this;
  }

  void login() {
    isLoggedIn.value = true;
    localStorageService.saveIsLoggedIn(isLoggedIn.value);
  }

  void logout() {
    isLoggedIn.value = false;
    localStorageService.saveIsLoggedIn(isLoggedIn.value);
  }
}
