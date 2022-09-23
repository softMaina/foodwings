import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class NetWorkHandler {
  static final client = http.Client();
  static final storage = GetStorage();
  static Future<String> post(var body, String endPoint) async {
    var response = await client.post(buildUrl(endPoint),
        body: body, headers: {"Content-type":"application/json"});
    var data1 = response.body;
    return response.body;
  }

  static Uri buildUrl(String endPoint) {
    String host = "https://service.io.co.ke/v1/api/";

    final apiPath = host + endPoint;
    return Uri.parse(apiPath);
  }

  static void storeToken(String token) async {
    await storage.write("auth", token);
  }

  static Future<String?> getToken(String token) async {
    var myToken = await storage.read(token);
    return myToken;
  }
}
