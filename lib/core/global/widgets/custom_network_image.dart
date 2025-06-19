import 'package:flutter/material.dart';
import '/core/utils/assets_data.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.fitHeight,
    this.width,
    this.height,
    this.shape,
    this.borderRadius,
  });

  final String imageUrl;
  final BoxFit fit;
  final double? height;
  final double? width;
  final BoxShape? shape;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: shape == BoxShape.circle
            ? null
            : BorderRadius.circular(borderRadius ?? 0),
        image: DecorationImage(
          image: Image.network(imageUrl).image,
          fit: fit,
        ),
        shape: shape ?? BoxShape.rectangle,
      ),
      clipBehavior: Clip.antiAlias,
      child: Image(
        width: width,
        height: height,
        image: Image.network(imageUrl).image,
        fit: fit,
        alignment: Alignment.center,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Image.asset(
            AssetsData.defaultImage,
            fit: fit,
            alignment: Alignment.center,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            AssetsData.defaultImage,
            fit: fit,
            alignment: Alignment.center,
          );
        },
      ),
    );
  }
}
