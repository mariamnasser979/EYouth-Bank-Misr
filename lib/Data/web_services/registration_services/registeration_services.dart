import 'dart:convert';

import 'package:bank_misr/data/web_services/registration_services/registration_api_links.dart';
import 'package:bank_misr/presentation/resources/strings_manager.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../api_links.dart';

class RegisterationWebServices {
  late Dio dio;
  late Dio authenticatedDio;
  String? token;
  EndPoints endPoints=EndPoints();
  RegisterationWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseLink,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      headers:{"Content-Type": "application/json"}
    );
    dio = Dio(options);
    BaseOptions authenticatedDioOptions = BaseOptions(
        baseUrl: baseLink,
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000,
        headers: {'Authorization': 'Bearer$token',  "Content-Type": "application/json"});
    authenticatedDio = Dio(authenticatedDioOptions);
  }

  Future<dynamic> signIn( String email, String password) async {
    try {
      var response =
          await http.post(Uri.parse(endPoints.loginLink),
              headers: <String, String>{
                "Content-Type": "application/json",
              },
              body: jsonEncode(<String, String>{
            
                "username": email,
                "password": password
                
              }));
              print(response.body);
      if (response.statusCode == 200) {
        print("************************************************************");
        print(response);
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp(String fullname, String username, String email,String password, String age) async {
     try {
      Response response = await dio.post(
          endPoints.registerLink,
         data:jsonEncode(<String, String>{
                "fullname": fullname,
                "username": username,
                "email": email,
                "password": password,
                "age": age
              }));

                if (response.statusCode == 200) {
                    return true;

                }else{
                  return false;
                }


    
    } catch (e) {
      print(e.toString());
            return false;
    }

  }

  Future<dynamic> isUserNameExist( String userName) async {
    try {
      var response =
          await http.post(Uri.parse(endPoints.isUserNameExistLink),
              headers: <String, String>{
                "Content-Type": "application/json",
              },
              body: jsonEncode(<String, String>{
                "username": userName 
              }));
              print(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      return false;
    }
  }

 Future<dynamic> isEmailExist( String email) async {
    try {
      var response =
          await http.post(Uri.parse(endPoints.isEmailExistLink),
              headers: <String, String>{
                "Content-Type": "application/json",
              },
              body: jsonEncode(<String, String>{
                "email": email
              }));
              print(response.body);
      if (response.statusCode == 200) {

        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      return false;
    }
  }
}
