import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_sphere/common/api_keys.dart';
import 'package:movie_sphere/common/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class SessionManagerController extends GetxController {
  var sessionId = MySharedPreferences.sessionId.obs;
  var accountId = MySharedPreferences.accountId.obs;
  var requestToken = MySharedPreferences.requestToken.obs;

  Future<void> createRequestToken() async {
    final response = await http.get(
      Uri.parse("$baseUrl/authentication/token/new?api_key=$apiKey"),
    );

    if (response.statusCode == 200) {
      final token = json.decode(response.body)['request_token'];
      requestToken.value = token;
      MySharedPreferences.requestToken = token;
      print("Request token created successfully: $token");
    } else {
      print("Failed to create request token: ${response.body}");
    }
  }

  Future<void> authenticateUser() async {
    if (requestToken.value.isNotEmpty) {
      final authUrl = "https://www.themoviedb.org/authenticate/${requestToken.value}";
      print("Opening authentication URL: $authUrl");
      if (await canLaunch(authUrl)) {
        await launch(authUrl);
      } else {
        print("Could not launch URL");
      }
    } else {
      print("Request token is empty. Generate a request token first.");
    }
  }

  Future<void> createSession() async {
    if (requestToken.value.isEmpty) {
      print("Request token is required. Generate and authorize it first.");
      return;
    }

    final response = await http.post(
      Uri.parse("$baseUrl/authentication/session/new?api_key=$apiKey"),
      body: jsonEncode({"request_token": requestToken.value}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final session = json.decode(response.body)['session_id'];
      sessionId.value = session;
      MySharedPreferences.sessionId = session;

      print("Session created successfully: $session");
    } else {
      print("Failed to create session: ${response.body}");
    }
  }

  Future<void> getAccountId() async {
    final response = await http.get(
      Uri.parse("$baseUrl/account?api_key=$apiKey&session_id=${sessionId.value}"),
    );

    if (response.statusCode == 200) {
      final account = json.decode(response.body)['id'];
      accountId.value = account;
      MySharedPreferences.accountId = account;
      print("Account ID retrieved successfully: $account");
    } else {
      print("Failed to retrieve account ID: ${response.body}");
    }
  }

  void logout() {
    MySharedPreferences.clearSession();
    sessionId.value = "";
    accountId.value = 0;
    requestToken.value = "";
    print("User logged out successfully.");
  }
}
