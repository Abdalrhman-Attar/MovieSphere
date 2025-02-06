import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_sphere/controllers/favorites_controller.dart';
import 'package:movie_sphere/widgets/default_section.dart';
import 'package:movie_sphere/widgets/lists/movie/horizontal_item_list.dart';
import 'package:share_plus/share_plus.dart';

class ItemDetailsPageM extends StatelessWidget {
  final dynamic movie;
  final FavoritesController favoritesController = Get.find<FavoritesController>();

  ItemDetailsPageM({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          movie['title'],
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        centerTitle: true,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, size: 24, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
            onPressed: () {
              final String message = '''
${movie['title']}
Rating: ${movie['vote_average']}
Release Date: ${movie['release_date']}
                
Check it out on TMDb:
https://www.themoviedb.org/movie/${movie['id']}
              ''';
              Share.share(message);
            },
          ),
          Obx(() {
            bool isFavorite = favoritesController.favoriteMovies.any((m) => m['id'] == movie['id']);
            return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              onPressed: () => isFavorite ? _confirmRemoveFromFavorites(context) : favoritesController.addMovieToFavorites(movie),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPoster(context),
                  const SizedBox(height: 20),
                  _buildTitle(),
                  const SizedBox(height: 20),
                  _buildRating(),
                  const SizedBox(height: 20),
                  _buildDescription(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            DefaultSection(
              title: 'Similar Movies',
              description: 'You may also like these movies.',
              buttonText: 'View All',
              buttonFunction: () {
                // Navigate to a page with similar movies (Implement this later).
              },
              child: HorizontalItemListM(
                movies: [], // Add similar movies logic here.
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _confirmRemoveFromFavorites(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Remove from Favorites"),
        content: const Text("Are you sure you want to remove this movie from your favorites?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              favoritesController.removeMovieFromFavorites(movie);
              Navigator.of(context).pop();
            },
            child: const Text("Remove", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildPoster(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          'https://image.tmdb.org/t/p/original/${movie['poster_path']}',
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1) : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[800],
              child: const Icon(Icons.movie_rounded, color: Colors.white24),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      movie['title'],
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
        const SizedBox(width: 4),
        Text(
          movie['vote_average'].toStringAsFixed(1),
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[400],
          ),
        ),
        const Spacer(),
        Text(
          movie['release_date'].substring(0, 4),
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      movie['overview'] ?? 'No description available.',
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[600],
      ),
    );
  }
}
