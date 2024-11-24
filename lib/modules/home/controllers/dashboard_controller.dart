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

  var activeVehicles = [
    {
      "vehicle": "Toyota Land Cruiser",
      "brand": "Toyota",
      "model_name": "Land Cruiser",
      "year_model": "2023",
      "driver": "Juan Dela Cruz",
      "status": "Active",
      "plate_number": "BA9285",
      "location": "Barangay Hall",
    },
    {
      "vehicle": "L300",
      "brand": "Mitsubishi",
      "model_name": "L300",
      "year_model": "2007",
      "driver": "Maria Santos",
      "status": "Inactive",
      "plate_number": "GAB9285",
      "location": "Not Assigned",
    },
    {
      "vehicle": "L300",
      "brand": "Mitsubishi",
      "model_name": "L300",
      "year_model": "2012",
      "driver": "Maria Santos",
      "status": "Inactive",
      "plate_number": "DD9125",
      "location": "Not Assigned",
    },
    {
      "vehicle": "Toyota Vios",
      "model_name": "Toyota Vios",
      "brand": "Toyota",
      "year_model": "2017",
      "driver": "Maria Santos", 
      "status": "Inactive",
      "plate_number": "UD9285",
      "location": "Not Assigned",
    },
    {
      "vehicle": "Honda Civic",
      "brand": "Honda",
      "model_name": "Honda Civic",
      "year_model": "2019",
      "driver": "Maria Santos",
      "status": "Inactive",
      "plate_number": "UD9285",
      "location": "Not Assigned",
    },
    {
      "vehicle": "Honda Civic",
      "brand": "Honda",
      "model_name": "Honda Civic",
      "year_model": "2021",
      "driver": "Maria Santos",
      "status": "Inactive",
      "plate_number": "UD9285",
      "location": "Not Assigned",
    },
    
  ].obs;

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
  }

  String get formattedDate {
    return DateFormat('EEEE, MMMM d, yyyy – h:mm:ss a').format(currentDateTime.value);
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
    String? token = '21|pUgLKWZmgQiqsdhZkdvFaWq1K3PHeCAcImZpGrvm938843fd'; // Replace with actual token

    // Fetch incidents
    var fetchedIncidents = await ApiService.getIncidents(page: 1, perPage: 10, token: token);

    if (fetchedIncidents != null) {
      incidents.value = fetchedIncidents; // Now you can use .value to update the list
      print('Incidents fetched successfully');
      print(fetchedIncidents);
    } else {
      print('Failed to fetch incidents');
    }
  }




}
