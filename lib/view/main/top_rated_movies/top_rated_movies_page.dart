import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_sphere/widgets/lists/movie/grid_item_list.dart';
import 'package:movie_sphere/controllers/top_rated_movies_controller.dart';

class TopRatedMoviesPage extends StatelessWidget {
  TopRatedMoviesPage({
    super.key,
  });

  final TopRatedMoviesController controller = Get.put(TopRatedMoviesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top Rated Movies',
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        centerTitle: true,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'View the top rated movies',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 24),
                if (controller.topRatedMovies.isEmpty) Center(child: Text('No top rated movies found')),
                if (controller.topRatedMovies.isNotEmpty) GridItemListM(movies: controller.topRatedMovies),
              ],
            ),
          ),
        );
      }),
    );
  }
}
