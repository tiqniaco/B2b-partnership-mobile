import 'package:b2b_partenership/views/auth/auth_note_screen.dart';
import 'package:b2b_partenership/views/auth/choose_account.dart';
import 'package:b2b_partenership/views/auth/forget_password_email_view.dart';
import 'package:b2b_partenership/views/auth/forget_password_reset_view.dart';
import 'package:b2b_partenership/views/auth/login_view.dart';
import 'package:b2b_partenership/views/auth/o_t_p_view.dart';
import 'package:b2b_partenership/views/auth/provider_signup_view.dart';
import 'package:b2b_partenership/views/home/client_home_layout.dart';
import 'package:b2b_partenership/views/home/client_home_view.dart';
import 'package:b2b_partenership/views/job_application/search_job_applications_view.dart';
import 'package:b2b_partenership/views/orders/orders_view.dart';
import 'package:b2b_partenership/views/provider_app/home/provider_home_layout.dart';
import 'package:b2b_partenership/views/provider_app/home/provider_home_view.dart';
import 'package:b2b_partenership/views/provider_profile/add_previous_work_view.dart';
import 'package:b2b_partenership/views/provider_profile/edit_previous_work_view.dart';
import 'package:b2b_partenership/views/provider_profile/manage_previous_work.dart';
import 'package:b2b_partenership/views/provider_profile/manage_previous_work_details_view.dart';
import 'package:b2b_partenership/views/provider_profile/previous_work_view.dart';
import 'package:b2b_partenership/views/provider_profile/provider_profile_view.dart';
import 'package:b2b_partenership/views/see_all/see_all_categories.dart';
import 'package:b2b_partenership/views/see_all/see_all_providers.dart';
import 'package:b2b_partenership/views/service_details_view.dart';
import 'package:b2b_partenership/views/in_category/providers_in_categories.dart';
import 'package:b2b_partenership/views/service_request/add_service_request.dart';
import 'package:b2b_partenership/views/service_request/get_user_service_request.dart';
import 'package:b2b_partenership/views/settings/about_us_webview.dart';
import 'package:b2b_partenership/views/settings/change_password_view.dart';
import 'package:b2b_partenership/views/settings/edit_client_profile_view.dart';
import 'package:b2b_partenership/views/settings/terms_and_conditions_webview.dart';
import 'package:b2b_partenership/views/shop/all_categories.dart';
import 'package:b2b_partenership/views/shop/products_in_category.dart';
import 'package:b2b_partenership/views/shop/shop_cart_view.dart';
import 'package:b2b_partenership/views/shop/shop_view.dart';
import 'package:b2b_partenership/views/splash/views/splash_view.dart';
import 'package:get/get.dart';

import 'views/complaints/complaints_view.dart';
import 'views/job_application/client_job_applications_view.dart';
import 'views/job_application/job_application_details_view.dart';
import 'views/job_application/job_application_view.dart';
import 'views/jobs/job_details_view.dart';
import 'views/jobs/jobs_view.dart';
import 'views/jobs/provider_job_applications_view.dart';
import 'views/notifications/views/notification_view.dart';
import 'views/orders/order_details_view.dart';
import 'views/orders/order_item_view.dart';
import 'views/provider_app/jobs/add_new_job_view.dart';
import 'views/provider_app/jobs/provider_jobs_view.dart';
import 'views/provider_app/my_services/add_provider_service_view.dart';
import 'views/provider_app/my_services/edit_provider_service_view.dart';
import 'views/provider_app/setting/edit_provider_profile_view.dart';
import 'views/provider_app/setting/provider_contacts/provider_contacts_view.dart';
import 'views/save/save_view.dart';
import 'views/search/search_view.dart';
import 'views/service_request/service_request_details.dart';
import 'views/shop/shop_product_details_view.dart';

class AppRoutes {
  /// Base routes
  static const String initial = '/';
  static const String onboarding = '/onboarding';

  /// Auth routes
  static const String login = '/login';
  //static const String clientSignup = '/clientSignup';
  static const String providerSignup = '/providerSignup';
  static const String forgetPassword = '/forget-password';
  static const String otp = '/otp';
  static const String forgetPasswordReset = '/forget-password-reset';
  static const String resetPassword = '/reset-password';
  static const String checkEmail = "/check-email";
  static const String loginByPassword = "/login-by-password";
  static const String chooseAccount = "/chooseAccount";
  static const String authNoteScreen = "/authNoteScreen";

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
  static const String shopOrders = '/orders';
  static const String allCategories = '/allCategories';
  static const String productsInCategory = '/productsInCategory';

  // Edit Client Profile
  static const String editClientProfile = '/editClientProfile';
  static const String changePassword = '/changePassword';

  // Complaints
  static const String complaints = '/complaints';

  // Notification
  static const String notification = '/notification';

  static const String search = '/search';

  // Order Details
  static const String orderDetails = '/orderDetails';
  static const String orderItem = '/orderItem';

  // Edit Provider Profile
  static const String editProviderProfile = "/edit-provider-profile";
  static const String addProviderService = "/add-provider-service";
  static const String editProviderService = "/edit-provider-service";
  static const String managePreviousWork = "/managePreviousWork";
  static const String managePreviousWorkDetailsView = '/managePreviousWorkView';
  static const String editPreviousWork = "/editPreviousWork";
  static const String addPreviousWork = "/addPreviousWork";

  // SaveView
  static const String save = '/save';

// Provider Contacts
  static const String providerContacts = '/providerContacts';
  static const String aboutUs = '/aboutUs';
  static const String termsAndConditions = '/termsAndConditions';

  static const String jobs = '/jobs';
  static const String jobDetails = '/jobDetails';
  static const String jobApplication = '/jobApplication';
  static const String clientJobApplications = '/clientJobApplications';
  static const String jobApplicationDetails = '/jobApplicationDetails';
  static const String providerJobs = '/providerJobs';
  static const String addNewJob = '/addNewJob';
  static const String providerJobApplications = '/providerJobApplications';
  static const String searchJobApplications = '/searchJobApplications';

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
      name: authNoteScreen,
      page: () => AuthNoteScreen(),
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
      name: managePreviousWorkDetailsView,
      page: () => const ManagePreviousWorkDetailsView(),
    ),
    GetPage(
      name: providerProfile,
      page: () => const ProviderProfileView(),
    ),
    GetPage(
      name: providerPreviousWork,
      page: () => const PreviousWorkView(),
    ),
    GetPage(
      name: managePreviousWork,
      page: () => const ManagePreviousWork(),
    ),
    GetPage(
      name: editPreviousWork,
      page: () => const EditPreviousWorkView(),
    ),
    GetPage(
      name: addPreviousWork,
      page: () => const AddPreviousWorkView(),
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
    GetPage(
      name: allCategories,
      page: () => const AllCategories(),
    ),
    GetPage(
      name: allCategories,
      page: () => const AllCategories(),
    ),
    GetPage(
      name: productsInCategory,
      page: () => const ProductsInCategory(),
    ),

    //settings
    // Edit Client Profile
    GetPage(
      name: editClientProfile,
      page: () => const EditClientProfileView(),
    ),

    // Change Password
    GetPage(
      name: changePassword,
      page: () => const ChangePasswordView(),
    ),

    // Complaints
    GetPage(
      name: complaints,
      page: () => const ComplaintsView(),
    ),
    GetPage(
      name: aboutUs,
      page: () => const AboutUsWebview(),
    ),
    GetPage(
      name: termsAndConditions,
      page: () => const TermsAndConditionsWebview(),
    ),

    // Notification
    GetPage(
      name: notification,
      page: () => const NotificationView(),
    ),
    GetPage(
      name: search,
      page: () => SearchView(),
    ),

    // Order
    GetPage(
      name: shopOrders,
      page: () => const OrdersView(),
    ),
    GetPage(
      name: orderDetails,
      page: () => const OrderDetailsView(),
    ),
    GetPage(
      name: orderItem,
      page: () => const OrderItemView(),
    ),

    // Edit Provider Profile
    GetPage(
      name: editProviderProfile,
      page: () => const EditProviderProfileView(),
    ),

    GetPage(
      name: addProviderService,
      page: () => const AddProviderServiceView(),
    ),
    GetPage(
      name: editProviderService,
      page: () => const EditProviderServiceView(),
    ),

    GetPage(
      name: providerContacts,
      page: () => const ProviderContactsView(),
    ),

    GetPage(
      name: jobs,
      page: () => JobsView(),
    ),
    GetPage(
      name: jobDetails,
      page: () => const JobDetailsView(),
    ),

    GetPage(
      name: jobApplication,
      page: () => const JobApplicationView(),
    ),

    GetPage(
      name: clientJobApplications,
      page: () => const ClientJobApplicationsView(),
    ),
    GetPage(
      name: jobApplicationDetails,
      page: () => const JobApplicationDetailsView(),
    ),

    GetPage(
      name: providerJobs,
      page: () => const ProviderJobsView(),
    ),

    GetPage(
      name: addNewJob,
      page: () => const AddNewJobView(),
    ),
    GetPage(
      name: providerJobApplications,
      page: () => const ProviderJobApplicationsView(),
    ),
    GetPage(
      name: searchJobApplications,
      page: () => const SearchJobApplicationsView(),
    ),

    GetPage(
      name: save,
      page: () => const SaveView(),
    ),
  ];
}
