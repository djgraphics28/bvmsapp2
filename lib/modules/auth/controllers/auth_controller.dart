// lib/modules/auth/controllers/auth_controller.dart
import 'package:bvmsapp2/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Text controllers for form fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Observable variables for form state
  var isLoading = false.obs;
  var email = ''.obs;
  var password = ''.obs;

  // Function to handle login
  Future<void> login() async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      isLoading.value = true;

      // API call example using your API service
      final response = await ApiService.login(email.value, password.value);

      if (response != null) {
       print(response);
        // Handle successful login (e.g., navigate to Home screen)
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Error', 'Invalid email or password',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
