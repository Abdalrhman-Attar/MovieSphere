import "package:get/get.dart";
import "package:http/http.dart" as http;
import "dart:convert";

import "package:movie_sphere/common/api_keys.dart";

class TopRatedTVController extends GetxController {
  var topRatedTV = [].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    fetchTopRatedTV();
    super.onInit();
  }

  Future<void> fetchTopRatedTV() async {
    isLoading(true);
    final response = await http.get(Uri.parse("$baseUrl/tv/top_rated?api_key=$apiKey"));
    if (response.statusCode == 200) {
      topRatedTV.value = json.decode(response.body)["results"];
    }
    isLoading(false);
  }
}
