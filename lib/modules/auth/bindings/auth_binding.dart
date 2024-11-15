// lib/modules/auth/bindings/auth_binding.dart
import 'package:bvmsapp2/modules/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize AuthController when this module is accessed
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
