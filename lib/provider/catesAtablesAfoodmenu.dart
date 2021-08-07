// To parse this JSON data, do
//
//     final catesAtableAfoodmenu = catesAtableAfoodmenuFromJson(jsonString);

import 'dart:convert';

CatesAtablesAfoodmenu catesAtableAfoodmenuFromJson(String str) =>
    CatesAtablesAfoodmenu.fromJson(json.decode(str));

String catesAtableAfoodmenuToJson(CatesAtablesAfoodmenu data) =>
    json.encode(data.toJson());

class CatesAtablesAfoodmenu {
  CatesAtablesAfoodmenu({
    this.menu,
    this.categories,
    this.table,
  });

  List<Menu> menu;
  List<Category> categories;
  List<Tables> table;

  factory CatesAtablesAfoodmenu.fromJson(Map<String, dynamic> json) =>
      CatesAtablesAfoodmenu(
        menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        table: List<Tables>.from(json["table"].map((x) => Tables.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menu": List<dynamic>.from(menu.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "table": List<dynamic>.from(table.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.categoryId,
    this.name,
  });

  int categoryId;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "name": name,
      };
}

class Menu {
  Menu({
    this.menuId,
    this.name,
    this.price,
  });

  int menuId;
  String name;
  int price;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        menuId: json["menu_id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "menu_id": menuId,
        "name": name,
        "price": price,
      };
}

class Tables {
  Tables({
    this.locationId,
    this.name,
  });

  int locationId;
  String name;

  factory Tables.fromJson(Map<String, dynamic> json) => Tables(
        locationId: json["location_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "location_id": locationId,
        "name": name,
      };
}
