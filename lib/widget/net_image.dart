import 'package:quiver/strings.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetImage extends StatelessWidget {
  final String? imageUrl;
  final String? placeholder;
  final BoxFit fit;
  final BoxFit? placeholderFit;
  final double? width;
  final double? height;
  final Alignment alignment;
  final ImageRepeat repeat;
  final bool matchTextDirection;
  final Map<String, String>? httpHeaders;
  final Color? color;
  final double borderRadius;

  const NetImage(
    this.imageUrl, {
    this.placeholder,
    this.fit = BoxFit.cover,
    this.placeholderFit,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.httpHeaders,
    this.color,
    this.borderRadius = 0,
    Key? key,
  }) : super(key: key);

  Widget placeholderWidget() {
    if (placeholder != null) {
      return Image.asset(placeholder!, width: width, height: height, fit: placeholderFit);
    } else {
      return Container(color: const Color(0xFFEEEEEE));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isEmpty(imageUrl)) {
      return placeholderWidget();
    }

    if (!imageUrl!.startsWith('http')) {
      return Image.asset(imageUrl!, width: width, height: height, fit: placeholderFit);
    }

    return ClipRRect(
      borderRadius: borderRadius == 0 ? BorderRadius.zero : BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        placeholder: (BuildContext context, String url) {
          return placeholderWidget();
        },
        errorWidget: (BuildContext context, String url, Object? error) {
          return placeholderWidget();
        },
        fit: fit,
        width: width,
        height: height,
        alignment: alignment,
        repeat: repeat,
        matchTextDirection: matchTextDirection,
        httpHeaders: httpHeaders,
        color: color,
      ),
    );
  }
}
