import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import './catesAtablesAfoodmenu.dart';
import 'package:http/http.dart';

class CatesTablesFoodmenu with ChangeNotifier {
  List<Category> _cates = [];
  List<Category> get cates {
    return [..._cates];
  }

  List<Tables> _tables = [];
  List<Tables> get tables {
    return [..._tables];
  }

  List<Menu> _foodMenu = [];
  List<Menu> get foodMenu {
    return [..._foodMenu];
  }

  String findTable(String tbName) {
    Tables tb = _tables.firstWhere((element) => element.name == tbName);
    return tb.locationId.toString();
  }

  Future<void> fetchCatesAndTables() async {
    final prefs = await SharedPreferences.getInstance();
    final ip = prefs.getString('ipAddress');
    final url = "http://$ip/restaurant/public/api/getData";
    try {
      final response = await get(url);

      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);

        CatesAtablesAfoodmenu ctf =
            CatesAtablesAfoodmenu.fromJson(extractedData);
        _cates = ctf.categories;
        _tables = ctf.table;
        _foodMenu = ctf.menu;
        notifyListeners();
      } else {}
    } catch (error) {}
  }
}
