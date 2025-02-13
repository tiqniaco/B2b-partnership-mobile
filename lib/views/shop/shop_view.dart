import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  final List<Map<String, String>> products = [
    {
      'title': 'E-book 1',
      'price': '\$10',
      'image': 'https://placehold.co/600x400.png'
    },
    {
      'title': 'Design Template',
      'price': '\$15',
      'image': 'https://placehold.co/600x400.png'
    },
    {
      'title': 'Music Track',
      'price': '\$5',
      'image': 'https://placehold.co/600x400.png'
    },
  ];
  bool showCategories = true;

  changeShowCategories() {
    setState(() {
      showCategories = !showCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Digital Shop')),
      body: Row(
        children: [
          if (showCategories)
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: 0.25.sw,
              height: 1.sh,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                ),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 100.h,
                    child: Column(
                      children: [
                        Card(
                          shape: CircleBorder(
                            side: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://placehold.co/600x400.png',
                            ),
                            radius: 35.r,
                          ),
                        ),
                        Gap(5.h),
                        Text(
                          'Category ${index + 1}',
                          style: getRegularStyle.copyWith(
                            fontWeight: FontManager.semiBoldFontWeight,
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Gap(10.h),
                itemCount: 10,
              ),
            ),
          Stack(
            children: [
              PositionedDirectional(
                start: 0,
                top: 0,
                bottom: 0,
                end: 0,
                child: VerticalDivider(
                  thickness: 2.w,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    changeShowCategories();
                  },
                  child: Card(
                    shape: CircleBorder(),
                    color: primaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(7.r),
                      child: Icon(
                        showCategories
                            ? Icons.arrow_back_ios_new
                            : Icons.arrow_forward_ios_outlined,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.network(product['image']!,
                              fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product['title']!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(product['price']!,
                            style: TextStyle(color: Colors.blue)),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
