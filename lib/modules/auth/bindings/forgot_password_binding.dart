// lib/modules/auth/bindings/forgot_password_binding.dart
import 'package:get/get.dart';
import 'package:bvmsapp2/modules/auth/controllers/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}
