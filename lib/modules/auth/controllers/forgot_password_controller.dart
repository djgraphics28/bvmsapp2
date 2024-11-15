// lib/modules/auth/controllers/forgot_password_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  // Controller for email input
  final emailController = TextEditingController();
  var isLoading = false.obs;

  // Method to handle forgot password logic
  Future<void> sendPasswordReset() async {
    final email = emailController.text;

    if (email.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    }

    isLoading.value = true;

    try {
      // Simulate an API call
      await Future.delayed(const Duration(seconds: 2));
      
      // After successful API call
      Get.snackbar('Success', 'Password reset link has been sent to your email');
      Get.back(); // Navigate back to the login screen
    } catch (e) {
      Get.snackbar('Error', 'Failed to send password reset link');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
