import "package:get/get.dart";
import "package:http/http.dart" as http;
import "dart:convert";

import "package:movie_sphere/common/api_keys.dart";

class DiscoverTVController extends GetxController {
  var discoverTVShows = [].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    fetchDiscoverTVShows();
    super.onInit();
  }

  Future<void> fetchDiscoverTVShows() async {
    isLoading(true);
    final response = await http.get(Uri.parse("$baseUrl/discover/tv?api_key=$apiKey"));
    if (response.statusCode == 200) {
      discoverTVShows.value = json.decode(response.body)["results"];
    }
    isLoading(false);
  }

    void searchTVShows(String query) async {
    isLoading(true);
    final response = await http.get(Uri.parse("$baseUrl/search/tv?api_key=$apiKey&query=${Uri.encodeComponent(query)}"));
    if (response.statusCode == 200) {
      discoverTVShows.value = json.decode(response.body)["results"];
    }
    isLoading(false);
  }
}
