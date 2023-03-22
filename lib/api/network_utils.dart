import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/utilities/utility_functions.dart';

import '../data/auth_utils.dart';

class NetworkUtils {

  final header = {
    "Content-Type":"application/json",
    "token":AuthUtils.token ?? ""
  };

  Future<dynamic> postMethod(String url,
      {Map<String, String>? body,
        VoidCallback? onUnAuthorize,
      }) async {
    try {
      final http.Response response = await http.post(Uri.parse(url),
          headers: header,
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        return json.decode(response.body);
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

  Future<dynamic> getMethod({required String url, VoidCallback? onUnAuthorize}) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: header
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnAuthorize != null) {
          onUnAuthorize();
        } else {
          log("Something went Wrong");
          Utility.moveToLoginPage();
        }
      } else {
        log("Something went wrong ${response.statusCode}");
      }

    } catch (e) {
      log('Error $e');
    }
  }
}


