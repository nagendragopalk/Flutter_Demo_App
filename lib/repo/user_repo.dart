import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:home/CustomWidgets/snackbar_widget.dart';

import '../utils/http_utils.dart';
import '../utils/loader_util.dart';

class UserRepo {
  createUser(data) async {
    try {
      var response = await HttpUtils.getInstance().post(
        "/user/create/",
        data: data,
      );
      if (response.statusCode == 201) {
        return response.data;
      } else {
        debugPrint("printing Error: ${response.data.toString()}");
        if (response.statusCode != 500 && response.statusCode != 401) {
          showSnackBar(
            title: "loading..! Failed",
            message: response.data.toString(),
            icon: const Icon(Icons.close, color: Colors.red),
          );
        } else {
          showSnackBar(
            title: "Server..! Error",
            message: "Getting Server Error",
            icon: Icon(Icons.close, color: Colors.red),
          );
        }
      }
    } on DioError catch (e) {
      debugPrint(e.message);
      throw Exception(e.message);
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return null;
  }
}
