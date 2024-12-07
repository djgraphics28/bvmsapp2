import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:async'; // Import the Timer class
import 'package:bvmsapp2/core/services/api_service.dart';
class DashboardController extends GetxController {
  var userName = "John Doe".obs; // Example user name
  var currentDateTime = DateTime.now().obs;
  var totalIncidents = 0.obs;  // Reactive variable to hold the total incident count
  var announcements = [
    // "New safety measures implemented.",
    // "Next inspection on Thursday.",
    // "Holiday break starts next week.",
  ].obs;

  var activeVehicles = <Map<String, dynamic>>[].obs; // Initialize as an empty reactive list

  // Filter by "All", "Active", or "Inactive"
  var selectedFilter = "All".obs;

  // Reactive list for storing incidents
  RxList<Map<String, dynamic>> incidents = <Map<String, dynamic>>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    // Update date and time periodically using Timer.periodic
    Timer.periodic(const Duration(seconds: 1), (timer) {
      currentDateTime.value = DateTime.now().add(Duration(hours: 8)); // Add +8 hours for GMT+8 timezone
    });

    // Watch for changes in the selected filter
    ever(selectedFilter, (_) {
      updateVehicleFilter();
    });

      fetchIncidents();
      fetchVehicles();
  }

  String get formattedDate {
    return DateFormat('EEEE, MMMM d, yyyy – h:mm:ss a').format(currentDateTime.value);
  }

   void fetchVehicles() async {
    String? token = '11|d8levdfAnMO8bkL0CpLre12xwb4osadR5hIXxOIA3607a4db'; // Replace with actual token

    var fetchedVehicles = await ApiService.getVehicles();

    print(fetchedVehicles);
    if (fetchedVehicles != null) {
      activeVehicles.value = fetchedVehicles;
      print('Vehicles fetched successfully');
    } else {
      print('Failed to fetch vehicles');
    }
  }

  // Filter active vehicles based on selected filter
  void updateVehicleFilter() {
    // Update the activeVehicles list based on the selected filter
    if (selectedFilter.value == "All") {
      // Show all vehicles
      activeVehicles.value = [
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
        // ... all other vehicles
      ]; // Reset the list to the full list of vehicles
    } else {
      // Filter vehicles based on status
      activeVehicles.value = activeVehicles.where((vehicle) {
        return vehicle['status'] == selectedFilter.value;
      }).toList();
    }
  }
  void fetchIncidents() async {
    String? token = '21|C04USeKriQxx38kTe6N9Ap0I1q5lnVRbBEQ0hHyW0bcf1fb8'; // Replace with actual token

    // Fetch incidents
    var fetchedIncidents = await ApiService.getIncidents(page: 1, perPage: 10);
      print(fetchedIncidents);

    if (fetchedIncidents != null) {
      incidents.value = fetchedIncidents; // Now you can use .value to update the list
      print('Incidents fetched successfully');
      print(fetchedIncidents);
    } else {
      print('Failed to fetch incidents');
    }
  }




}
