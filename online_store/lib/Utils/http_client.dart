import 'package:http/http.dart' as http;

class HttpClient {
  static var client = http.Client();
  static var headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}
