import 'package:get/get.dart';
import 'package:home/Screens/Home/home.dart';
import 'package:home/Screens/Home/new_user_form.dart';
part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.userList,
      page: () => const HomePage(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.newUser,
      page: () => const NewUserAdd(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
