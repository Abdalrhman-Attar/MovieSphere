import "package:get/get.dart";
import "package:http/http.dart" as http;
import "dart:convert";

import "package:movie_sphere/common/api_keys.dart";

class PopularMoviesController extends GetxController {
  var popularMovies = [].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    fetchPopularMovies();
    super.onInit();
  }

  Future<void> fetchPopularMovies() async {
    isLoading(true);
    final response = await http.get(Uri.parse("$baseUrl/movie/popular?api_key=$apiKey"));
    if (response.statusCode == 200) {
      popularMovies.value = json.decode(response.body)["results"];
    }
    isLoading(false);
  }
}
