// grid_item_list.dart
import 'package:flutter/material.dart';
import 'package:movie_sphere/widgets/items/tv/grid_item.dart';

class GridItemListT extends StatelessWidget {
  const GridItemListT({
    super.key,
    required this.tvShows,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.67,
  });

  final List<dynamic> tvShows;
  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: tvShows.length,
      itemBuilder: (context, index) {
        return GridItemT(tvShow: tvShows[index]);
      },
    );
  }
}
