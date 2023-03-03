import 'package:dio/dio.dart';
import 'package:flutter_adakami/data/repository/auth_repo.dart';
import 'package:flutter_adakami/data/repository/language_repo.dart';
import 'package:flutter_adakami/data/repository/notification_repo.dart';
import 'package:flutter_adakami/data/repository/splash_repo.dart';
import 'package:flutter_adakami/provider/auth_provider.dart';
import 'package:flutter_adakami/provider/language_provider.dart';
import 'package:flutter_adakami/provider/localization_provider.dart';
import 'package:flutter_adakami/provider/notification_provider.dart';
import 'package:flutter_adakami/provider/splash_provider.dart';
import 'package:flutter_adakami/provider/theme_provider.dart';
import 'package:flutter_adakami/utill/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => NotificationRepo(dioClient: sl()));
  sl.registerLazySingleton(() => LanguageRepo());

  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => NotificationProvider(notificationRepo: sl()));
  sl.registerFactory(() => LanguageProvider(languageRepo: sl()));


  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
