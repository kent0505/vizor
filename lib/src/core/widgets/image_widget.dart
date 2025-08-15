import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../utils.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget.asset(
    this.asset, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.borderRadius = BorderRadius.zero,
  }) : _isNetwork = false;

  const ImageWidget.network(
    this.asset, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center,
    this.borderRadius = BorderRadius.zero,
  }) : _isNetwork = true;

  final String asset;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment alignment;
  final BorderRadiusGeometry borderRadius;
  final bool _isNetwork;

  static Widget frameBuilder(
    BuildContext context,
    Widget child,
    int? frame,
    bool wasSynchronouslyLoaded,
  ) {
    return AnimatedOpacity(
      opacity: frame == null ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: _isNetwork
          ? CachedNetworkImage(
              imageUrl: asset,
              width: width,
              height: height,
              fit: fit,
              alignment: alignment,
              errorWidget: (context, url, error) {
                return SizedBox(
                  height: height,
                  width: width,
                );
              },
            )
          : Image.asset(
              asset,
              width: width,
              height: height,
              fit: fit,
              alignment: alignment,
              frameBuilder: frameBuilder,
              errorBuilder: (context, error, stackTrace) {
                logger(error);
                return const SizedBox();
              },
            ),
    );
  }
}
