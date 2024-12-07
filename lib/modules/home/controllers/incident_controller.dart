import 'package:get/get.dart';
import 'package:bvmsapp2/core/services/api_service.dart';
import 'package:flutter/material.dart';

class IncidentController extends GetxController {
  // Observable lists for dropdown options
  var priorities = <String>[].obs;
  var types = <String>[].obs;
  var statuses = <String>[].obs;
  var categories = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  // API endpoint
  final String apiEndpoint = 'https://your-api-url.com';

  // Fetch dropdown data
  Future<void> fetchDropdownData() async {
    try {
      // Simulate API call (replace with actual API call)
      await Future.delayed(const Duration(seconds: 2));

      // Example data
      priorities.assignAll(['High', 'Medium', 'Low']);
      types.assignAll(['Request', 'Issue']);
      statuses.assignAll(['Pending', 'In Progress', 'Resolved']);
      categories.assignAll([
        {'id': 1, 'name': 'Electrical'},
        {'id': 2, 'name': 'Plumbing'},
        {'id': 3, 'name': 'General Maintenance'},
      ]);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load dropdown data');
    }
  }
 // Submit incident
  Future<void> submitIncident(Map<String, dynamic> incidentData) async {
    String token = '7|tdfiRUnRIjIcDHccAFmS7GJVsxysb5KS1EZL9xpZf8bac64d';

    try {
      isLoading.value = true; // Start loading
      print(token);
      print(incidentData);
      bool success = await ApiService.createIncidentReport(
        incidentData: incidentData
      );

      
      isLoading.value = false; // Stop loading
        print(success);

      if (success) {
        print('Incident submitted successfully');
        Get.snackbar(
          'Success',
          'Incident submitted successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        print('Failed to submit incident');
        Get.snackbar(
          'Error',
          'Failed to submit incident',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false; // Stop loading in case of error
      print('Error submitting incident: $e');
      Get.snackbar(
        'Error',
        'Error submitting incident: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

}
