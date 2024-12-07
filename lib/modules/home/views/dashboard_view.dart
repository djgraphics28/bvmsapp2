import 'package:bvmsapp2/modules/home/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'vehicle_info.dart';
import 'incident_report_view.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Register the controller here
    final DashboardController controller = Get.put(DashboardController());

    print(controller);
    print(controller.activeVehicles);
    return Scaffold(
  
      body: SingleChildScrollView(  // Make the entire body scrollable
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Vehicle and Incident Cards
              // Membership Container
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Card 1: Incidents
                              Expanded(
                                child: Container(
                                  height: 120,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.purple[600],
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total no.',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '212',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 27.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Available Vehicles',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),

                              // Card 2: Due Vehicles
                          Expanded(
              child: Container(
                height: 120,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 236, 88, 3),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total no.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Use Obx() to bind totalIncidents and make it reactive
                        Obx(() => Text(
                              '${controller.totalIncidents.value}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 27.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Incident Reports',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
                            ],
                          ),
           const SizedBox(height: 20),

          // Title for Incident Reports Section with "See All" button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Incident Reports Title
              const Text(
                'Incident Reports:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              // "See All" TextButton on the right
              TextButton(
                onPressed: () {
                  // Action to navigate or show more incidents
                     Get.to(() => IncidentReportView());
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),


              // List of Top 5 Incident Reports
              Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.incidents.length > 5
                      ? 5
                      : controller.incidents.length,
                  itemBuilder: (context, index) {
                    var incident = controller.incidents[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to incident details page or show modal
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
                              // Icon for Incident
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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

              const SizedBox(height: 20),

              // Title for Active Vehicles Section
              const Text(
                'Active Vehicles and Drivers:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              // List of Top 5 Active Vehicles
              Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.activeVehicles.length > 5
                      ? 5
                      : controller.activeVehicles.length,
                  itemBuilder: (context, index) {
                    var vehicle = controller.activeVehicles[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => VehicleInfoScreen(
                            vehicle: vehicle.map((key, value) =>
                                MapEntry(key, value.toString()))));
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
                                    // Vehicle Photo
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.purple[100],
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          image: NetworkImage(vehicle["photo"] ?? ""),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            vehicle["brand"] ?? "Unknown Brand",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Model: ${vehicle["model"] ?? "Unknown Model"}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            'Plate: ${vehicle["plate_number"] ?? "N/A"}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            'Status: ${vehicle["status"] ?? "N/A"}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: vehicle["status"] == "working"
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                          Text(
                                            'Location: ${vehicle["barangay"] ?? "Unknown"}',
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
      ),
    );
  }
}
