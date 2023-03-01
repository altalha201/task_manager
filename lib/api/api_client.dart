import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:task_manager/utilities/toasts.dart';

class NetworkUtils {
  Future<dynamic> getMethod(String url, {VoidCallback? onUnAuthorize}) async {
    try {
      final http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnAuthorize != null) {
          onUnAuthorize();
        }
        else {
          errorToast("Something Went wrong");
        }
      } else {
        errorToast("Something Went wrong");
      }

    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> postMethod(String url,
      {Map<String, String>? body, VoidCallback? onUnAuthorize, String? token}) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json", 'token' : token ?? ''},
        body: jsonEncode(body)
      );
      if(response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnAuthorize != null) {
          onUnAuthorize();
        }
        else {
          errorToast("Something Went wrong");
        }
      } else {
        errorToast("Something Went wrong");
      }

    } catch (e) {
      print(e);
    }
  }
}

