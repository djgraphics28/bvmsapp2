import 'package:bvmsapp2/modules/home/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncidentReportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.put(DashboardController(), permanent: true);

    // Show the modal when the FAB is clicked
    void _showIncidentReportModal() {
      TextEditingController titleController = TextEditingController();
      TextEditingController vehicleController = TextEditingController();
      TextEditingController dateController = TextEditingController();
      TextEditingController statusController = TextEditingController();

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: 500, // Set the modal height to 500
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Submit Incident Report',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Incident Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: vehicleController,
                  decoration: const InputDecoration(
                    labelText: 'Vehicle Involved',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: statusController,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.incidents.add({
                      "title": titleController.text,
                      "vehicle": vehicleController.text,
                      "date": dateController.text,
                      "status": statusController.text,
                    });
                    Navigator.pop(context); // Close the modal after submission
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          );
        },
      );
    }

    // Get count of incidents by status
    int getCountByStatus(String status) {
      return controller.incidents.where((incident) => incident["status"] == status).toList().length;
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
                              style: const TextStyle(fontSize: 12, color: Colors.white),
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
                              style: const TextStyle(fontSize: 12, color: Colors.white),
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
                              style: const TextStyle(fontSize: 12, color: Colors.white),
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
                              style: const TextStyle(fontSize: 12, color: Colors.white),
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
                  Obx(() {
                    var inProgressIncidents = controller.incidents
                        .where((incident) => incident["status"] == "In Progress")
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
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showIncidentReportModal, // Show modal on FAB click
          child: const Icon(Icons.add),
          tooltip: 'Submit Incident Report',
        ),
      ),
    );
  }
}
