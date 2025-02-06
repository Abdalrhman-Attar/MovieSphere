import 'package:flutter/material.dart';
import 'package:movie_sphere/widgets/items/tv/horizontal_list_item.dart';

class HorizontalItemListT extends StatelessWidget {
  const HorizontalItemListT({
    super.key,
    required this.tvShows,
  });

  final List<dynamic> tvShows;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: tvShows.map((tvShow) {
            return HorizontalListItemT(tvShow: tvShow);
          }).toList(),
        ),
      ),
    );
  }
}
