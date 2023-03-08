import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:task_manager/utilities/toasts.dart';
import 'package:task_manager/utilities/urls.dart';

import '../data/auth_utils.dart';

class NetworkUtils {

  final tokenHeader = {
    "Content-Type":"application/json",
    "token":AuthUtils.token ?? ""
  };

  Future<dynamic> postMethod(String url,
      {Map<String, String>? body,
        VoidCallback? onUnAuthorize,
      }) async {
    try {
      final http.Response response = await http.post(Uri.parse(url),
          headers: tokenHeader,
          body: jsonEncode(body));
      log(response.body);
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

  Future<List> taskListRequest(status) async {
    var url = Uri.parse("${Urls.taskListURL}$status");
    var response = await http.get(
        url,
        headers: tokenHeader
    );
    var responseCode = response.statusCode;
    var responseBody = json.decode(response.body);

    if(responseCode == 200 && responseBody['status'] == "success") {
      return responseBody['data'];
    } else {
      errorToast("Request fail");
      return [];
    }
  }

  Future<List> taskCount() async {
    var url = Uri.parse(Urls.taskCounterURL);
    var response = await http.get(
        url,
        headers: tokenHeader
    );
    var responseCode = response.statusCode;
    var responseBody = json.decode(response.body);

    if(responseCode == 200 && responseBody['status'] == "success") {
      return responseBody['data'];
    } else {
      errorToast("Request fail");
      return [];
    }
  }

  Future<bool> deleteTask(id) async {
    var url = Uri.parse(Urls.deleteTaskURL(id));
    var response = await http.get(url, headers: tokenHeader);

    var responseCode = response.statusCode;
    var responseBody = json.decode(response.body);

    if (responseCode == 200 && responseBody['status'] == "success") {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateTaskStatus(id, newStatus) async {
    var url = Uri.parse(Urls.updateTaskUrl(id, newStatus));
    var response = await http.get(url, headers: tokenHeader);

    var responseCode = response.statusCode;
    var responseBody = json.decode(response.body);

    if (responseCode == 200 && responseBody['status'] == "success") {
      return true;
    } else {
      return false;
    }
  }

}


