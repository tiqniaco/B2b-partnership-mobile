import 'package:b2b_partenership/views/auth/choose_account.dart';
import 'package:b2b_partenership/views/auth/forget_password_email_view.dart';
import 'package:b2b_partenership/views/auth/forget_password_reset_view.dart';
import 'package:b2b_partenership/views/auth/login_view.dart';
import 'package:b2b_partenership/views/auth/o_t_p_view.dart';
import 'package:b2b_partenership/views/auth/provider_signup_view.dart';
import 'package:b2b_partenership/views/auth/client_signup_view.dart';
import 'package:b2b_partenership/views/home/client_home_layout.dart';
import 'package:b2b_partenership/views/home/client_home_view.dart';
import 'package:b2b_partenership/views/home/provider_home_layout.dart';
import 'package:b2b_partenership/views/home/provider_home_view.dart';
import 'package:b2b_partenership/views/provider_profile/previous_work_view.dart';
import 'package:b2b_partenership/views/provider_profile/provider_profile_view.dart';
import 'package:b2b_partenership/views/see_all/see_all_categories.dart';
import 'package:b2b_partenership/views/see_all/see_all_providers.dart';
import 'package:b2b_partenership/views/service_details_view.dart';
import 'package:b2b_partenership/views/in_category/providers_in_categories.dart';
import 'package:b2b_partenership/views/service_request/add_service_request.dart';
import 'package:b2b_partenership/views/service_request/get_user_service_request.dart';
import 'package:b2b_partenership/views/settings/change_password_view.dart';
import 'package:b2b_partenership/views/settings/edit_client_profile_view.dart';
import 'package:b2b_partenership/views/shop/shop_cart_view.dart';
import 'package:b2b_partenership/views/shop/shop_view.dart';
import 'package:b2b_partenership/views/splash/views/splash_view.dart';
import 'package:get/get.dart';

import 'views/service_request/service_request_details.dart';
import 'views/shop/shop_product_details_view.dart';

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
  static const String forgetPasswordReset = '/forget-password-reset';
  static const String resetPassword = '/reset-password';
  static const String checkEmail = "/check-email";
  static const String loginByPassword = "/login-by-password";
  static const String chooseAccount = "/chooseAccount";

  // home
  static const String clintHome = '/clintHome';
  static const String providerHomeLayout = '/providerHomeLayout';
  static const String providerHomeView = '/providerHomeView';
  static const String clientHomeLayout = '/clientHomeLayout';
  static const String seeAll = '/seeAll';
  static const String seeAllCategories = '/seeAllCategories';

  //service request
  static const String addServicesRequest = '/addServicesRequest';
  static const String getRequestServices = '/requestServices';
  static const String serviceRequestDetails = '/serviceRequestDetails';

  // service details
  static const String serviceDetails = '/serviceDetails';
  static const String providersInCategory = '/providersInCategory';

  // provider
  static const String providerProfile = '/providerProfile';
  static const String providerPreviousWork = '/providerPreviousWork';

  // Shop
  static const String shop = '/shop';
  static const String shopProductDetails = '/shopProductDetails';
  static const String shopCart = '/shopCart';

  // Edit Client Profile
  static const String editClientProfile = '/editClientProfile';
  static const String changePassword = '/changePassword';

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
      name: forgetPassword,
      page: () => const ForgetPasswordEmailView(),
    ),
    GetPage(
      name: otp,
      page: () => const OTPView(),
    ),
    GetPage(
      name: forgetPasswordReset,
      page: () => const ForgetPasswordResetView(),
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
      page: () => ClientHomeView(),
    ),
    GetPage(
      name: providerHomeView,
      page: () => const ProviderHomeView(),
    ),
     GetPage(
      name: providerHomeLayout,
      page: () => const ProviderHomeLayout(),
    ),
    GetPage(
      name: clientHomeLayout,
      page: () => const ClientHomeLayout(),
    ),
    GetPage(
      name: seeAll,
      page: () => const SeeAll(),
    ),
    GetPage(
      name: seeAllCategories,
      page: () => const SeeAllCategories(),
    ),

    // service request
    GetPage(
      name: addServicesRequest,
      page: () => AddServiceRequest(),
    ),
    GetPage(
      name: getRequestServices,
      page: () => GetUserServiceRequest(),
    ),
    GetPage(
      name: serviceRequestDetails,
      page: () => ServiceRequestDetails(),
    ),

    // service details
    GetPage(
      name: serviceDetails,
      page: () => ServiceDetailsView(),
    ),
    GetPage(
      name: providersInCategory,
      page: () => ProvidersInCategories(),
    ),

    // provider
    GetPage(
      name: providerProfile,
      page: () => const ProviderProfileView(),
    ),
    GetPage(
      name: providerPreviousWork,
      page: () => const PreviousWorkView(),
    ),

    // Shop
    GetPage(
      name: shop,
      page: () => const ShopView(),
    ),
    GetPage(
      name: shopProductDetails,
      page: () => const ShopProductDetailsView(),
    ),
    GetPage(
      name: shopCart,
      page: () => const ShopCartView(),
    ),

    // Edit Client Profile
    GetPage(
      name: editClientProfile,
      page: () => const EditClientProfileView(),
    ),

    // Change Password
    GetPage(
      name: changePassword,
      page: () => const ChangePasswordView(),
    )
  ];
}
