import 'package:http/http.dart' as http;

class ApiHelper {
  static Future<http.Response> get(String url) async {
    // Placeholder for local device API call
    return await http.get(Uri.parse(url));
  }

  static Future<http.Response> post(String url, Map<String, dynamic> body) async {
    return await http.post(Uri.parse(url), body: body);
  }
}