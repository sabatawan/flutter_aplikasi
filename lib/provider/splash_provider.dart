import 'package:flutter/material.dart';
import 'package:flutter_adakami/data/repository/splash_repo.dart';
import 'package:flutter_adakami/utill/app_constants.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo splashRepo;
  SplashProvider({@required this.splashRepo});

  bool _firstTimeConnectionCheck = true;

  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }

  Future<bool> removeSharedData() {
    return splashRepo.removeSharedData();
  }

  String getLanguageCode(){
    return splashRepo.sharedPreferences.getString(AppConstants.LANGUAGE_CODE);
  }
}
