import 'package:flutter/material.dart';
import 'package:movie_sphere/common/images.dart';
import 'package:movie_sphere/common/shared_preferences.dart';
import 'package:movie_sphere/view/main/home/widgets/slider_section.dart';
import 'package:movie_sphere/view/secondary/full_section/movie/full_section_page.dart';
import 'package:movie_sphere/view/secondary/full_section/tv/full_section_page.dart';
import 'package:movie_sphere/widgets/default_section.dart';
import 'package:movie_sphere/widgets/lists/movie/horizontal_item_list.dart';
import 'package:get/get.dart';
import 'package:movie_sphere/controllers/upcoming_movies_controller.dart';
import 'package:movie_sphere/controllers/top_rated_tv_controller.dart';
import 'package:movie_sphere/widgets/lists/tv/horizontal_item_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UpcomingMoviesController upcomingMoviesController = Get.put(UpcomingMoviesController());
  final TopRatedTVController topRatedTVController = Get.put(TopRatedTVController());

  bool isExpanded = true;

  @override
  void initState() {
    super.initState();
    print("Stored Session ID: ${MySharedPreferences.sessionId}");
    print("Stored account ID: ${MySharedPreferences.accountId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Image.asset(
            Images.logo,
            height: 32,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Obx(() {
        // Wait until the controllers have finished fetching data
        if (upcomingMoviesController.isLoading.value || topRatedTVController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SliderSection(),
              const SizedBox(height: 16),
              DefaultSection(
                buttonFunction: () {
                  // Navigate to full section with upcoming movies
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FullSectionPageM(
                        title: 'Upcoming Movies',
                        description: 'View the upcoming movies.',
                        movies: upcomingMoviesController.upcomingMovies,
                      ),
                    ),
                  );
                },
                buttonText: 'More',
                title: 'Upcoming Movies',
                description: 'View the upcoming movies.',
                child: HorizontalItemListM(movies: upcomingMoviesController.upcomingMovies),
              ),
              const SizedBox(height: 16),
              DefaultSection(
                buttonFunction: () {
                  // Navigate to full section with top-rated TV shows
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FullSectionPageT(
                        title: 'Top Rated TV Shows',
                        description: 'View the top rated TV shows.',
                        tvShows: topRatedTVController.topRatedTV,
                      ),
                    ),
                  );
                },
                buttonText: 'More',
                title: 'Top Rated TV Shows',
                description: 'View the top rated TV shows.',
                child: HorizontalItemListT(tvShows: topRatedTVController.topRatedTV),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
            ],
          ),
        );
      }),
    );
  }
}
