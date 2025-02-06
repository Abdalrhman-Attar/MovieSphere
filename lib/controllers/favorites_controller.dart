import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_sphere/common/api_keys.dart';
import 'package:movie_sphere/common/shared_preferences.dart';

class FavoritesController extends GetxController {
  var favoriteMovies = [].obs;
  var favoriteTvShows = [].obs;
  var isLoading = false.obs;

  void addMovieToFavorites(Map<String, dynamic> movie) async {
    print("Adding movie to favorites: ${movie['title']}");
    if (!favoriteMovies.contains(movie)) {
      favoriteMovies.add(movie);
    }

    String sessionId = MySharedPreferences.sessionId;
    int accountId = MySharedPreferences.accountId;
    if (sessionId.isEmpty) return;

    final response = await http.post(
      Uri.parse("$baseUrl/account/$accountId/favorite?api_key=$apiKey&session_id=$sessionId"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "media_type": "movie",
        "media_id": movie["id"],
        "favorite": true,
      }),
    );

    print("Response status: ${response.statusCode}, body: ${response.body}");
    fetchFavoriteMovies();
  }

  void addTvShowToFavorites(Map<String, dynamic> tvShow) async {
    print("Adding TV show to favorites: ${tvShow['name']}");
    if (!favoriteTvShows.contains(tvShow)) {
      favoriteTvShows.add(tvShow);
    }

    String sessionId = MySharedPreferences.sessionId;
    int accountId = MySharedPreferences.accountId;
    if (sessionId.isEmpty) return;

    final response = await http.post(
      Uri.parse("$baseUrl/account/$accountId/favorite?api_key=$apiKey&session_id=$sessionId"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "media_type": "tv",
        "media_id": tvShow["id"],
        "favorite": true,
      }),
    );

    print("Response status: ${response.statusCode}, body: ${response.body}");
    fetchFavoriteTvShows();
  }

  void removeMovieFromFavorites(Map<String, dynamic> movie) async {
    print("Removing movie from favorites: ${movie['title']}");
    favoriteMovies.remove(movie);

    String sessionId = MySharedPreferences.sessionId;
    int accountId = MySharedPreferences.accountId;
    if (sessionId.isEmpty) return;

    final response = await http.post(
      Uri.parse("$baseUrl/account/$accountId/favorite?api_key=$apiKey&session_id=$sessionId"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "media_type": "movie",
        "media_id": movie["id"],
        "favorite": false,
      }),
    );

    print("Response status: ${response.statusCode}, body: ${response.body}");
    fetchFavoriteMovies();
  }

  void removeTvShowFromFavorites(Map<String, dynamic> tvShow) async {
    print("Removing TV show from favorites: ${tvShow['name']}");
    favoriteTvShows.remove(tvShow);

    String sessionId = MySharedPreferences.sessionId;
    int accountId = MySharedPreferences.accountId;
    if (sessionId.isEmpty) return;

    final response = await http.post(
      Uri.parse("$baseUrl/account/$accountId/favorite?api_key=$apiKey&session_id=$sessionId"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "media_type": "tv",
        "media_id": tvShow["id"],
        "favorite": false,
      }),
    );

    print("Response status: ${response.statusCode}, body: ${response.body}");
    fetchFavoriteTvShows();
  }

  Future<void> fetchFavoriteMovies() async {
    print("Fetching favorite movies...");
    String sessionId = MySharedPreferences.sessionId;
    int accountId = MySharedPreferences.accountId;
    isLoading(true);
    if (sessionId.isEmpty) {
      isLoading(false);
      return;
    }
    final response = await http.get(
      Uri.parse("$baseUrl/account/$accountId/favorite/movies?api_key=$apiKey&session_id=$sessionId"),
    );

    print("Response status: ${response.statusCode}, body: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      favoriteMovies.value = json.decode(response.body)['results'];
    }
    isLoading(false);
  }

  Future<void> fetchFavoriteTvShows() async {
    print("Fetching favorite TV shows...");
    String sessionId = MySharedPreferences.sessionId;
    int accountId = MySharedPreferences.accountId;
    isLoading(true);
    if (sessionId.isEmpty) {
      isLoading(false);
      return;
    }
    final response = await http.get(
      Uri.parse("$baseUrl/account/$accountId/favorite/tv?api_key=$apiKey&session_id=$sessionId"),
    );

    print("Response status: ${response.statusCode}, body: ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      favoriteTvShows.value = json.decode(response.body)['results'];
    }
    isLoading(false);
  }
}
