import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Order {
  final String id;
  final String name;
  final String amount;
  final String siglePrice;
  Order({
    @required this.id,
    @required this.name,
    @required this.amount,
    @required this.siglePrice,
  });
}

class OrdersList with ChangeNotifier {
  List<Order> _orderItems = [];
  List<Order> get orderItems {
    return [..._orderItems];
  }

  double totalPrice = 0;

  bool isEmpty() {
    if (_orderItems.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Order findById(String id) {
    return _orderItems.firstWhere((element) => element.id == id);
  }

  void addOrder(
      {String name,
      String id,
      String amount,
      String sinPrice,
      BuildContext context}) {
    final orderItem = _orderItems.firstWhere(
        (e) => e.name == name && e.siglePrice == sinPrice,
        orElse: () => null);
    if (orderItem == null) {
      _orderItems
          .add(Order(id: id, name: name, amount: amount, siglePrice: sinPrice));
      int price = int.parse(sinPrice);
      double amt = double.parse(amount);
      totalPrice += price * amt;
      notifyListeners();
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            "به لیست سفارشات اضافه شد!",
          ),
          duration: Duration(seconds: 2)));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("خطا!",
              style: TextStyle(fontSize: 22, color: Colors.red)),
          content: const Text(
              "این محصول در لیست سفارشات ثبت شده! اگر می خواهید دوباره آن را سفارش دهید لطفاً آن را از لیست سفارشات حذف نموده، تعداد آن را زیاد نموده و دوباره سفارش دهید."),
          actions: [
            TextButton(
              child: const Text("تأیید"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }
  }

  void deleteOrder(String id) {
    Order or = findById(id);
    int price = int.parse(or.siglePrice);
    double amt = double.parse(or.amount);
    totalPrice -= price * amt;
    _orderItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Future<String> sendOrder(
      {String tableId,
      String name,
      String phone,
      String pay,
      String discount,
      String fee,
      String address,
      @required bool isIn}) async {
    final prefs = await SharedPreferences.getInstance();
    final ip = prefs.getString('ipAddress');
    final String key = isIn ? "store" : "outsideStore";
    final url = Uri.parse("http://$ip/restaurant/public/api/$key");

    List<String> orderIds = _orderItems.map((item) => item.id).toList();
    List<String> orderAmounts = _orderItems.map((item) => item.amount).toList();
    List<String> orderPrices =
        _orderItems.map((item) => item.siglePrice).toList();

    int count1 = 0;
    int count2 = 0;
    int count3 = 0;

    final bdyIn = {
      "table_order": tableId,
      
      for (var oId in orderIds) "menu_id[${count1++}]": oId,
      for (var oAmount in orderAmounts) "order_amount[${count2++}]": oAmount,
      for (var oPrice in orderPrices) "order_price[${count3++}]": oPrice,
    };
    final boy = {
      "name": name,
      "phone_num": phone,
      "payment_amount": pay,
      "discount": discount,
      "transport_fees": fee,
      "address": address,
      "total": totalPrice.toString(),
      for (var oId in orderIds) "menu_id[${count1++}]": oId,
      for (var oAmount in orderAmounts) "order_amount[${count2++}]": oAmount,
      for (var oPrice in orderPrices) "order_price[${count3++}]": oPrice,
    };

    final response = await post(url, body: isIn ? bdyIn : boy);

    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;

    if (extractedData.containsKey("msg")) {
      totalPrice = 0;
      _orderItems = [];
      notifyListeners();
      return "اطلاعات ثبت شد!\n${extractedData['msg']}";
    } else {
      var st = extractedData["errors"].toString();
      return st;
    }
  }
}
