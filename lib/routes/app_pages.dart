// lib/routes/app_pages.dart
import 'package:bvmsapp2/modules/auth/bindings/forgot_password_binding.dart';
import 'package:bvmsapp2/modules/auth/views/forgot_password_view.dart';
import 'package:bvmsapp2/modules/home/views/incident_report_view.dart';
import 'package:get/get.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/bindings/home_binding.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/forgot_password',
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => HomeView(),
      binding: HomeBinding(),
      // Add home binding here if needed
    ),
  ];
}
