import 'package:flutter/material.dart';
import 'package:flutter_adakami/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_adakami/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({@required this.sharedPreferences, @required this.dioClient});

  Future<bool> initSharedData() {
    if(!sharedPreferences.containsKey(AppConstants.THEME)) {
      return sharedPreferences.setBool(AppConstants.THEME, false);
    }
    if(!sharedPreferences.containsKey(AppConstants.COUNTRY_CODE)) {
      return sharedPreferences.setString(AppConstants.COUNTRY_CODE, 'ID');
    }
    if(!sharedPreferences.containsKey(AppConstants.LANGUAGE_CODE)) {
      return sharedPreferences.setString(AppConstants.LANGUAGE_CODE, 'id');
    }
    return Future.value(true);
  }

  Future<bool> removeSharedData() {
    return sharedPreferences.clear();
  }
}
