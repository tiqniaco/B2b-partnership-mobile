import 'package:b2b_partenership/controller/shop/shop_cart_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/widgets/please_login_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ShopCartView extends StatelessWidget {
  const ShopCartView({super.key});

  @override
  Widget build(BuildContext context) {
    if (ApiConstance.token.isEmpty) {
      return const PleaseLoginWidget();
    }

    return GetBuilder<ShopCartController>(
      init: ShopCartController(),
      builder: (ShopCartController controller) {
        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: _buildModernAppBar(controller, context),
          body: CustomServerStatusWidget(
            statusRequest: controller.statusRequest,
            errorMessage: controller.error,
            emptyMessage: "Your cart is empty\nDiscover amazing products!".tr,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _buildCartSummaryCard(controller),
                        _buildCartItemsList(controller),
                        Gap(24.h),
                        _buildContactInfoCard(controller),
                        Gap(100.h), // Space for bottom bar
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: _buildModernBottomBar(controller),
        );
      },
    );
  }

  PreferredSizeWidget _buildModernAppBar(
      ShopCartController controller, BuildContext context) {
    return AppBar(
      toolbarHeight: context.isTablet ? 45.h : null,
      title: Text(
        "Cart".tr,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 20.r,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 16.w),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: customBorderRadius,
          ),
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.trashCan,
              color: Colors.white,
              size: 16.r,
            ),
            onPressed: () => _showClearCartDialog(controller),
          ),
        ),
        Gap(20)
      ],
    );
  }

  Widget _buildCartSummaryCard(ShopCartController controller) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color.fromARGB(255, 226, 56, 56), primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              FontAwesomeIcons.shoppingCart,
              color: Colors.white,
              size: 24.r,
            ),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cart Total".tr,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14.r,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "\$${controller.calculateTotalPrice()}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.r,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              "${controller.carts.length} items",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.r,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemsList(ShopCartController controller) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemBuilder: (context, index) => _buildModernCartItem(controller, index),
      separatorBuilder: (context, index) => Gap(12.h),
      itemCount: controller.carts.length,
    );
  }

  Widget _buildModernCartItem(ShopCartController controller, int index) {
    final item = controller.carts[index];
    final discountedPrice = double.parse(item.product.price) -
        (double.parse(item.product.price) *
            double.parse(item.product.discount) /
            100);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () => controller.onItemTab(index: index),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: customBorderRadius,
                  child: CustomNetworkImage(
                    imageUrl: item.product.image,
                    width: 80.r,
                    height: 80.r,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translateDatabase(
                        arabic: item.product.titleAr,
                        english: item.product.titleEn,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.r,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Gap(8.h),
                    Row(
                      children: [
                        if (item.product.discount != "0") ...[
                          Text(
                            "\$${item.product.price}",
                            style: TextStyle(
                              fontSize: 12.r,
                              color: Colors.grey[500],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Gap(8.w),
                        ],
                        Text(
                          "\$${discountedPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 16.r,
                            fontWeight: FontWeight.bold,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                    if (item.product.discount != "0")
                      Container(
                        margin: EdgeInsets.only(top: 4.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: lightPrimaryColor.withAlpha(150),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          "${item.product.discount}% ${"OFF".tr}",
                          style: TextStyle(
                            fontSize: 10.r,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: lightPrimaryColor.withAlpha(150),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.xmark,
                    size: 16.r,
                    color: primaryColor,
                  ),
                  onPressed: () => controller.removeFromCart(
                    id: item.id.toString(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfoCard(ShopCartController controller) {
    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[400]!, Colors.grey[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 20.r,
                  ),
                ),
                Gap(12.w),
                Text(
                  "Contact Information".tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.r,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your contact details to receive order data".tr,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14.r,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gap(20.h),
                _buildModernTextField(
                  controller: controller.emailController,
                  hintText: "Enter email (optional)".tr,
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                Gap(16.h),
                _buildModernTextField(
                  controller: controller.phoneController,
                  hintText: "Enter phone (optional)".tr,
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 14.r,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: 14.r,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.all(12.w),
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: lightPrimaryColor.withAlpha(170),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 20.r,
            ),
          ),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        ),
      ),
    );
  }

  Widget _buildModernBottomBar(ShopCartController controller) {
    return BottomAppBar(
      height: 100.h,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: customBorderRadius,
          // BorderRadius.only(
          //   topLeft: Radius.circular(25.r),
          //   topRight: Radius.circular(25.r),
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Amount".tr,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.r,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "\$${controller.calculateTotalPrice()}",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20.r,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(16.w),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green[400]!, Colors.green[600]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CustomLoadingButton(
                  backgroundColor: Colors.transparent,
                  onPressed: () => controller.checkout(),
                  text: "Checkout".tr,
                  width: 140.w,
                  height: 50.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showClearCartDialog(ShopCartController controller) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          "Clear Cart".tr,
          style: TextStyle(
            fontSize: 18.r,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          "Are you sure you want to remove all items from your cart?".tr,
          style: TextStyle(
            fontSize: 14.r,
            color: Colors.grey[600],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "Cancel".tr,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.clearCart();
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              "Clear".tr,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
//     return GetBuilder<ShopCartController>(
//       init: ShopCartController(),
//       builder: (ShopCartController controller) {
//         return Scaffold(
//           appBar: AppBar(
//             toolbarHeight: context.isTablet ? 45.h : null,
//             title: Text(
//               "Cart".tr,
//               style: TextStyle(
//                 color: blackColor,
//                 fontSize: 18.r,
//                 fontWeight: FontManager.semiBoldFontWeight,
//               ),
//             ),
//             centerTitle: true,
//             actions: [
//               Container(
//                 decoration: BoxDecoration(
//                     color: primaryColor, borderRadius: customBorderRadius),
//                 child: IconButton(
//                   icon: Icon(
//                     FontAwesomeIcons.trashCan,
//                     color: whiteColor,
//                     size: 18.r,
//                   ),
//                   onPressed: () {
//                     controller.clearCart();
//                   },
//                 ),
//               ),
//               Gap(20)
//             ],
//           ),
//           body: CustomServerStatusWidget(
//             statusRequest: controller.statusRequest,
//             errorMessage: controller.error,
//             emptyMessage: "Cart is empty,\nLet's add some items.".tr,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: ListView.separated(
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           tileColor: primaryColor.withAlpha(10),
//                           onTap: () {
//                             controller.onItemTab(index: index);
//                           },
//                           leading: CustomNetworkImage(
//                             imageUrl: controller.carts[index].product.image,
//                             width: 80.w,
//                             fit: BoxFit.cover,
//                           ),
//                           title: Text(
//                             translateDatabase(
//                               arabic: controller.carts[index].product.titleAr,
//                               english: controller.carts[index].product.titleEn,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: getRegularStyle(context),
//                           ),
//                           subtitle: Text(
//                             '${double.parse(controller.carts[index].product.price) - (double.parse(controller.carts[index].product.price) * double.parse(controller.carts[index].product.discount) / 100)}\$',
//                             style: getRegularStyle(context).copyWith(
//                               color: primaryColor,
//                               fontWeight: FontManager.semiBoldFontWeight,
//                             ),
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(
//                               FontAwesomeIcons.xmark,
//                               size: 20.r,
//                             ),
//                             onPressed: () {
//                               controller.removeFromCart(
//                                 id: controller.carts[index].id.toString(),
//                               );
//                             },
//                           ),
//                         );
//                       },
//                       separatorBuilder: (context, index) => Gap(10.h),
//                       itemCount: controller.carts.length,
//                     ),
//                   ),
//                   Gap(20.h),
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 241, 240, 236),
//                         borderRadius: BorderRadius.circular(0.r),
//                       ),
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                                 width: double.infinity,
//                                 padding: EdgeInsets.all(15),
//                                 decoration:
//                                     BoxDecoration(color: Colors.blueGrey),
//                                 child: Row(
//                                   children: [
//                                     Icon(
//                                       Icons.report_gmailerrorred,
//                                       color: whiteColor,
//                                       size: 20.r,
//                                     ),
//                                     Gap(10.w),
//                                     Text(
//                                       "Important Note :".tr,
//                                       style: getRegularStyle(context).copyWith(
//                                         color: whiteColor,
//                                         fontWeight: FontManager.boldFontWeight,
//                                       ),
//                                     ),
//                                   ],
//                                 )),
//                             Padding(
//                               padding: const EdgeInsets.all(15.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "If you want to receive the bags in specific email or whatsapp, please enter your contact details"
//                                         .tr,
//                                     style: getRegularStyle(context).copyWith(
//                                       color: blackColor,
//                                       fontWeight: FontManager.regularFontWeight,
//                                     ),
//                                     maxLines: 3,
//                                   ),
//                                   Gap(10.h),
//                                   TextFormField(
//                                     controller: controller.emailController,
//                                     style: TextStyle(color: blackColor),
//                                     decoration: InputDecoration(
//                                         filled: true,
//                                         fillColor: Colors.white,
//                                         prefixIcon: Icon(
//                                           Icons.email_outlined,
//                                           color: blackColor,
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: const Color.fromARGB(
//                                                 255, 241, 240, 236),
//                                             width: 0.5,
//                                           ),
//                                         ),
//                                         enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                           color: const Color.fromARGB(
//                                               255, 241, 240, 236),
//                                           width: 0.5,
//                                         )),
//                                         hintText: 'enter email (optional)',
//                                         hintStyle: getRegularStyle(context)
//                                             .copyWith(color: blackColor)),
//                                   ),
//                                   Gap(10.h),
//                                   TextFormField(
//                                     controller: controller.phoneController,
//                                     style: TextStyle(color: blackColor),
//                                     decoration: InputDecoration(
//                                         filled: true,
//                                         fillColor: Colors.white,
//                                         prefixIcon: Icon(
//                                           Icons.phone_enabled_outlined,
//                                           color: blackColor,
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color: const Color.fromARGB(
//                                                 255, 241, 240, 236),
//                                             width: 0.5,
//                                           ),
//                                         ),
//                                         enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                           color: const Color.fromARGB(
//                                               255, 241, 240, 236),
//                                           width: 0.5,
//                                         )),
//                                         hintText: 'enter phone (optional)',
//                                         hintStyle: getRegularStyle(context)
//                                             .copyWith(color: blackColor)),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ]),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           bottomNavigationBar: Container(
//             padding: EdgeInsets.only(
//               left: 20.w,
//               right: 20.w,
//               top: 2.h,
//               bottom: 10.h,
//             ),
//             height: 0.1.sh,
//             child: Column(
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Total: ".tr,
//                       style: getMediumStyle(context).copyWith(
//                         fontWeight: FontManager.semiBoldFontWeight,
//                       ),
//                     ),
//                     Text(
//                       "${controller.calculateTotalPrice()}\$",
//                       style: getMediumStyle(context).copyWith(
//                         fontWeight: FontManager.semiBoldFontWeight,
//                         color: primaryColor,
//                       ),
//                     ),
//                     Spacer(),
//                     CustomLoadingButton(
//                       backgroundColor: greenColor,
//                       onPressed: () {
//                         return controller.checkout();
//                       },
//                       text: "Checkout".tr,
//                       width: 0.35.sw,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
