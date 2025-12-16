import 'package:b2b_partenership/widgets/shop/product_stack_loading.dart';
import 'package:flutter/material.dart';


class ProductStackLoadingSliverList extends StatelessWidget {
  const ProductStackLoadingSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: 15,
        itemBuilder: (context, index) => ProductStackLoading() );
  }
}
