
import 'package:eisapp/network/api_consts.dart';
import 'package:http/http.dart' as http;


class ApiService {
    static Future<http.Response> getData(String url)async{
      print("-Url : ${base+url}");
        http.Response response = await http.get(Uri.parse(base+url));
        print("Response Code : ${response.statusCode}");
        print("Response Body : ${response.body}");
        return response;
     }
}