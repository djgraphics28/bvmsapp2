import 'package:bvmsapp2/modules/home/controllers/dashboard_controller.dart';
import 'package:bvmsapp2/modules/home/controllers/incident_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class IncidentReportView extends StatelessWidget {
    final IncidentController incidentController = Get.put(IncidentController());

  @override
  Widget build(BuildContext context) {
    incidentController.fetchDropdownData();

    final DashboardController controller =
        Get.put(DashboardController(), permanent: true);
    
         void _showIncidentReportModal(BuildContext context) async {

    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController userIdController = TextEditingController();

    String? selectedPriority;
    String? selectedType;
    String? selectedStatus;
    int? selectedCategoryId;
    LatLng selectedLocation;
    Location location = Location();

    // Get the current location
    PermissionStatus permissionGranted = await location.requestPermission();
    LocationData locationData = await location.getLocation();

    selectedLocation =
        LatLng(locationData.latitude!, locationData.longitude!);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Obx(() => Container(
              height: 800, // Increased height to accommodate the map
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Submit Incident Report',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 200, // Height of the map widget
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: selectedLocation,
                          zoom: 14,
                        ),
                        onTap: (LatLng position) {
                          selectedLocation = position;
                          locationController.text =
                              '${selectedLocation.latitude}, ${selectedLocation.longitude}';
                        },
                        markers: {
                          Marker(
                            markerId: const MarkerId('selected-location'),
                            position: selectedLocation,
                          ),
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        labelText: 'Location (Selected from Map)',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true, // Prevent manual editing
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedPriority,
                      onChanged: (value) => selectedPriority = value,
                      items: incidentController.priorities
                          .map((priority) => DropdownMenuItem(
                                value: priority,
                                child: Text(priority),
                              ))
                          .toList(),
                      decoration: const InputDecoration(
                        labelText: 'Priority',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      onChanged: (value) => selectedType = value,
                      items: incidentController.types
                          .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ))
                          .toList(),
                      decoration: const InputDecoration(
                        labelText: 'Type',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      onChanged: (value) => selectedStatus = value,
                      items: incidentController.statuses
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<int>(
                      value: selectedCategoryId,
                      onChanged: (value) => selectedCategoryId = value,
                      items: incidentController.categories
                          .map((category) => DropdownMenuItem(
                                value: category['id'] as int,
                                child: Text(category['name'] as String),
                              ))
                          .toList(),
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    // const SizedBox(height: 10),
                    // TextField(
                    //   controller: userIdController,
                    //   decoration: const InputDecoration(
                    //     labelText: 'User ID',
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   keyboardType: TextInputType.number,
                    // ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        final incidentData = {
                          "title": titleController.text,
                          "description": descriptionController.text,
                          "location": locationController.text,
                          "priority": selectedPriority?.toLowerCase(),
                          "type": selectedType?.toLowerCase(),
                          "status": selectedStatus?.toLowerCase(),
                          "incident_category_id": selectedCategoryId,
                          "user_id":
                              int.tryParse(userIdController.text) ?? 0,
                        };
                        incidentController.submitIncident(incidentData);
                        Navigator.pop(context); // Close modal
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
    }

    // Get count of incidents by status
    int getCountByStatus(String status) {
      return controller.incidents
          .where((incident) => incident["status"] == status)
          .toList()
          .length;
    }

    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Incident Reports'),
        ),
        body: Column(
          children: [
            // TabBar outside the AppBar
            Container(
              child: TabBar(
                isScrollable: true, // Enable scrolling for tabs
                tabs: [
                  Tab(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Text('All'),
                        Positioned(
                          top: -6,
                          right: -20,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: Text(
                              controller.incidents.length.toString(),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Text('Unresolved'),
                        Positioned(
                          top: -6,
                          right: -20,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.orange,
                            child: Text(
                              getCountByStatus("Unresolved").toString(),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Text('Resolved'),
                        Positioned(
                          top: -6,
                          right: -20,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.green,
                            child: Text(
                              getCountByStatus("Resolved").toString(),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Text('In Progress'),
                        Positioned(
                          top: -6,
                          right: -20,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.blue,
                            child: Text(
                              getCountByStatus("In Progress").toString(),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() {
                    return ListView.builder(
                      itemCount: controller.incidents.length,
                      itemBuilder: (context, index) {
                        var incident = controller.incidents[index];
                        return GestureDetector(
                          onTap: () {
                            print('Tapped on Incident: ${incident["title"]}');
                          },
                          child: Card(
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.red[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.report,
                                      size: 36,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          incident["title"]!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Vehicle: ${incident["vehicle"]}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'Date: ${incident["date"]}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'Status: ${incident["status"]}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  Obx(() {
                    var unresolvedIncidents = controller.incidents
                        .where((incident) => incident["status"] == "Unresolved")
                        .toList();
                    return ListView.builder(
                      itemCount: unresolvedIncidents.length,
                      itemBuilder: (context, index) {
                        var incident = unresolvedIncidents[index];
                        return GestureDetector(
                          onTap: () {
                            print('Tapped on Incident: ${incident["title"]}');
                          },
                          child: Card(
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.report_problem,
                                      size: 36,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          incident["title"]!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Vehicle: ${incident["vehicle"]}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'Date: ${incident["date"]}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'Status: ${incident["status"]}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  Obx(() {
                    var resolvedIncidents = controller.incidents
                        .where((incident) => incident["status"] == "Resolved")
                        .toList();
                    return ListView.builder(
                      itemCount: resolvedIncidents.length,
                      itemBuilder: (context, index) {
                        var incident = resolvedIncidents[index];
                        return GestureDetector(
                          onTap: () {
                            print('Tapped on Incident: ${incident["title"]}');
                          },
                          child: Card(
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.green[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.check_circle,
                                      size: 36,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          incident["title"]!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Vehicle: ${incident["vehicle"]}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'Date: ${incident["date"]}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'Status: ${incident["status"]}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  Obx(() {
                    var inProgressIncidents = controller.incidents
                        .where(
                            (incident) => incident["status"] == "In Progress")
                        .toList();
                    return ListView.builder(
                      itemCount: inProgressIncidents.length,
                      itemBuilder: (context, index) {
                        var incident = inProgressIncidents[index];
                        return GestureDetector(
                          onTap: () {
                            print('Tapped on Incident: ${incident["title"]}');
                          },
                          child: Card(
                            elevation: 5,
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.loop,
                                      size: 36,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          incident["title"]!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Vehicle: ${incident["vehicle"]}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'Date: ${incident["date"]}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          'Status: ${incident["status"]}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
     floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showIncidentReportModal(context); // Pass context explicitly
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
