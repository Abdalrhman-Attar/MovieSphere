import "package:get/get.dart";
import "package:http/http.dart" as http;
import "dart:convert";

import "package:movie_sphere/common/api_keys.dart";

class TopRatedMoviesController extends GetxController {
  var topRatedMovies = [].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    fetchTopRatedMovies();
    super.onInit();
  }

  Future<void> fetchTopRatedMovies() async {
    isLoading(true);
    final response = await http.get(Uri.parse("$baseUrl/movie/top_rated?api_key=$apiKey"));
    if (response.statusCode == 200) {
      topRatedMovies.value = json.decode(response.body)["results"];
    }
    isLoading(false);
  }
}
