// To parse this JSON data, do
//
//     final cateItem = cateItemFromJson(jsonString);

import 'dart:convert';

List<CateItem> cateItemFromJson(String str) =>
    List<CateItem>.from(json.decode(str).map((x) => CateItem.fromJson(x)));

String cateItemToJson(List<CateItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CateItem {
  CateItem({
    this.menuId,
    this.categoryId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.price,
  });

  int menuId;
  int categoryId;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  int price;

  factory CateItem.fromJson(Map<String, dynamic> json) => CateItem(
        menuId: json["menu_id"],
        categoryId: json["category_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "menu_id": menuId,
        "category_id": categoryId,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "price": price,
      };
}
