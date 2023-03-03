import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adakami/provider/auth_provider.dart';
import 'package:flutter_adakami/provider/language_provider.dart';
import 'package:flutter_adakami/provider/localization_provider.dart';
import 'package:flutter_adakami/provider/notification_provider.dart';
import 'package:flutter_adakami/provider/splash_provider.dart';
import 'package:flutter_adakami/provider/theme_provider.dart';
import 'package:flutter_adakami/helper/route_helper.dart';
import 'package:flutter_adakami/theme/dark_theme.dart';
import 'package:flutter_adakami/theme/light_theme.dart';
import 'package:flutter_adakami/utill/app_constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'di_container.dart' as di;
import 'localization/app_localization.dart';
import 'helper/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    (Platform.isAndroid || Platform.isIOS)
        ? FlutterLocalNotificationsPlugin()
        : null;

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  String _payload;

  try {
    if (!kIsWeb) {
      final RemoteMessage remoteMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
        _payload = remoteMessage.notification.titleLocKey != null
            ? remoteMessage.notification.titleLocKey
            : null;
      }
      // await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      // FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  } catch (e) {}

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<NotificationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LanguageProvider>()),
    ],
    child: MyApp(payload: _payload, isWeb: !kIsWeb),
  ));
}

class MyApp extends StatefulWidget {
  final String payload;
  final bool isWeb;

  MyApp({@required this.payload, @required this.isWeb});

  static final navigatorKey = new GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    RouteHelper.setupRouter();
  }

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });
    return Consumer<SplashProvider>(
      builder: (context, splashProvider, child) {
        return MaterialApp(
          title: AppConstants.APP_NAME,
          initialRoute: RouteHelper.splash,
          onGenerateRoute: RouteHelper.router.generator,
          debugShowCheckedModeBanner: false,
          navigatorKey: MyApp.navigatorKey,
          theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
          locale: Provider.of<LocalizationProvider>(context).locale,
          localizationsDelegates: [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: _locals,
          scrollBehavior: MaterialScrollBehavior().copyWith(dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          }),
        );
      },
    );
  }
}
