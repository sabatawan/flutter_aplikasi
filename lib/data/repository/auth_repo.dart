import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_adakami/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_adakami/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_adakami/data/model/response/base/api_response.dart';
import 'package:flutter_adakami/helper/responsive_helper.dart';
import 'package:flutter_adakami/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> login({String email, String password}) async {
    try {
      print({"email": email, "email_or_phone": email, "password": password});
      Response response = await dioClient.post(
        AppConstants.LOGIN_URI,
        data: {"email": email, "email_or_phone": email, "password": password},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // for  user token
  Future<void> saveUserToken(String token) async {
    dioClient.token = token;
    dioClient.dio.options.headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};

    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  Future<ApiResponse> updateToken() async {
    try {
      String _deviceToken = '';
      if(ResponsiveHelper.isMobilePhone()) {
        _deviceToken = await _saveDeviceToken();
        FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
      }
      Response response = await dioClient.post(
        AppConstants.TOKEN_URI,
        data: {"_method": "put", "cm_firebase_token": _deviceToken},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<String> _saveDeviceToken() async {
    String _deviceToken = '';
    if(Platform.isAndroid) {
      _deviceToken = await FirebaseMessaging.instance.getToken();
    }else if(Platform.isIOS) {
      _deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    }
    if (_deviceToken != null) {
      print('--------Device Token---------- '+_deviceToken);
    }
    return _deviceToken;
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> clearSharedData() async {
    if(!kIsWeb) {
      await FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
    }
    await sharedPreferences.remove(AppConstants.TOKEN);
    await sharedPreferences.remove(AppConstants.USER_ADDRESS);
    return true;
  }
  // for  Remember Email
  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_NUMBER, number);
    } catch (e) {
      throw e;
    }
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.USER_NUMBER) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_NUMBER);
  }
}
