import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrences extends ChangeNotifier {
  Future<void> setData(String ip) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("ipAddress", ip);
  }

  Future<bool> hasData() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString("ipAddress");
    if (data != null) {
      return true;
    } else {
      return false;
    }
  }
}
