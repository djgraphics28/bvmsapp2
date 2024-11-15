// lib/modules/home/controllers/dashboard_controller.dart
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:async'; // Import the Timer class

class DashboardController extends GetxController {
  var userName = "John Doe".obs; // Example user name
  var currentDateTime = DateTime.now().obs;
  var announcements = [
    "New safety measures implemented.",
    "Next inspection on Thursday.",
    "Holiday break starts next week.",
  ].obs;

  var activeVehicles = [
    {
      "vehicle": "Toyota Land Cruiser",
      "driver": "Juan Dela Cruz",
      "status": "Active",
      "location": "Barangay Hall",
    },
    {
      "vehicle": "Honda Civic",
      "driver": "Maria Santos",
      "status": "Inactive",
      "location": "Not Assigned",
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Update date and time periodically using Timer.periodic
    Timer.periodic(const Duration(seconds: 1), (timer) {
      currentDateTime.value = DateTime.now().add(Duration(hours: 8)); // Add +8 hours for GMT+8 timezone
    });
  }

  String get formattedDate {
    return DateFormat('EEEE, MMMM d, yyyy – h:mm:ss a').format(currentDateTime.value);
  }
}
