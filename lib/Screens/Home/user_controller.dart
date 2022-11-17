import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home/model/user_data.dart';
import 'package:home/repo/user_repo.dart';
import 'package:home/routes/app_pages.dart';
import 'package:home/utils/loader_util.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  TextEditingController userName = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userDob = TextEditingController();
  TextEditingController userEmail = TextEditingController();

  @override
  void onClose() {
    userDob.dispose();
  }

  final _userData = UserData().obs;
  UserData get userData => _userData.value;
  set userData(value) => _userData.value = value;

  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final DateFormat formatterYear = DateFormat('yyyy-MM-dd');
  getCustomerDOB(DateTime? date) {
    userDob.text = formatter.format(date!);
    userData.dob = formatterYear.format(date);
    update();
  }

  createEnquiry() async {
    showLoadingDialog();

    var postObject = userData;
    debugPrint("printing post data: ${jsonEncode(postObject)}");
    userDob.clear();
    closeLoadingDialog();
    Get.toNamed(Routes.userList);
    // try {
    //   final data = await UserRepo().createUser(postObject);
    //   closeLoadingDialog();
    //   if (data != null) {
    //     closeLoadingDialog();

    //     Get.toNamed(Routes.userList);
    //   }
    // } catch (e) {
    //   closeLoadingDialog();

    //   debugPrint(e.toString());
    // }
  }
}
