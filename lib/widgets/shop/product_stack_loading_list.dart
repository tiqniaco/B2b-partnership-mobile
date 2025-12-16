import 'package:b2b_partenership/widgets/shop/product_stack_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductStackLoadingList extends StatelessWidget {
  const ProductStackLoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => Gap(12.h),
        itemCount: 15,
        itemBuilder: (context, index) => ProductStackLoading());
  }
}
