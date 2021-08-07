import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import './cateItem.dart';
import 'package:http/http.dart';

class CategoryItems with ChangeNotifier {
  List<CateItem> _cateItems = [];
  List<CateItem> get cateItems {
    return [..._cateItems];
  }

  List<String> fetchedIds = [];

  List<CateItem> cateItemsById(String id) {
    final items =
        _cateItems.where((item) => item.categoryId.toString() == id).toList();
    return items;
  }

  Future<void> fetchCatesItems(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final ip = prefs.getString('ipAddress');
    final url = "http://$ip/restaurant/public/api/getMenu?id=$id";
    try {
      if (!fetchedIds.contains(id)) {
        final response = await get(url);

        if (response.statusCode == 200) {
          final cateItems = cateItemFromJson(response.body);

          fetchedIds.add(id);
          _cateItems.addAll(cateItems);
          notifyListeners();
        } else {}
      } else {}
    } catch (error) {}
  }

  Future<void> refreshCatesItems(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final ip = prefs.getString('ipAddress');
    final url = "http://$ip/restaurant/public/api/getMenu?id=$id";
    try {
      final response = await get(url);

      if (response.statusCode == 200) {
        final cateItems = cateItemFromJson(response.body);
        final cateIds = cateItems.map((e) => e.menuId).toList();
        final _cateIds = _cateItems.map((e) => e.menuId).toList();
        List<int> newIds = [];
        for (int i = 0; i < cateIds.length; i++) {
          if (!_cateIds.contains(cateIds[i])) {
            newIds.add(cateIds[i]);
          }
        }

        for (int i = 0; i < newIds.length; i++) {
          var item = cateItems.firstWhere((e) => e.menuId == newIds[i]);
          _cateItems.add(item);
        }

        notifyListeners();
      } else {}
    } catch (error) {}
  }
}
