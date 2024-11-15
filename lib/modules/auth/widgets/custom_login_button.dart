// lib/modules/auth/widgets/custom_login_button.dart
import 'package:flutter/material.dart';

class CustomLoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const CustomLoginButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 16),
        backgroundColor: Colors.green[400],
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text('Login'),
    );
  }
}
