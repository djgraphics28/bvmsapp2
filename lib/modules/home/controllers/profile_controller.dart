import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bvmsapp2/core/services/api_service.dart';
import 'package:intl/intl.dart';

class ProfileController extends GetxController {
  var isEditMode = false.obs;
  var isLoading = true.obs;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var userTypeController = TextEditingController();
  var createdAtController = TextEditingController();
  var profilePicUrl = "https://example.com/profile-pic.jpg".obs;

  // Function to toggle edit mode
  void toggleEditMode() {
    isEditMode.value = !isEditMode.value;
    if (isEditMode.value) {
      // Populate controllers with data when in edit mode
      firstNameController.text = "John";
      lastNameController.text = "Doe";
      emailController.text = "john.doe@example.com";
      userTypeController.text = "Admin";
      createdAtController.text = "2024-01-01";
    }
  }

  // Fetch Profile data
  void fetchProfile(String token) async {
    try {
      var profile = await ApiService.getProfile();

      print(profile);
      if (profile != null) {
        // If profile data is available, populate the controllers
        var nameParts = profile['name']?.split(' ') ?? [];
        firstNameController.text = nameParts.isNotEmpty ? nameParts[0] : '';
        lastNameController.text = nameParts.length > 1 ? nameParts.last : '';
        emailController.text = profile['email'] ?? '';
        userTypeController.text = profile['user_type'] ?? '';
        profilePicUrl.value = profile['profile_pic_url'] ?? "https://example.com/default-pic.jpg";

        // Format the created_at date into a human-readable format
        if (profile['created_at'] != null) {
          var createdAt = DateTime.parse(profile['created_at']);
          createdAtController.text = DateFormat('yyyy-MM-dd').format(createdAt);
        }
      } else {
        print("Failed to fetch profile data");
      }
    } catch (e) {
      print("Error fetching profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // onInit method to initialize when the controller is created
  @override
  void onInit() {
    super.onInit();
    String token = "7|tdfiRUnRIjIcDHccAFmS7GJVsxysb5KS1EZL9xpZf8bac64d";  // You should retrieve this token dynamically
    fetchProfile(token);
  }

  // Method to update the profile
  void updateProfile() {
    // Collect the data from the controllers
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String email = emailController.text;
    String userType = userTypeController.text;

    // Print the collected data (replace this with actual API call)
    print("Profile updated with:");
    print("First Name: $firstName");
    print("Last Name: $lastName");
    print("Email: $email");
    print("User Type: $userType");

    // You would send updated data to the server via an API service
    // Example:
    // ApiService.updateProfile(firstName, lastName, email, userType);
  }
}
