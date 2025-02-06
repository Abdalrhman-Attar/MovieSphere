import 'package:flutter/material.dart';
import 'package:movie_sphere/widgets/items/tv/vertical_list_item.dart';

class VerticalItemListT extends StatelessWidget {
  const VerticalItemListT({
    super.key,
    required this.tvShows,
  });

  final List<dynamic> tvShows;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: tvShows.map((tvShow) {
            return VerticalListItemT(tvShow: tvShow);
          }).toList(),
        ),
      ),
    );
  }
}
