import 'package:b2b_partenership/controller/home/home_controller.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/widgets/home/banner_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeSliders extends StatefulWidget {
  const HomeSliders({super.key});

  @override
  State<HomeSliders> createState() => _HomeSlidersState();
}

class _HomeSlidersState extends State<HomeSliders> {
  CarouselSliderController carouselController = CarouselSliderController();

  int currentPage = 0;

  changeSlider(int index) {
    currentPage = index;
    setState(() {});
  }

  List<Widget> banners = [
    BannerWidget(
      image: "assets/images/ban2.png",
      title: "90% Discount".tr,
      onPressed: () {
        // Get.put(ProviderHomeLayoutController(this)).onBNavPressed(1);
      },
      description: "Training bag on the basics of\npurchasing management".tr,
      buttonTitle: 'Shop Now'.tr,
    ),
    BannerWidget(
      image: "assets/images/ban4.png",
      title: "More than 100 job offer".tr,
      onPressed: () {
        // Get.put(ProviderHomeLayoutController(this)).onBNavPressed(1);
      },
      description: "Freelance & Full time & part time".tr,
      buttonTitle: 'Apply Now'.tr,
    ),
    BannerWidget(
      image: "assets/images/ban1.png",
      title: "Need Custom Service?! ".tr,
      onPressed: () {
        // Get.put(ProviderHomeLayoutController(this)).onBNavPressed(1);
      },
      description: "Now you can post your\ncustom service request".tr,
      buttonTitle: 'Post Now'.tr,
    ),
    BannerWidget(
      image: "assets/images/ban3.png",
      title: "All service providers".tr,
      onPressed: () {
        // Get.put(ProviderHomeLayoutController(this)).onBNavPressed(1);
      },
      description: "IT Services and industry sectors and more".tr,
      buttonTitle: 'Browse All Categories'.tr,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return GetBuilder<HomeController>(
      id: "slider",
      builder: (controller) {
        return Column(
          children: [
            CarouselSlider.builder(
              carouselController: carouselController,
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, reson) {
                  changeSlider(index);
                },
                height: context.isTablet ? 250 : 127.h,
                animateToClosest: true,
                autoPlay: true,
                padEnds: true,
                enableInfiniteScroll: true,
                autoPlayInterval: const Duration(seconds: 7),
                enlargeCenterPage: context.isTablet ? true : false,
              ),
              itemCount: banners.length,
              itemBuilder: (context, index, realindex) => banners[index],
            ),
            Gap(10),
            AnimatedSmoothIndicator(
              effect: ScaleEffect(
                activeDotColor: primaryColor,
                dotHeight: 12,
                dotWidth: 12,
                spacing: 6,
                dotColor: primaryColor.withAlpha(60),
                scale: 1.5,
              ),
              activeIndex: currentPage,
              count: banners.length,
            ),
          ],
        );
      },
    );
  }
}
