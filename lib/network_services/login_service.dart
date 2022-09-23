//----//
/* @ᒎ𝓞η-𝐄ᒪ☠ */
//----//

import 'dart:async';
import 'dart:convert';
// import 'package:edupesa_parent_app/constants/urls.dart';
// import 'package:edupesa_parent_app/main/models/error_response.dart';
// import 'package:edupesa_parent_app/main/models/first_time_login_model.dart';
// import 'package:edupesa_parent_app/main/models/login_response.dart';
import 'package:FoodWings/models/misc/error_message.dart';
import 'package:FoodWings/network_services/network_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

import '../models/auth/login.dart';
import '../models/auth/login_response.dart';
import '../screens/home/home_screen.dart';

class LoginService {
  static var client = http.Client();
  static GetStorage store = GetStorage();

/* ****************************************************************** */
/* ****************************************************************** */
/* ****************************************************************** */
/* ****************************************************************** */

//Simple login service

  static Future login(String username, String password) async {
    print(username);
    var msisdn = int.parse(username);
    print(msisdn);

    UserLogin userLogin = UserLogin(username: msisdn, password: password);

    var body = userLoginToJson(userLogin);

    var response = await http.post(NetWorkHandler.buildUrl("user/login"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: body);
    var data = response.body;

    if (response.statusCode == 200) {
      var loginResponse = loginResponseFromJson(data);
      Get.offAll(const HomeScreen());
      // print("Login response:" + loginResponse.toString());
      var resp = jsonDecode(response.body);
      print("Responses:     " + resp.toString());

      store.write("auth", resp['auth']);
      store.write("name", resp['name']);
      // print("Login Response" + data);
      var readtoken = store.read("auth");
      var readUserName = store.read("name");
      print("Login Response auth token" + readtoken);
      print("Franchise Name" + readUserName);

      // Get.offAll(const HomeScreen());
      return loginResponseFromJson(data);
    } else if (response.statusCode == 417) {
      // Get.snackbar("Error check uour credentiial or signup");
      var errrr = jsonDecode(data);
      var errorMessage = errrr["data"];
      print("Message Errorrrrrrrrr ${errorMessage}");
      print('User Activation ERROR: ' + data.toString());

      Get.snackbar("Message", errorMessage, duration: 5.seconds);

      return erroMessageFromJson(data);
    }
  }

/* ****************************************************************** */
/* ****************************************************************** */
/* ****************************************************************** */
/* ****************************************************************** */

  // *********************** */ User
  static Future loginUser(String fcmToken, String username, String pin,
      BuildContext context) async {
    var url = NetWorkHandler.buildUrl("user/login");

    Map<String, String> headers = {"Content-type": "application/json"};

    String payload = jsonEncode(<String, String>{
      "username": username,
      "password": pin,
      "fcmToken": fcmToken,
    });

    print(url);
    print(payload);

    var response = await client.post(url, headers: headers, body: payload);

    var message = '', status = 0, jsonString = '';

    jsonString = response.body;
    int s = response.statusCode;
    print('STATUS $s');

    if (response.statusCode == 200) {
      print('Login SUCCESS: ' + jsonString.toString());
      var resp = jsonDecode(response.body);
      var token = resp['auth'];

      return loginResponseFromJson(jsonString);
    } else {
      print('Login ERROR: ' + jsonString.toString());
      status = response.statusCode;
      var resp = jsonDecode(response.body);
      message = resp['message'];

      print('ERROR: ' + status.toString());
      print('Error: ' + message);

      return erroMessageFromJson(jsonString);
    }

    // if (response.statusCode == 401) {
    //   //print('Login ERROR: ' + jsonString.toString());
    //   return firstTimeLoginModelFromJson(jsonString);
    // } else {
    //   print('Login ERROR: ' + jsonString.toString());
    //   status = response.statusCode;
    //   var resp = jsonDecode(response.body);
    //   message = resp['message'];

    //   print('ERROR: ' + status.toString());
    //   print('Error: ' + message);

    //   return errorResponseFromJson(jsonString);
    // }
  }

  //--------------------------------------------------------------------------//
  //--------------------------------------------------------------------------//
  //--------------------------------------------------------------------------//

  static Future loginUser2(
    String fcmToken,
    String username,
    String pin,
  ) async {
    var url = NetWorkHandler.buildUrl("user/login");

    Map<String, String> headers = {"Content-type": "application/json"};

    String payload = jsonEncode(<String, String>{
      "username": username,
      "password": pin,
      "fcm_token": fcmToken,
    });

    print(payload);

    var response = await client.post(url, headers: headers, body: payload);

    var jsonString = '';

    jsonString = response.body;

    if (response.statusCode == 200) {
      return loginResponseFromJson(jsonString);
    } else {
      return erroMessageFromJson(jsonString);
    }
  }

  //--------------------------------------------------------------------------//
  //--------------------------------------------------------------------------//
  //--------------------------------------------------------------------------//

  // static Future updateProfile(
  //   String firstName,
  //   String lastName,
  //   String primaryMsisdn,
  //   String secondaryMsisdn,
  //   String email,
  //   String id,
  //   String auth,
  // ) async {
  //   var url = Urls.parentProfileUpdate + id;

  //   Map<String, String> headers = {
  //     "Content-type": "application/json",
  //     "AUTH": auth,
  //   };

  //   String payload = jsonEncode(<String, String>{
  //     "firstName": firstName,
  //     "lastName": lastName,
  //     "primaryMsisdn": primaryMsisdn,
  //     "secondaryMsisdn": secondaryMsisdn,
  //     "email": email,
  //   });

  //   print(payload);

  //   var response =
  //       await client.post(Uri.parse(url), headers: headers, body: payload);

  //   var jsonString = '';

  //   jsonString = response.body;

  //   if (response.statusCode == 200) {
  //     return errorResponseFromJson(jsonString);
  //   } else if (response.statusCode == 401) {
  //     return firstTimeLoginModelFromJson(jsonString);
  //   } else {
  //     return errorResponseFromJson(jsonString);
  //   }
  // }

  // //--------------------------------------------------------------------------//
  // //--------------------------------------------------------------------------//
  // //--------------------------------------------------------------------------//

  // static Future setNewPin(
  //   String code,
  //   String userId,
  //   String role,
  //   String pin,
  //   String confirm_pin,
  // ) async {
  //   var url = Urls.setNewPinAfterFirstLogin;

  //   Map<String, String> headers = {"Content-type": "application/json"};

  //   String payload = jsonEncode(<String, String>{
  //     "code": code,
  //     "userId": userId,
  //     "role": role,
  //     "password": pin,
  //     "confirm_password": confirm_pin,
  //   });

  //   print(payload);

  //   var response =
  //       await client.post(Uri.parse(url), headers: headers, body: payload);

  //   var jsonString = '';

  //   jsonString = response.body;
  //   int s = response.statusCode;
  //   print('STATUS FT $s');

  //   if (response.statusCode == 200) {
  //     return errorResponseFromJson(jsonString);
  //   } else {
  //     return errorResponseFromJson(jsonString);
  //   }
  // }
}
