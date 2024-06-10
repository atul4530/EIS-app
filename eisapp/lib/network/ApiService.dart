
import 'package:eisapp/network/api_consts.dart';
import 'package:http/http.dart' as http;


class ApiService {
    static Future<http.Response> getData(String url,{bool fromApproval=false})async{
      print("-Url : ${base+url}");
        http.Response response = await http.get(Uri.parse((fromApproval?base:base_product)+url));
        print("Response Code : ${response.statusCode}");
        print("Response Body : ${response.body}");
        return response;
     }
}