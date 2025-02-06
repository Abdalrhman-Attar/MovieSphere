import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_sphere/common/my_icons.dart';
import 'package:movie_sphere/controllers/favorites_controller.dart';
import 'package:movie_sphere/module/dynamic_icon_viewer.dart';
import 'package:movie_sphere/widgets/common_app_bar.dart';
import 'package:movie_sphere/widgets/lists/movie/vertical_item_list.dart';
import 'package:movie_sphere/widgets/lists/tv/vertical_item_list.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final FavoritesController _favoritesController = Get.put(FavoritesController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchData();
  }

  Future<void> _fetchData() async {
    await _favoritesController.fetchFavoriteMovies();
    await _favoritesController.fetchFavoriteTvShows();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: commonAppBar(
          leadingWidth: null,
          context: context,
          title: Text(
            'Favorites',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          viewButtons: true,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Movies'),
              Tab(text: 'TV Shows'),
            ],
            labelColor: Theme.of(context).colorScheme.secondary,
            unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            indicatorColor: Theme.of(context).colorScheme.secondary,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildFavoritesList(_favoritesController.favoriteMovies, 'movie'),
            _buildFavoritesList(_favoritesController.favoriteTvShows, 'tv'),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesList(RxList<dynamic> items, String mediaType) {
    return Obx(() => items.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DynamicIconViewer(
                    filePath: MyIcons.empty,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No favorites yet',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Add your favorite movies and TV shows to view them here',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
                ],
              ),
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                mediaType == 'movie'
                    ? VerticalItemListM(
                        movies: items,
                      )
                    : VerticalItemListT(
                        tvShows: items,
                      ),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
              ],
            ),
          ));
  }
}
