import 'dart:convert';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adakami/view/screens/auth/login_screen.dart';
import 'package:flutter_adakami/view/screens/home/home_screen.dart';
import 'package:flutter_adakami/view/screens/splash/splash_screen.dart';

class RouteHelper {
  static final FluroRouter router = FluroRouter();

  static String splash = '/splash';
  static String login = '/login';
  static String home = '/';

  static Handler _splashHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          SplashScreen());
  static Handler _loginHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          LoginScreen());
  static Handler _homeHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          HomeScreen());

  static void setupRouter() {
    router.define(splash,
        handler: _splashHandler, transitionType: TransitionType.fadeIn);
    router.define(login,
        handler: _loginHandler, transitionType: TransitionType.fadeIn);
    router.define(home,
        handler: _homeHandler, transitionType: TransitionType.fadeIn);
  }
}
