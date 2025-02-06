import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_sphere/common/controllers.dart';
import 'package:movie_sphere/controllers/popular_movies_controller.dart';
import 'package:movie_sphere/view/on_boarding/widgets/custom_dots_indicator.dart';
import 'package:movie_sphere/view/secondary/item_details/movie/item_details_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SliderSection extends StatefulWidget {
  const SliderSection({super.key});

  @override
  State<SliderSection> createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
  int currentIndex = 0; // Track the current index for the dot indicator

  @override
  Widget build(BuildContext context) {
    final PopularMoviesController controller = Get.put(PopularMoviesController());

    return Column(
      children: [
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.popularMovies.isEmpty) {
            return const Center(child: Text('No movies available.'));
          } else {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 220,
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 0.8,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index; // Update the current index
                    });
                  },
                ),
                itemCount: 7, // Dynamically set based on data
                itemBuilder: (context, index, realIndex) {
                  final movie = controller.popularMovies[index];
                  return _buildItem(
                    context,
                    movie["title"],
                    movie["overview"],
                    movie["backdrop_path"], // Assuming the image paths are available
                    movie["poster_path"], // Assuming poster path is available
                    () {
                      // Use the navigator for the current tab
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ItemDetailsPageM(
                            movie: movie, // Pass the movie details
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }
        }),

        // Dot indicator for carousel
        CustomDotsIndicator(
          dotsCount: 7, // Dynamically set based on data
          position: currentIndex.toDouble().toInt(), // Set the position to current index
        ),
      ],
    );
  }

  Widget _buildItem(
    BuildContext context,
    String title,
    String description,
    String bgImage,
    String fgImage,
    VoidCallback onPressed,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        final cardHeight = constraints.maxHeight;
        final fgImageWidth = 100.0;
        final fgImageHeight = 140.0;
        final fgImageLeft = (cardWidth - fgImageWidth) / 8;
        final fgImageTop = (cardHeight - fgImageHeight) / 2;

        return Container(
          width: cardWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.0,
              ),
            ],
            image: DecorationImage(
              image: NetworkImage("https://image.tmdb.org/t/p/w500$bgImage"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.001),
                ],
                begin: !Controllers.locale.getIsRtl() ? Alignment.centerRight : Alignment.centerLeft,
                end: !Controllers.locale.getIsRtl() ? Alignment.centerLeft : Alignment.centerRight,
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  children: [
                    Container(width: cardWidth * 0.4),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: fgImageTop,
                  left: Controllers.locale.getIsRtl() ? null : fgImageLeft,
                  right: Controllers.locale.getIsRtl() ? fgImageLeft : null,
                  child: Container(
                    width: fgImageWidth,
                    height: fgImageHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://image.tmdb.org/t/p/w500$fgImage"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.0),
                      onTap: onPressed,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
