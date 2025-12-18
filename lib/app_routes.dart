import 'package:b2b_partenership/views/auth/auth_note_screen.dart';
import 'package:b2b_partenership/views/auth/choose_account.dart';
import 'package:b2b_partenership/views/auth/forget_password_email_view.dart';
import 'package:b2b_partenership/views/auth/forget_password_reset_view.dart';
import 'package:b2b_partenership/views/auth/login_view.dart';
import 'package:b2b_partenership/views/auth/o_t_p_view.dart';
import 'package:b2b_partenership/views/auth/signup_view.dart';
import 'package:b2b_partenership/views/client_profile_view.dart';
import 'package:b2b_partenership/views/home/home_layout_view.dart';
import 'package:b2b_partenership/views/home/home_view.dart';
import 'package:b2b_partenership/views/iso/certification_details_view.dart';
import 'package:b2b_partenership/views/iso/iso_cart_view.dart';
import 'package:b2b_partenership/views/iso/iso_certifications_view.dart';
import 'package:b2b_partenership/views/user_job_application/search_job_applications_view.dart';
import 'package:b2b_partenership/views/orders/orders_view.dart';
import 'package:b2b_partenership/views/provider_profile/my_services/my_service.dart';
import 'package:b2b_partenership/views/posts/get_all_posts.dart';
import 'package:b2b_partenership/views/provider_profile/add_previous_work_view.dart';
import 'package:b2b_partenership/views/provider_profile/edit_previous_work_view.dart';
import 'package:b2b_partenership/views/settings/provider/manage_previous_work.dart';
import 'package:b2b_partenership/views/provider_profile/previous_work_details_view.dart';
import 'package:b2b_partenership/views/provider_profile/previous_work_view.dart';
import 'package:b2b_partenership/views/provider_profile/provider_profile_view.dart';
import 'package:b2b_partenership/views/see_all/see_all_categories.dart';
import 'package:b2b_partenership/views/see_all/see_all_providers.dart';
import 'package:b2b_partenership/views/provider_profile/my_services/service_details_view.dart';
import 'package:b2b_partenership/views/in_category/providers_in_categories.dart';
import 'package:b2b_partenership/views/posts/add_post_view.dart';
import 'package:b2b_partenership/views/posts/user_posts.dart';
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
import 'views/user_job_application/client_job_applications_view.dart';
import 'views/user_job_application/job_application_details_view.dart';
import 'views/user_job_application/add_job_application_view.dart';
import 'views/jobs/job_details_view.dart';
import 'views/jobs/all_jobs_view.dart';
import 'views/jobs/job_applications_view.dart';
import 'views/notifications/views/notification_view.dart';
import 'views/orders/order_details_view.dart';
import 'views/orders/order_item_view.dart';
import 'views/jobs/add_new_job_view.dart';
import 'views/jobs/user_jobs_view.dart';
import 'views/provider_profile/my_services/add_provider_service_view.dart';
import 'views/provider_profile/my_services/edit_provider_service_view.dart';
import 'views/settings/provider/edit_provider_profile_view.dart';
import 'views/settings/provider/provider_contacts/provider_contacts_view.dart';
import 'views/save/save_view.dart';
import 'views/search/search_view.dart';
import 'views/posts/post_details_view.dart';
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
  static const String home = '/home';
  // static const String providerHomeLayout = '/providerHomeLayout';
  // static const String providerHomeView = '/providerHomeView';
  static const String homeLayout = '/homeLayout';
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
  static const String myServices = '/myServices';
  static const String getServicesRequest = "/getServicesRequest";
  static const String clientProfile = "/clientProfile";

  //iso 
  static const String isoCertifications = '/isoCertifications';
  static const String isoCertificationDetails = '/isoCertificationDetails';

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
      page: () => const SignupView(),
    ),
    GetPage(
      name: chooseAccount,
      page: () => const ChooseAccount(),
    ),

    //home

    GetPage(
      name: home,
      page: () => HomeView(),
    ),
    // GetPage(
    //   name: providerHomeView,
    //   page: () => const ProviderHomeView(),
    // ),
    // GetPage(
    //   name: providerHomeLayout,
    //   page: () => const ProviderHomeLayout(),
    // ),
    GetPage(
      name: homeLayout,
      page: () => const HomeLayoutView(),
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
      page: () => AddPostView(),
    ),
    GetPage(
      name: getRequestServices,
      page: () => UserPostsView(),
    ),
    GetPage(
      name: serviceRequestDetails,
      page: () => PostDetailsView(),
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
      page: () => const PreviousWorkDetailsView(),
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
      page: () => AllJobsView(),
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
      page: () => const UserJobsView(),
    ),

    GetPage(
      name: addNewJob,
      page: () => const AddNewJobView(),
    ),
    GetPage(
      name: providerJobApplications,
      page: () => const JobApplicationsView(),
    ),
    GetPage(
      name: searchJobApplications,
      page: () => const SearchJobApplicationsView(),
    ),

    GetPage(
      name: save,
      page: () => const SaveView(),
    ),

    GetPage(
      name: myServices,
      page: () => MyService(),
    ),
    GetPage(
      name: getServicesRequest,
      page: () => GetAllPosts(),
    ),
    GetPage(
      name: clientProfile,
      page: () => ClientProfileView(),
    ),

    //iso
    GetPage(
      name: isoCertifications,
      page: () => const IsoCertificationsView(),
    ),
    GetPage(
      name: isoCertificationDetails,
      page: () =>  CertificationDetailsScreen(),
    ),
  ];
}
