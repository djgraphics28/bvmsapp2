// lib/modules/home/views/profile_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart'; // Assuming you have a controller for this

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  // Initialize the controller
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Info'),
        automaticallyImplyLeading: false, // Disable the back button
        actions: [
          // Edit button for toggling between edit and view modes
          IconButton(
            icon: Obx(() => Icon(
                  controller.isEditMode.value ? Icons.check : Icons.edit,
                )),
            onPressed: () {
              controller.toggleEditMode(); // Toggle edit mode
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile picture (top)
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'assets/images/user.png'), // Ensure the image path is correct
                ),
              ),

              const SizedBox(height: 20),

              // First Name
              _buildProfileField('First Name', controller.firstNameController,
                  controller.isEditMode.value),
              const SizedBox(height: 16),

              // Middle Name
              _buildProfileField('Middle Name', controller.middleNameController,
                  controller.isEditMode.value),
              const SizedBox(height: 16),

              // Last Name
              _buildProfileField('Last Name', controller.lastNameController,
                  controller.isEditMode.value),
              const SizedBox(height: 16),

              // Gender
              _buildProfileField('Gender', controller.genderController,
                  controller.isEditMode.value),
              const SizedBox(height: 16),

              // Birth Date
              _buildProfileField('Birth Date', controller.birthDateController,
                  controller.isEditMode.value),
              const SizedBox(height: 16),

              // Update button when in edit mode
              if (controller.isEditMode.value)
                ElevatedButton(
                  onPressed: controller.updateProfile,
                  child: const Text('Update Profile'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build each editable or non-editable field
  Widget _buildProfileField(
      String label, TextEditingController controller, bool isEditable) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        isEditable
            ? TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              )
            : Text(
                controller.text.isEmpty ? 'Not Provided' : controller.text,
                style: const TextStyle(fontSize: 16),
              ),
      ],
    );
  }
}
