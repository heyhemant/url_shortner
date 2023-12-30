import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_shortner/constants/api_constants.dart';

class ApiServices {

  static final ApiServices _instance = ApiServices._internal();
  factory ApiServices() => _instance;
  ApiServices._internal(); 

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://api.example.com/data'));
    if (response.statusCode == 200) {
      // Parse the JSON response
      final data = jsonDecode(response.body);
      print(data);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<http.Response> getShortUrl(String longUrl) async {
    http.Response response = await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.urlEndPoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'long_url': longUrl,
      }),
    );
    return response;
  }
}
