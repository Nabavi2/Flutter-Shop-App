import 'package:flutter/material.dart';
import '../provider/ordersList.dart';
import 'package:provider/provider.dart';

class ItemTile extends StatefulWidget {
  final String itemName;
  final String price;
  final String id;
  ItemTile({@required this.itemName, @required this.price, @required this.id});

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  TextEditingController tec = TextEditingController(text: "1");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListTile(
      title: Padding(
        padding: EdgeInsets.only(right: size.width * 0.04),
        child: SizedBox(
              height: size.height * 0.05,
              width: size.width * 0.25,
              child: FittedBox(
            
              child: Text(widget.itemName, style: TextStyle(fontSize: 16)))),
      ),
      trailing: Container(
        width: size.width * 0.53,
        child: Row(
          children: [
            Container(
              width: size.width * 0.1,
              height: size.height * 0.06,
              child: Center(
                child: Text(
                  widget.price,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(width: size.width * 0.065),
            Container(
                height: size.height * 0.043,
                width: size.width * 0.12,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black87,
                )),
                child: TextFormField(
                  controller: tec,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                )),
            SizedBox(width: size.width * 0.08),
            SizedBox(
              width: size.width * 0.12,
              child: ElevatedButton(
                child: Padding(
                  padding: EdgeInsets.only(left: size.width * 0.05),
                  child: const Icon(Icons.add),
                ),
                onPressed: () {
                  Provider.of<OrdersList>(context, listen: false).addOrder(
                      context: context,
                      id: widget.id,
                      name: widget.itemName,
                      sinPrice: widget.price,
                      amount: tec.text);
                  tec.text = "1";
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
