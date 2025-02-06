import 'package:flutter/material.dart';
import 'package:movie_sphere/widgets/items/movie/horizontal_list_item.dart';

class HorizontalItemListM extends StatelessWidget {
  const HorizontalItemListM({
    super.key,
    required this.movies,
  });

  final List<dynamic> movies;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: movies.map((movie) {
            return HorizontalListItemM(movie: movie);
          }).toList(),
        ),
      ),
    );
  }
}
