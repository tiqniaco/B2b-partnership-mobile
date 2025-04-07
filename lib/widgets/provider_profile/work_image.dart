import 'package:b2b_partenership/controller/previous_work/previous_work_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:widget_zoom/widget_zoom.dart';

class WorkImage extends StatelessWidget {
  const WorkImage({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    Get.put(PreviousDetailsWorkController());
    return GetBuilder<PreviousDetailsWorkController>(builder: (controller) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MasonryGridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemCount: controller.images.length,
            itemBuilder: (context, index) {
              return WidgetZoom(
                zoomWidget: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CustomNetworkImage(
                    imageUrl: controller.images[index].image!,
                    fit: BoxFit.contain,
                  ),
                ),
                heroAnimationTag: index.toString(),
              );
            },
          ),
        ),
      );
    });
  }
}
