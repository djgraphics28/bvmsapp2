import 'package:bvmsapp2/modules/home/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'vehicle_info.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Register the controller here
    final DashboardController controller = Get.put(DashboardController());

    return DefaultTabController(
      length: 2, // Define the number of tabs
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              // TabBarView Section
              Expanded(
                child: TabBarView(
                  children: [
                    // First Tab: Dashboard Content
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Welcome Section
                          Obx(() => Text(
                                'Hello! ${controller.userName.value}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 41, 16, 151),
                                ),
                              )),
                          const SizedBox(height: 10),

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
                                    color: Colors.purple[900],
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
                                            '2',
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
                                            'Active Vehicles',
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
                          const SizedBox(height: 10),

                          // Date and Time Section
                          Obx(() => Text(
                                'Today is ${controller.formattedDate}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              )),
                          const SizedBox(height: 20),

                          // Announcements
                          Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: controller.announcements
                                    .map((announcement) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                                vertical: 12.0),
                                            decoration: BoxDecoration(
                                              color: Colors.purple[50],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  spreadRadius: 2,
                                                  blurRadius: 4,
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              '- $announcement',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.purple,
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              )),
                          const SizedBox(height: 20),

                          // Active Vehicles Section
                          const Text(
                            'Active Vehicles and Drivers:',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          
                          const SizedBox(height: 10),
                          // Filter Dropdown
                          Obx(() => ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.activeVehicles.length,
                                itemBuilder: (context, index) {
                                  var vehicle =
                                      controller.activeVehicles[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() =>
                                          VehicleInfoScreen(vehicle: vehicle));
                                    },
                                    child: Card(
                                      elevation: 5,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Colors.purple[100],
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Icon(
                                                Icons.directions_car,
                                                size: 36,
                                                color: Colors.purple,
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    vehicle["vehicle"]!,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    'Driver: ${vehicle["driver"]}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Status: ${vehicle["status"]}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Location: ${vehicle["location"]}',
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
                              )),
                        ],
                      ),
                    ),

                    // Second Tab: Reports
                    Center(
                      child: const Text(
                        'Reports Section Coming Soon!',
                        style: TextStyle(fontSize: 18),
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
  }
}
