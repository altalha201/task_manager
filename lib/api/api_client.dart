import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager/utilities/toasts.dart';

var baseURL = "https://task.teamrabbil.com/api/v1";
var requestHeader={"Content-Type":"application/json"};

Future<bool> registrationRequest(data) async {
  var url = Uri.parse("$baseURL/registration");
  var requestBody = json.encode(data);
  var response = await http.post(url, headers: requestHeader, body: requestBody);

  var responseCode = response.statusCode;
  var responseBody = json.decode(response.body);

  if(responseCode == 200 && responseBody['status'] == 'success') {
    successToast("Account Created");
    return true;
  } else {
    errorToast("Request Failed, try again");
    return false;
  }
}
