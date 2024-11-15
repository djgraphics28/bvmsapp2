// lib/modules/home/bindings/home_binding.dart
import 'package:get/get.dart';
import 'package:bvmsapp2/modules/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize HomeController when this module is accessed
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
