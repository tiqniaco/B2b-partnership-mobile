import 'package:b2b_partenership/controller/shop/shop_cart_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
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
          appBar: AppBar(
            toolbarHeight: context.isTablet ? 45.h : null,
            title: Text(
              "Cart".tr,
              style: getMediumStyle(context).copyWith(
                color: whiteColor,
              ),
            ),
            backgroundColor: primaryColor,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: whiteColor,
              size: context.isTablet ? 16.r : 20.r,
            ),
            actions: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.trashCan,
                  color: whiteColor,
                ),
                onPressed: () {
                  controller.clearCart();
                },
              )
            ],
          ),
          body: CustomServerStatusWidget(
            statusRequest: controller.statusRequest,
            errorMessage: controller.error,
            emptyMessage: "Cart is empty,\nLet's add some items.",
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          controller.onItemTab(index: index);
                        },
                        leading: CustomNetworkImage(
                          imageUrl: controller.carts[index].product.image,
                          width: 80.w,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          translateDatabase(
                            arabic: controller.carts[index].product.titleAr,
                            english: controller.carts[index].product.titleEn,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: getRegularStyle(context),
                        ),
                        subtitle: Text(
                          '${double.parse(controller.carts[index].product.price) - (double.parse(controller.carts[index].product.price) * double.parse(controller.carts[index].product.discount) / 100)}\$',
                          style: getRegularStyle(context).copyWith(
                            color: primaryColor,
                            fontWeight: FontManager.semiBoldFontWeight,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.xmark,
                            size: 20.r,
                          ),
                          onPressed: () {
                            controller.removeFromCart(
                              id: controller.carts[index].id.toString(),
                            );
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Gap(10.h),
                    itemCount: controller.carts.length,
                  ),
                ),
                Gap(20.h),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 240, 236),
                      borderRadius: BorderRadius.circular(0.r),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(color: Colors.blueGrey),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.report_gmailerrorred,
                                    color: whiteColor,
                                    size: 20.r,
                                  ),
                                  Gap(10.w),
                                  Text(
                                    "Important Note :".tr,
                                    style: getRegularStyle(context).copyWith(
                                      color: whiteColor,
                                      fontWeight: FontManager.boldFontWeight,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "If you want to receive the bags in specific email or whatsapp, please enter your contact details"
                                      .tr,
                                  style: getRegularStyle(context).copyWith(
                                    color: blackColor,
                                    fontWeight: FontManager.regularFontWeight,
                                  ),
                                  maxLines: 3,
                                ),
                                Gap(10.h),
                                TextFormField(
                                  controller: controller.emailController,
                                  style: TextStyle(color: blackColor),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                        color: blackColor,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 241, 240, 236),
                                          width: 0.5,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 241, 240, 236),
                                        width: 0.5,
                                      )),
                                      hintText: 'enter email (optional)',
                                      hintStyle: getRegularStyle(context)
                                          .copyWith(color: blackColor)),
                                ),
                                Gap(10.h),
                                TextFormField(
                                  controller: controller.phoneController,
                                  style: TextStyle(color: blackColor),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixIcon: Icon(
                                        Icons.phone_enabled_outlined,
                                        color: blackColor,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: const Color.fromARGB(
                                              255, 241, 240, 236),
                                          width: 0.5,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 241, 240, 236),
                                        width: 0.5,
                                      )),
                                      hintText: 'enter phone (optional)',
                                      hintStyle: getRegularStyle(context)
                                          .copyWith(color: blackColor)),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 2.h,
              bottom: 10.h,
            ),
            height: 0.1.sh,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total: ".tr,
                      style: getMediumStyle(context).copyWith(
                        fontWeight: FontManager.semiBoldFontWeight,
                      ),
                    ),
                    Text(
                      "${controller.calculateTotalPrice()}\$",
                      style: getMediumStyle(context).copyWith(
                        fontWeight: FontManager.semiBoldFontWeight,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    CustomLoadingButton(
                      backgroundColor: greenColor,
                      onPressed: () {
                        return controller.checkout();
                      },
                      text: "Checkout",
                      width: 0.35.sw,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
