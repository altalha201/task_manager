import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:task_manager/utilities/toasts.dart';

import '../data/auth_utils.dart';

class NetworkUtils {
  Future<dynamic> getMethod(String url, {VoidCallback? onUnAuthorize}) async {
    try {
      log(url);
      log(AuthUtils.token ?? "Token not Found");
      final http.Response response = await http.get(
          Uri.parse(url),
          headers: {"Content-Type": "application/json", 'token' : AuthUtils.token ?? ''}
      );
      if(response.statusCode == 200) {
        log(response.body);
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
      log('Error $e');
    }
  }

  Future<dynamic> postMethod(String url,
      {Map<String, String>? body,
        VoidCallback? onUnAuthorize,
      }) async {
    try {
      final http.Response response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            'token': AuthUtils.token ?? ''
          },
          body: jsonEncode(body));
      log(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnAuthorize != null) {
          onUnAuthorize();
        } else {
          log("Something went Wrong");
        }
      } else {
        log("Something went wrong ${response.statusCode}");
      }
    } catch (e) {
      log('Error $e');
    }
  }

}

