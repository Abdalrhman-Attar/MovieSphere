// grid_item_list.dart
import 'package:flutter/material.dart';
import 'package:movie_sphere/widgets/items/movie/grid_item.dart';

class GridItemListM extends StatelessWidget {
  const GridItemListM({
    super.key,
    required this.movies,
    this.crossAxisCount = 2,
    this.childAspectRatio = 0.67,
  });

  final List<dynamic> movies;
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
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return GridItemM(movie: movies[index]);
      },
    );
  }
}
