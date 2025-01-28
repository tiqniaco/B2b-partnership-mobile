import '/core/constants/app_constants.dart';

class ApiConstance {
  static const String baseUrl = 'https://tiqnia.com/Apps/b2b_partenership/api/';

  static String token = '';

  // global
  static String countries = 'countries';
  static String cities = 'governments';
  static String getProviderTyps = 'provider-types';
  static String getSpacialization = 'specializations';
  static String getSupSpacialization = 'sub-specializations';
  

  /// Auth
  static const String login = 'auth/login';
  static const String logout = 'patient/auth/logout';
  static const String register = 'patient/auth/register';
  static const String checkEmail = 'patient/auth/check-email';
  static const String checkPhone = 'patient/auth/check-phone';
  static const String registerWithGoogle = 'patient/auth/register-with-google';
  static const String loginWithGoogle = 'patient/auth/login-with-google';
  static const String profile = 'patient/profile';
  static final String updateProfile = 'patient/$kUserId';
  static final String deleteAccount = 'patient/$kUserId';
  static const String resetPassword = 'reset-password';
}
