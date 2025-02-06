import "package:get/get.dart";
import "package:http/http.dart" as http;
import "dart:convert";

import "package:movie_sphere/common/api_keys.dart";

class UpcomingMoviesController extends GetxController {
  var upcomingMovies = [].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    fetchUpcomingMovies();
    super.onInit();
  }

  Future<void> fetchUpcomingMovies() async {
    isLoading(true);
    final response = await http.get(Uri.parse("$baseUrl/movie/upcoming?api_key=$apiKey"));
    if (response.statusCode == 200) {
      upcomingMovies.value = json.decode(response.body)["results"];
    }
    isLoading(false);
  }
}
