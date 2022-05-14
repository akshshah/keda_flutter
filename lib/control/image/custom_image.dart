import 'dart:io' show File;

import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String? url;
  final String? placeholder;
  final BoxFit? fit;

  ImageWidget({this.url, this.placeholder, this.fit,});

  @override
  Widget build(BuildContext context) {

    if ((url ?? '').isEmpty) {
      return Image.asset(
        placeholder ?? '',
        fit: fit ?? BoxFit.cover,
      );
    }

    if (!(url!.startsWith("http") || url!.startsWith("https"))) {
      return Image.file(
        File(url!),
        fit: fit ?? BoxFit.cover,
      );
    }

    return FadeInImage.assetNetwork(
      placeholder: placeholder ?? '',
      image: url!,
      fit: fit ?? BoxFit.cover,
    );
  }
}