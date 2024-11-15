// lib/modules/home/controllers/home_controller.dart
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Observable variable for welcome message
  var welcomeMessage = 'Welcome to the Home Page!'.obs;

  var currentIndex = 0.obs;

  // Update the index when a new tab is selected
  void changeTabIndex(int index) {
    currentIndex.value = index;
  }

}
