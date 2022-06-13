import 'dart:convert';
import 'dart:io';

import 'package:bank_misr/Data/api_links.dart';
import 'package:bank_misr/Data/html_request.dart';
import 'package:http/http.dart' as http;

class AddTaskServices {
  Future<bool> AddTaskorGoal(String Url, String title, String description,String token, String? userid) async {
    try {
      print(Url+userid!);
      var response = await postRequest(
          Url+userid!,
          jsonEncode(<String, String>{
            "title": title,
            "description": description
          }),token);
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
