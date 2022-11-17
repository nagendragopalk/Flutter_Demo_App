import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar({required String title, required String message, required Widget icon}) {
  Get.snackbar(
    title,
    message,
    icon: Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        height: Get.height * (53 / 896),
        width: Get.height * (53 / 896),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
          color: Colors.white,
        ),
        child: icon,
      ),
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.white,
    borderRadius: Get.height * (10 / 896),
    boxShadows: [
      BoxShadow(
        color: Colors.black,
        spreadRadius: 0.5,
        blurRadius: 2,
        offset: const Offset(0, 2), // changes position of shadow
      ),
    ],
    margin: const EdgeInsets.all(15),
    colorText: Colors.black,
    duration: const Duration(seconds: 4),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}
