import 'package:Attendece/provider/catesAtablesAfoodmenu.dart';
import 'package:Attendece/provider/catesTablesFoodmenu.dart';
import 'package:flutter/material.dart';
import './tableRows.dart';
import '../provider/ordersList.dart';
import '../provider/catesTablesFoodmenu.dart';
import './cardCol.dart';
import 'package:provider/provider.dart';

class CardOrder extends StatefulWidget {
  final bool isInternal;
  CardOrder(this.isInternal);
  @override
  _CardOrderState createState() => _CardOrderState();
}

class _CardOrderState extends State<CardOrder> {
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _payment = TextEditingController();
  TextEditingController _disCount = TextEditingController(text: "0");
  TextEditingController _transportFee = TextEditingController(text: "0");
  TextEditingController _address = TextEditingController(text: "هرات");
  final _form1 = GlobalKey<FormState>();
  Future<void> _saveform(bool isEmpty) async {
    debugPrint("helllllooooooooooo");
    if (!isEmpty) {
      final isValidate = _form1.currentState.validate();
      if (!isValidate) {
        return;
      }
      _form1.currentState.save();
      setState(() {
        _isLoading = true;
      });
      String message = await Provider.of<OrdersList>(context, listen: false)
          .sendOrder(
        isIn: false,
        name: _name.text,
        phone: _phone.text,
        pay: _payment.text,
        discount: _disCount.text,
        fee: _transportFee.text,
        address: _address.text,
      )
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        return value;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("خطا!"),
                content: Text(
                    "هیچ سفارشی تا هنوز اضافه نشده، لطفاً سفارش اضافه کنید!"),
                actions: [
                  TextButton(
                    child: const Text("تأیید"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    }
  }

  String selectedDesk;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final provider = Provider.of<CatesTablesFoodmenu>(context, listen: false);
    List<Tables> tableList = provider.tables;
    List<String> desks = tableList.map((item) => item.name).toList();
    String tableId =
        selectedDesk == null ? null : provider.findTable(selectedDesk);
    return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _isLoading
              ? Container(
                  width: double.infinity,
                  height: size.height * 0.7,
                  child: Center(child: CircularProgressIndicator()))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: size.height * 0.025, top: size.height * 0.01),
                      child: const Text("سفارش در حال اجرا",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Divider(),
                    Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      border: TableBorder.all(color: Colors.black45),
                      children: [
                        TableRow(children: [
                          const TableRowHeader("اسم سفارش"),
                          const TableRowHeader("تعداد"),
                          const TableRowHeader("قیمت فی"),
                          const TableRowHeader("لغو"),
                        ])
                      ],
                    ),
                    TableRows(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text("قیمت کل:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 5),
                        Text(
                            Provider.of<OrdersList>(context)
                                .totalPrice
                                .toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    widget.isInternal
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("انتخاب میز",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                ),
                                height: size.height * 0.08,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black45),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: DropdownButtonHideUnderline(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: DropdownButton(
                                        items: desks
                                            .map((item) => DropdownMenuItem(
                                                value: item,
                                                child: Column(
                                                  children: [
                                                    Text(item,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black)),
                                                    Divider(
                                                        color: Colors.black54),
                                                  ],
                                                )))
                                            .toList(),
                                        value: selectedDesk,
                                        hint: const Text("انتخاب کنید..."),
                                        onChanged: (newItem) {
                                          setState(() {
                                            selectedDesk = newItem;
                                          });
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Form(
                            key: _form1,
                            child: CardCol(
                              name: _name,
                              phone: _phone,
                              payment: _payment,
                              disCount: _disCount,
                              transportFee: _transportFee,
                              address: _address,
                            )),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.07,
                          width: size.width * 0.55,
                          child: ElevatedButton(
                              child: const Text(
                                "ارسال",
                                style: TextStyle(fontSize: 18),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                final ordersEmpty = Provider.of<OrdersList>(
                                        context,
                                        listen: false)
                                    .isEmpty();
                                if (widget.isInternal) {
                                  sendInternal(tableId, ordersEmpty);
                                } else {
                                  _saveform(ordersEmpty);
                                }
                                _name.text = "";
                                _phone.text = "";
                                _payment.text = "";
                                _disCount.text = "0";
                                _transportFee.text = "0";
                                _address.text = "هرات";
                              }),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.045),
                  ],
                ),
        ));
  }

  void sendInternal(String tableId, bool ordersEmpty) async {
    if (tableId != null && !ordersEmpty) {
      setState(() {
        _isLoading = true;
      });
      String message = await Provider.of<OrdersList>(context, listen: false)
          .sendOrder(tableId: tableId, isIn: true)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        return value;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("خطا!"),
                content: Text(tableId == null
                    ? "لطفاً شماره میز را انتخاب کنید!"
                    : "هیچ سفارشی تا هنوز اضافه نشده، لطفاً سفارش اضافه کنید!"),
                actions: [
                  TextButton(
                    child: const Text("تأیید"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    }
  }
}

class TableRowHeader extends StatelessWidget {
  final String name;
  const TableRowHeader(this.name);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }
}
