import 'package:flutter/material.dart';
import 'package:movie_sphere/common/controllers.dart';
import 'package:movie_sphere/common/my_icons.dart';
import 'package:movie_sphere/view/bottom_nav/widgets/bottom_nav_item.dart';
import 'package:movie_sphere/view/main/favorites/favorites_page.dart';
import 'package:movie_sphere/view/main/home/home_page.dart';
import 'package:movie_sphere/view/main/top_rated_movies/top_rated_movies_page.dart';
import 'package:movie_sphere/view/main/search/search_page.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _selectedIndex = 0;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildNavigator(HomePage(), 0),
      _buildNavigator(SearchPage(), 1),
      _buildNavigator(TopRatedMoviesPage(), 2),
      _buildNavigator(FavoritesPage(), 3),
    ];
  }

  Widget _buildNavigator(Widget page, int index) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => page),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleWillPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomNavItem(
            icon: MyIcons.homeOutline,
            activeIcon: MyIcons.home,
            isSelected: _selectedIndex == 0,
            label: 'Home',
            index: 0,
            onItemTapped: _onItemTapped,
          ),
          BottomNavItem(
            icon: MyIcons.searchOutline,
            activeIcon: MyIcons.search,
            isSelected: _selectedIndex == 1,
            label: 'Discover',
            index: 1,
            onItemTapped: _onItemTapped,
          ),
          BottomNavItem(
            icon: MyIcons.ratingOutline,
            activeIcon: MyIcons.rating,
            isSelected: _selectedIndex == 2,
            label: 'Top Rated',
            index: 2,
            onItemTapped: _onItemTapped,
          ),
          BottomNavItem(
            icon: MyIcons.favoritesOutline,
            activeIcon: MyIcons.favorites,
            isSelected: _selectedIndex == 3,
            label: 'Favorites',
            index: 3,
            onItemTapped: _onItemTapped,
          ),
        ],
      ),
    );
  }

  Future<bool> _handleWillPop() async {
    final navigator = _navigatorKeys[_selectedIndex].currentState;
    if (navigator == null || !navigator.canPop()) {
      return _showExitConfirmation(context);
    }
    navigator.pop();
    return false;
  }

  Future<bool> _showExitConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Controllers.theme.currentThemeData.colorScheme.surface,
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the App?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  'No',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  'Yes',
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
