import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_sphere/common/controllers.dart';

class DynamicIconViewer extends StatelessWidget {
  final String filePath;
  final double size;
  final Color? color;
  final bool revers;
  const DynamicIconViewer({
    super.key,
    required this.filePath,
    this.size = 24,
    this.color,
    this.revers = false,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the file extension
    final isSvg = filePath.toLowerCase().endsWith('.svg');

    Widget icon = isSvg
        ? SvgPicture.asset(
            filePath,
            width: size,
            height: size,
            color: color,
            placeholderBuilder: (BuildContext context) => Center(
              child: CircularProgressIndicator(),
            ),
          )
        : ColorFiltered(
            colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : const ColorFilter.mode(Colors.transparent, BlendMode.srcIn),
            child: Image.asset(
              filePath,
              width: size,
              height: size,
              fit: BoxFit.contain,
            ),
          );

    if (revers) {
      icon = Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(3.14159),
        child: icon,
      );
    }

    if (Controllers.locale.getIsRtl()) {
      icon = Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(3.14159),
        child: icon,
      );
    }

    return icon;
  }
}
