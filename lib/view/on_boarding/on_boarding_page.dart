import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_sphere/common/images.dart';
import 'package:movie_sphere/common/shared_preferences.dart';
import 'package:movie_sphere/model/on_boarding.dart';
import 'package:movie_sphere/view/bottom_nav/bottom_nav_page.dart';
import 'package:movie_sphere/view/on_boarding/widgets/custom_dots_indicator.dart';
import 'package:movie_sphere/view/on_boarding/widgets/gradient_container.dart';
import 'package:movie_sphere/view/on_boarding/widgets/on_boarding_button.dart';
import 'package:movie_sphere/view/on_boarding/widgets/on_boarding_card.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(onboardingList[_currentIndex].bgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: GradientContainer(
          child: Column(
            children: [
              const Spacer(),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingList.length,
                  onPageChanged: (index) => setState(() => _currentIndex = index),
                  itemBuilder: (context, index) {
                    return OnboardingCard(onboarding: onboardingList[index]);
                  },
                ),
              ),
              const SizedBox(height: 20),
              CustomDotsIndicator(
                dotsCount: onboardingList.length,
                position: _currentIndex,
              ),
              const SizedBox(height: 30),
              OnBoardingButton(
                onTap: () {
                  if (_currentIndex != onboardingList.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
                  } else {
                    Get.offAll(() => const BottomNavPage());
                    MySharedPreferences.isFirstTime = false;
                  }
                },
                text: _currentIndex == onboardingList.length - 1 ? 'Get Started' : 'Next',
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

List<Onboarding> onboardingList = [
  Onboarding(
    bgImage: Images.authBackground,
    title: 'Explore Movies, Discover Magic',
    info: 'Find your favorite movies & TV shows effortlessly with a seamless experience.',
  ),
 
  Onboarding(
    bgImage: Images.authBackground,
    title: 'Save Your Favorites',
    info: 'Easily bookmark movies and access them anytime, anywhere.',
  ),
  Onboarding(
    bgImage: Images.authBackground,
    title: 'Stay Updated with Top Picks',
    info: 'Browse trending, top-rated, and upcoming movies all in one place.',
  ),
];
