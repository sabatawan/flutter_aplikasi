import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adakami/localization/language_constrants.dart';
import 'package:flutter_adakami/provider/auth_provider.dart';
import 'package:flutter_adakami/provider/splash_provider.dart';
import 'package:flutter_adakami/helper/route_helper.dart';
import 'package:flutter_adakami/utill/app_constants.dart';
import 'package:flutter_adakami/utill/images.dart';
import 'package:flutter_adakami/utill/styles.dart';
import 'package:flutter_adakami/view/screens/auth/login_screen.dart';
import 'package:flutter_adakami/view/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  @override
  void initState() {
    super.initState();

    bool _firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        print('-----------------${isNotConnected ? 'Not' : 'Yes'}');
        isNotConnected
            ? SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected
                ? getTranslated('no_connection', context)
                : getTranslated('connected', context),
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });

    Provider.of<SplashProvider>(context, listen: false).initSharedData();
    _route();
  }

  void _route() {
    if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      Timer(Duration(seconds: 1), () async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteHelper.home, (route) => false,
            arguments: HomeScreen());
      });
    } else {
      Timer(Duration(seconds: 1), () async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteHelper.login, (route) => false,
            arguments: LoginScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset("assets/image/app_logo.png", height: 200),
          SizedBox(height: 30),
          Text(AppConstants.APP_NAME,
              textAlign: TextAlign.center,
              style: poppinsMedium.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: 50,
              )),
        ],
      ),
    );
  }
}
