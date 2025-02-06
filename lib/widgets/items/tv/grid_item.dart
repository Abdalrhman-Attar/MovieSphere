// grid_item.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_sphere/view/secondary/item_details/tv/item_details_page.dart';
import 'package:shimmer/shimmer.dart';

class GridItemT extends StatelessWidget {
  const GridItemT({
    super.key,
    required this.tvShow,
  });

  final dynamic tvShow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetails(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPoster(context),
          const SizedBox(height: 8),
          _buildTitle(),
          const SizedBox(height: 4),
          _buildRating(),
        ],
      ),
    );
  }

  Widget _buildPoster(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/original/${tvShow['poster_path']}',
          fit: BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[700]!,
            child: Container(color: Colors.black),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[800],
            child: const Icon(Icons.movie_rounded, color: Colors.white24),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      tvShow['name'],
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
        const SizedBox(width: 4),
        Text(
          tvShow['vote_average'].toStringAsFixed(1),
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[400],
          ),
        ),
        const Spacer(),
        Text(
          // view year from date string
          tvShow['first_air_date'].substring(0, 4),
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailsPageT(tvShow: tvShow),
      ),
    );
  }
}
