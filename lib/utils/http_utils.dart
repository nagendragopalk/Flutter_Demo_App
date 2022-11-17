import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home/CustomWidgets/snackbar_widget.dart';
import 'package:home/common/common_service.dart';
import 'package:home/common/session_manager.dart';

class HttpUtils {
  //  global dio object
  static Dio dio = Dio();

  static Dio dio2 = Dio();

  //Dev Server
  static const String API_PREFIX = 'http://144.24.97.26:85/';

  static const int CONNECT_TIMEOUT = 100000;
  static const int RECEIVE_TIMEOUT = 5000;

  static setToken() {
    dio = Dio();
    getInstance();
  }

  static Dio getInstance() {
    dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = "Bearer ${CommonService.instance.accessToken}";
    dio.options.baseUrl = API_PREFIX;
    dio.options.connectTimeout = CONNECT_TIMEOUT;
    dio.options.receiveTimeout = RECEIVE_TIMEOUT;
    // dio.options.followRedirects = false;
    // dio.options.validateStatus =  (status) => true;
    dio.interceptors.add(InterceptorsWrapper(onRequest: (request, handler) {
      print("request: ${request.path}");
      if (CommonService.instance.accessToken != null) {
        request.headers['Authorization'] = 'Bearer  ${CommonService.instance.accessToken}';
      }
      return handler.next(request); //continue
    }, onResponse: (response, handler) {
      print("error statusCode  ${response}");
      // Do something with response data
      return handler.next(response); // continue
    }, onError: (DioError error, handler) async {
      print("error statusCode  ${error}");
      if (error.response?.statusCode == 401) {
        try {
          if (CommonService.instance.refreshToken != null) {
            final refreshToken = CommonService.instance.refreshToken;
            print("refreshToken::::::::::::00000:::::::::::::::::::::::: + $refreshToken");
            dio2 = Dio();
            dio2.options.headers['content-Type'] = 'application/json';
            dio2.options.headers["Authorization"] = "Bearer ${CommonService.instance.accessToken}";
            dio2.options.connectTimeout = CONNECT_TIMEOUT;
            dio2.options.receiveTimeout = RECEIVE_TIMEOUT;
            // dio.options.followRedirects = false;
            // dio.options.validateStatus =  (status) => true;
            print("Printing Base Url For Refresh Token:$API_PREFIX users/token/refresh/");
            final refreshResponse = await dio2.post(API_PREFIX + "users/token/refresh/", data: {
              "refresh": refreshToken,
              "device_uuid": CommonService.instance.deviceId,
              "device_type": CommonService.instance.deviceType == 'android' ? 1 : 2
            }).then((value) async {
              print("refreshToken::::::::::::::::::::::::::::::::::::" + value.data['access']);
              if (value.statusCode == 200) {
                print("printing status code in refresh token: ${value.statusCode}");
                print("Printing Refreshed Access Token: ${value.data['access']} ");
                // successfully got the new access token
                error.requestOptions.headers["Authorization"] = "Bearer " + value.data['access'];
                CommonService.instance.accessToken = value.data['access'];
                final opts = Options(method: error.requestOptions.method, headers: error.requestOptions.headers);
                final cloneReq = await dio.request(
                  error.requestOptions.path,
                  options: opts,
                  data: error.requestOptions.data,
                  queryParameters: error.requestOptions.queryParameters,
                );
                return handler.resolve(cloneReq);
              } else {
                CommonService.instance.accessToken = '';
                CommonService.instance.refreshToken = '';
                SessionManager.setAccessToken('');
                SessionManager.setRefreshToken('');
                // Get.toNamed(Routes.loginView);

                return handler.reject(error);
              }
            }).catchError((error) {
              CommonService.instance.accessToken = '';
              CommonService.instance.refreshToken = '';
              SessionManager.setAccessToken('');
              SessionManager.setRefreshToken('');

              // Get.toNamed(Routes.loginView);
            });
            return refreshResponse;
          }
        } catch (e) {
          return handler.reject(error);
        }
      } else {
        if (Get.isDialogOpen!) {
          Get.back();
        }
        if (error.response!.statusCode == 403) {
          showSnackBar(
            title: "Forbidden ${error.response!.statusCode}",
            message: error.response!.data.toString(),
            icon: Icon(Icons.close, color: Colors.red),
          );
          handler.reject(error);
        } else if (error.response!.statusCode == 500) {
          showSnackBar(
            title: "Something went wrong. ${error.response!.statusCode}",
            message: error.response!.data.toString(), //We are trying to fix the problem.
            icon: Icon(Icons.close, color: Colors.red),
          );
          return handler.reject(error);
        } else if (error.response!.statusCode == 502) {
          showSnackBar(
            title: "Bad Gateway ${error.response!.statusCode}",
            message: "We are trying to fix the problem.", //We are trying to fix the problem.
            icon: Icon(Icons.close, color: Colors.red),
          );
          return handler.reject(error);
        } else if (error.response!.statusCode == 502) {
          showSnackBar(
            title: "Something went wrong. ${error.response!.statusCode}",
            message: "We are trying to fix the problem.", //We are trying to fix the problem.
            icon: Icon(Icons.close, color: Colors.red),
          );
          return handler.reject(error);
        } else {
          showSnackBar(
            title: "Server..! error",
            message: "Getting Server Error \n" + error.response!.data.toString(),
            icon: Icon(Icons.close, color: Colors.red),
          );
          return handler.next(error);
        }

        return handler.next(error);
      }
      //else if (error.response?.statusCode == 404 || error.response?.statusCode == 500) {}
    }));

    return dio;
  }

  static Dio postInstance() {
    dio = Dio();
    dio.options.baseUrl = API_PREFIX;
    dio.options.connectTimeout = CONNECT_TIMEOUT;
    dio.options.receiveTimeout = RECEIVE_TIMEOUT;
    dio.options.followRedirects = false;
    dio.options.validateStatus = (status) => true;

    dio.interceptors.add(LogInterceptor(responseBody: false));
    return dio;
  }
}
