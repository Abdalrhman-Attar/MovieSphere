import "package:get/get.dart";
import "package:http/http.dart" as http;
import "dart:convert";

import "package:movie_sphere/common/api_keys.dart";

class DiscoverMoviesController extends GetxController {
  var discoverMovies = [].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    fetchDiscoverMovies();
    super.onInit();
  }

  Future<void> fetchDiscoverMovies() async {
    isLoading(true);
    final response = await http.get(Uri.parse("$baseUrl/discover/movie?api_key=$apiKey"));
    if (response.statusCode == 200) {
      discoverMovies.value = json.decode(response.body)["results"];
    }
    isLoading(false);
  }

   void searchMovies(String query) async {
    isLoading(true);
    final response = await http.get(Uri.parse("$baseUrl/search/movie?api_key=$apiKey&query=${Uri.encodeComponent(query)}"));
    if (response.statusCode == 200) {
      discoverMovies.value = json.decode(response.body)["results"];
    }
    isLoading(false);
  }
}
