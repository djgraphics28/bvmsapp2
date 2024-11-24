// lib/modules/auth/views/login_view.dart
import 'package:bvmsapp2/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bvmsapp2/modules/auth/widgets/custom_login_button.dart';

class LoginView extends StatelessWidget {
  // Using GetX dependency injection to find the controller
  final AuthController controller = Get.find<AuthController>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo and Title
                Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png', // Make sure you have a logo in assets folder
                      height: 120,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Barangay Vehicle Monitoring System',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 7, 28, 83),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Login Form in a Card
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // Email Input
                     
                        const SizedBox(height: 16),

                        // Password Input
                          TextField(
                          controller: controller.emailController,
                          onChanged: (value) => controller.email.value = value,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Password Input
                        TextField(
                          controller: controller.passwordController,
                          onChanged: (value) =>
                              controller.password.value = value,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(),
                          ),
                        ),
               
                        const SizedBox(height: 8),

                        // Forgot Password Link
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Implement forgot password functionality
                              Get.toNamed('/forgot_password');
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.deepPurpleAccent),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Login Button
                        Obx(() {
                          return CustomLoginButton(
                            isLoading: controller.isLoading.value, // Pass the loading state to the button
                            onPressed: controller.isLoading.value
                                ? () {} // Provide an empty function when loading (button is disabled)
                                : () {
                                    // Grab the email and password from the reactive variables
                                    String email = controller.email.value;
                                    String password = controller.password.value;
                                    // Call the controller's login method
                                    controller.login();
                                  },
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
