import 'package:flutter_adakami/data/model/response/language_model.dart';
import 'images.dart';

class AppConstants {
  static const String APP_NAME = 'Ada Kami';
  static const double APP_VERSION = 1.0;
  static const String BASE_URL = 'https://djp-presensi.fiture.id';
  static const String LOGIN_URI = '/api/v1/auth/login';
  static const String TOKEN_URI = '/api/v1/auth/customer-token';
  static const String NOTIFICATION_URI = '/api/v1/notifications';

  // Shared Key
  static const String TOPIC = 'Ada_Kami';
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_NUMBER = 'user_number';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.indonesia_flag, languageName: 'Indonesia', countryCode: 'ID', languageCode: 'id'),
    LanguageModel(imageUrl: Images.england_flag, languageName: 'English', countryCode: 'US', languageCode: 'en'),
  ];
}
