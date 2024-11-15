import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Observables for Profile Data
  var isEditMode = false.obs;
  var firstNameController = TextEditingController();
  var middleNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var genderController = TextEditingController();
  var birthDateController = TextEditingController();

  // Profile Picture URL
  var profilePicUrl = "https://example.com/profile-pic.jpg".obs;

  // Function to toggle edit mode
  void toggleEditMode() {
    isEditMode.value = !isEditMode.value;
    if (isEditMode.value) {
      // When edit mode is activated, we populate controllers with data (if available)
      firstNameController.text = "John"; // Example data, populate with actual data
      middleNameController.text = "Doe"; // Example data, populate with actual data
      lastNameController.text = "Smith"; // Example data, populate with actual data
      genderController.text = "Male"; // Example data, populate with actual data
      birthDateController.text = "1990-01-01"; // Example data, populate with actual data
    }
  }

  // Function to update the profile (this should save the data)
  void updateProfile() {
    // Logic for updating profile
    print("Profile updated with:");
    print("First Name: ${firstNameController.text}");
    print("Middle Name: ${middleNameController.text}");
    print("Last Name: ${lastNameController.text}");
    print("Gender: ${genderController.text}");
    print("Birth Date: ${birthDateController.text}");
    // Here you would save the updated data
  }
}
