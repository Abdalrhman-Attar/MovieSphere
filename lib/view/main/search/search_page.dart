import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_sphere/common/my_icons.dart';
import 'package:movie_sphere/common/shared_preferences.dart';
import 'package:movie_sphere/controllers/discover_movies_controller.dart';
import 'package:movie_sphere/controllers/discover_tv_controller.dart';
import 'package:movie_sphere/controllers/popular_movies_controller.dart';
import 'package:movie_sphere/module/dynamic_icon_viewer.dart';
import 'package:movie_sphere/module/text_field.dart';
import 'package:movie_sphere/view/secondary/full_section/movie/full_section_page.dart';
import 'package:movie_sphere/view/secondary/full_section/tv/full_section_page.dart';
import 'package:movie_sphere/widgets/lists/movie/horizontal_item_list.dart';
import 'package:movie_sphere/widgets/lists/tv/horizontal_item_list.dart';
import 'package:movie_sphere/widgets/default_section.dart';

class SearchController extends GetxController {
  final showResults = false.obs;
  final recentSearches = <String>[].obs;
  final searchQuery = ''.obs;
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    recentSearches.value = MySharedPreferences.recentSearches;
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setShowResults(false);
    });
  }

  void setShowResults(bool value) => showResults.value = value;

  void addRecentSearch(String search) {
    if (!recentSearches.contains(search)) {
      recentSearches.add(search);
      MySharedPreferences.addRecentSearch(search);
    }
  }

  void removeRecentSearch(String search) {
    recentSearches.remove(search);
    MySharedPreferences.removeRecentSearch(search);
  }

  void clearRecentSearches() {
    recentSearches.clear();
    MySharedPreferences.clearRecentSearches();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }

  void performSearch(String query) {
    if (query.isEmpty) return;

    final discoverMoviesController = Get.find<DiscoverMoviesController>();
    final discoverTVController = Get.find<DiscoverTVController>();

    discoverMoviesController.searchMovies(query);
    discoverTVController.searchTVShows(query);

    setShowResults(true);
    addRecentSearch(query);
  }
}

class SearchPage extends GetView<SearchController> {
  SearchPage({super.key}) {
    Get.put(SearchController());
    Get.put(PopularMoviesController());
    Get.put(DiscoverMoviesController());
    Get.put(DiscoverTVController());
  }

  final TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> _getSuggestions(String query) {
    if (query.isEmpty) return [];
    final lowerQuery = query.toLowerCase();
    final popularMoviesController = Get.find<PopularMoviesController>();
    final discoverTVController = Get.find<DiscoverTVController>();

    List<Map<String, dynamic>> suggestions = [];

    suggestions.addAll(
      popularMoviesController.popularMovies.where((movie) => movie['title'].toString().toLowerCase().contains(lowerQuery)).map((movie) => {'type': 'movie', 'name': movie['title']}),
    );

    suggestions.addAll(
      discoverTVController.discoverTVShows.where((tv) => tv['name'].toString().toLowerCase().contains(lowerQuery)).map((tv) => {'type': 'tv', 'name': tv['name']}),
    );

    return suggestions;
  }

  void _handleSearch() {
    if (searchController.text.isEmpty) return;
    controller.performSearch(searchController.text);
  }

  void _clearSearch() {
    searchController.clear();
    controller.setShowResults(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            automaticallyImplyLeading: false,
            surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(25),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Obx(() => globalTextFormField(
                      hint: 'Search movies and TV shows',
                      controller: searchController,
                      validateText: 'Please enter a valid search term',
                      keyboardType: TextInputType.text,
                      enabled: true,
                      maxLength: 50,
                      icon: !controller.showResults.value ? MyIcons.search : MyIcons.delete,
                      mainColor: Theme.of(context).colorScheme.onSurface,
                      onFieldSubmitted: (_) => _handleSearch(),
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      onChanged: (value) => controller.onSearchChanged(value),
                      isIconTapable: true,
                      onIconTap: searchController.text.isEmpty
                          ? null
                          : !controller.showResults.value
                              ? _handleSearch
                              : _clearSearch,
                    )),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            sliver: SliverToBoxAdapter(
              child: GetX<SearchController>(
                builder: (controller) {
                  final suggestions = _getSuggestions(controller.searchQuery.value);
                  if (controller.searchQuery.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.recentSearches.isNotEmpty) _buildRecentSearches(),
                        const SizedBox(height: 16),
                        _buildPopularMoviesSection(),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!controller.showResults.value) _buildSuggestions(suggestions),
                        if (controller.showResults.value) _buildSearchResults(),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearches() {
    return GetX<SearchController>(
      builder: (controller) => DefaultSection(
        buttonFunction: controller.clearRecentSearches,
        buttonText: 'Clear',
        title: 'Recent Searches',
        description: 'Your recent search history',
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 150),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.recentSearches.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final recentSearch = controller.recentSearches[index];
              return Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: ListTile(
                      leading: DynamicIconViewer(
                        filePath: MyIcons.search,
                        size: 24,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      title: Text(recentSearch),
                      onTap: () {
                        searchController.text = recentSearch;
                        controller.setShowResults(true);
                      },
                      trailing: IconButton(
                        icon: DynamicIconViewer(
                          filePath: MyIcons.delete,
                          size: 24,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                        ),
                        onPressed: () => controller.removeRecentSearch(recentSearch),
                      ),
                    ),
                  ),
                  if (index != controller.recentSearches.length - 1)
                    Divider(
                      thickness: 1,
                      height: 0,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPopularMoviesSection() {
    return GetX<PopularMoviesController>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return DefaultSection(
          title: 'Popular Movies',
          description: 'Currently trending movies',
          child: controller.popularMovies.isEmpty ? const Center(child: Text('No movies available')) : HorizontalItemListM(movies: controller.popularMovies),
          buttonFunction: () => Get.to(() => FullSectionPageM(
                title: 'Popular Movies',
                description: 'Currently trending movies',
                movies: controller.popularMovies,
              )),
          buttonText: 'More',
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetX<DiscoverMoviesController>(
          builder: (controller) {
            if (controller.isLoading.value) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (controller.discoverMovies.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('No movies found matching your search'),
              );
            }

            return DefaultSection(
              title: 'Discovered Movies',
              description: 'Movies based on your search',
              child: HorizontalItemListM(movies: controller.discoverMovies),
              buttonText: 'More',
              buttonFunction: () => Get.to(() => FullSectionPageM(
                    title: 'Discovered Movies',
                    description: 'Movies based on your search',
                    movies: controller.discoverMovies,
                  )),
            );
          },
        ),
        const SizedBox(height: 16),
        GetX<DiscoverTVController>(
          builder: (controller) {
            if (controller.isLoading.value) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (controller.discoverTVShows.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('No TV shows found matching your search'),
              );
            }

            return DefaultSection(
              title: 'Discovered TV Shows',
              description: 'TV shows based on your search',
              child: HorizontalItemListT(tvShows: controller.discoverTVShows),
              buttonText: 'More',
              buttonFunction: () => Get.to(() => FullSectionPageT(
                    title: 'Discovered TV Shows',
                    description: 'TV shows based on your search',
                    tvShows: controller.discoverTVShows,
                  )),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSuggestions(List<Map<String, dynamic>> suggestions) {
    return suggestions.isEmpty
        ? const Center(child: Text('No suggestions found'))
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final item = suggestions[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        item['type'] == 'movie' ? Icons.movie : Icons.tv,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(item['name'].toString()),
                      subtitle: Text(item['type'] == 'movie' ? 'Movie' : 'TV Show'),
                      onTap: () {
                        searchController.text = item['name'].toString();
                        _handleSearch();
                      },
                    ),
                    if (index != suggestions.length - 1)
                      Divider(
                        thickness: 1,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                      ),
                  ],
                );
              },
            ),
          );
  }
}
