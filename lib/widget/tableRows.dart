import 'package:flutter/material.dart';
import '../provider/ordersList.dart';
import 'package:provider/provider.dart';

class TableRows extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Order> orders = Provider.of<OrdersList>(context).orderItems;
    List<TableRow> rows = orders
        .map((orItem) => TableRow(children: [
              Center(child: Text(orItem.name)),
              Center(child: Text(orItem.amount)),
              Center(child: Text(orItem.siglePrice)),
              IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    Provider.of<OrdersList>(context, listen: false)
                        .deleteOrder(orItem.id);
                  }),
            ]))
        .toList();

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(color: Colors.black45),
      children: rows,
    );
  }
}
