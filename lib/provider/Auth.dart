import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  Future<bool> login(String em, String pas) async {
    final prefs = await SharedPreferences.getInstance();
    final ip = prefs.getString('ipAddress');

    var url = "http://$ip/restaurant/public/api/auth/login";

    debugPrint(em + " " + pas);

    final response = await http.post(url, body: {
      'email': em,
      'password': pas,
    });
    final responseData = jsonDecode(response.body) as Map;
    debugPrint("hellllooooooo");
    debugPrint(ip);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      debugPrint(responseData.toString());
      if (responseData.containsKey("error")) {
        debugPrint("false");
        return false;
      } else {
        debugPrint("true");
        return true;
      }
    } else {
      throw 'Sorry! \'\n You don\'t have any connection with server';
    }
  }
}
