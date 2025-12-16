import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/home/home_controller.dart';
import 'package:b2b_partenership/controller/home/home_layout_controller.dart';
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
      image: "assets/images/2 en.png",
      imageAr: "assets/images/2 ar.png",
      onPressed: () {
        // Get.put(HomeLayoutController()).onBNavPressed(1);
      },
    ),
    BannerWidget(
      image: "assets/images/4 en.jpg",
      imageAr: "assets/images/4 ar.jpg",
      onPressed: () {
        // Get.put(ProviderHomeLayoutController(this)).onBNavPressed(1);
      },
    ),
    BannerWidget(
      image: "assets/images/1 en.png",
      imageAr: "assets/images/1 ar.png",
      onPressed: () {
        Get.put(HomeLayoutController()).onBNavPressed(1);
      },
    ),
    BannerWidget(
      image: "assets/images/3 en.png",
      imageAr: "assets/images/3 ar.png",
      onPressed: () {
        Get.toNamed(AppRoutes.addProviderService);
      },
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
                viewportFraction: 0.9,
                onPageChanged: (index, reson) {
                  changeSlider(index);
                },
                height: context.isTablet ? 250 : 160.h,
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
            Gap(16),
            AnimatedSmoothIndicator(
              effect: ScaleEffect(
                activeDotColor: primaryColor,
                dotHeight: 8,
                dotWidth: 8,
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
