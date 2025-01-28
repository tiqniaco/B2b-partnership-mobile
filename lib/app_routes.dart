import 'package:b2b_partenership/views/auth/choose_account.dart';
import 'package:b2b_partenership/views/auth/login_view.dart';
import 'package:b2b_partenership/views/auth/provider_signup_view.dart';
import 'package:b2b_partenership/views/auth/client_signup_view.dart';
import 'package:b2b_partenership/views/home/clint_home_view.dart';
import 'package:b2b_partenership/views/splash/views/splash_view.dart';
import 'package:get/get.dart';

class AppRoutes {
  /// Base routes
  static const String initial = '/';
  static const String onboarding = '/onboarding';

  /// Auth routes
  static const String login = '/login';
  static const String clientSignup = '/clientSignup';
  static const String providerSignup = '/providerSignup';
  static const String forgetPassword = '/forget-password';
  static const String otp = '/otp';
  static const String resetPassword = '/reset-password';
  static const String checkEmail = "/check-email";
  static const String loginByPassword = "/login-by-password";
  static const String chooseAccount = "/chooseAccount";

  // home
  static const String clintHome = '/clintHome';

  static final List<GetPage<dynamic>> pages = [
    // base
    GetPage(
      name: initial,
      page: () => const SplashView(),
    ),
    // auth
    GetPage(
      name: login,
      page: () => const LoginView(),
    ),
    GetPage(
      name: clientSignup,
      page: () => const ClientSignupView(),
    ),
    GetPage(
      name: providerSignup,
      page: () => const ProviderSignupView(),
    ),
    GetPage(
      name: chooseAccount,
      page: () => const ChooseAccount(),
    ),

    //home

    GetPage(
      name: clintHome,
      page: () => const ClintHomeView(),
    ),
  ];
}
