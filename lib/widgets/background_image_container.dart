import 'package:flutter/material.dart';
import 'package:movie_sphere/common/images.dart';

class BackgroundImageContainer extends StatelessWidget {
  const BackgroundImageContainer({
    super.key,
    required this.child,
    this.enableRtlTransform = true,
  });

  final Widget child;
  final bool enableRtlTransform;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.authBackground),
          fit: BoxFit.cover,
          matchTextDirection: enableRtlTransform,
        ),
      ),
      child: child,
    );
  }
}
