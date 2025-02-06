import 'package:flutter/material.dart';
import 'package:movie_sphere/widgets/items/movie/vertical_list_item.dart';

class VerticalItemListM extends StatelessWidget {
  const VerticalItemListM({
    super.key,
    required this.movies,
  });

  final List<dynamic> movies;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: movies.map((movie) {
            return VerticalListItemM(movie: movie);
          }).toList(),
        ),
      ),
    );
  }
}
