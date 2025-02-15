import '/core/constants/app_constants.dart';

class ApiConstance {
  static const String baseUrl = 'https://tiqnia.com/Apps/b2b_partenership/api/';

  static String token = '';

  // global
  static String countries = 'countries';
  static String cities = 'governments';
  static String getProviderTypes = 'provider-types';
  static String getSpecialization = 'specializations';
  static String getSupSpecialization = 'sub-specializations';

  /// Auth
  static const String login = 'auth/login';
  static const String logout = 'patient/auth/logout';
  static const String register = 'auth/register';
  static const String checkEmail = 'patient/auth/check-email';
  static const String checkPhone = 'patient/auth/check-phone';
  static const String registerWithGoogle = 'patient/auth/register-with-google';
  static const String loginWithGoogle = 'patient/auth/login-with-google';
  static const String profile = 'patient/profile';
  static final String updateProfile = 'patient/$kUserId';
  static final String deleteAccount = 'patient/$kUserId';
  static const String resetPassword = 'reset-password';

  // home
  static const String getBanners = 'banners';
  static const String getTopServices = 'home/top-services';
  static const String getTopProviders = 'home/top-providers';
  static const String getNewServices = 'home/new-services';
  static const String getJobs = 'home/new-jobs';

  // service request
  static const String addServiceRequest = 'request-services';
  static String getClientServiceRequest(String id) => 'clients/$id/services';
  static const String getServicePriceOffer = 'request-offers';

  //service details
  static String getServiceDetails(String id) => 'provider-service/$id';
  static const String getReviewServices = 'provider-service-reviews';
  static const String getFeatureServices = 'provider-service-features';

  //provider Details
  static String getProviderProfileDetails(String id) => 'providers/$id';
  static String getProviderServices(String id) => 'providers/$id/services';
  static String getServicesInCategory(String id) =>
      'specializations/$id/services';
  static String getProvidersInCategory = 'specializations/providers';
  static String getTopCountriesProv(String id) =>
      'home/country/$id/top-providers';
  static String getUserFavorite = 'favorite-providers';
  static String toggleFavorite = 'toggle-favorite';

  static String shopCategories = 'store/categories';
  static String shopProducts = 'store/products';
}
