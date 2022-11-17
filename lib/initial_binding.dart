import 'package:get/get.dart';
import 'package:home/Screens/Home/user_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UserController>(UserController(), permanent: true);
  }
}
