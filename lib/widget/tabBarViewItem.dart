import 'package:Attendece/provider/catesAtablesAfoodmenu.dart';
import 'package:flutter/material.dart';
import './itemTile.dart';
import '../provider/catesTablesFoodmenu.dart';
import '../provider/categoryItems.dart';
import '../provider/cateItem.dart';
import 'package:provider/provider.dart';

class TabBarViewItem extends StatefulWidget {
  final String cateId;
  final String cateName;
  TabBarViewItem({@required this.cateId, @required this.cateName});

  @override
  _TabBarViewItemState createState() => _TabBarViewItemState();
}

class _TabBarViewItemState extends State<TabBarViewItem> {
  bool _isLoading = false;
  bool _isInit = true;
  bool _isFirstTime = true;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (_isInit && widget.cateName != "غذا") {
      setState(() {
        _isLoading = true;
      });
      Provider.of<CategoryItems>(context)
          .fetchCatesItems(widget.cateId)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    bool _isFood = widget.cateName == "غذا" ? true : false;

    List<Menu> foodMenu = Provider.of<CatesTablesFoodmenu>(context).foodMenu;
    List<Column> menuItems = foodMenu
        .map((item) => Column(children: [
              ItemTile(itemName: item.name,id:item.menuId.toString(), price: item.price.toString()),
              Divider(indent: 20, endIndent: 20, color: Colors.black26),
            ]))
        .toList();

    final provider = Provider.of<CategoryItems>(context);

    List<CateItem> cItems = provider.cateItemsById(widget.cateId);

    List cMenuItems = cItems
        .map((item) => Column(mainAxisSize: MainAxisSize.min, children: [
              ItemTile(itemName: item.name,id:item.menuId.toString(), price: item.price.toString()),
              Divider(indent: 20, endIndent: 20, color: Colors.black26),
            ]))
        .toList();

    return _isLoading
        ? Container(child: Center(child: CircularProgressIndicator()))
        : RefreshIndicator(
            onRefresh: () {
              if (widget.cateName == "غذا") {
                setState(() {
                  _isFirstTime = false;
                });
              }

              return provider.refreshCatesItems(widget.cateId);
            },
            child: ListView(
              scrollDirection: Axis.vertical,
              children: _isFood && _isFirstTime ? menuItems : cMenuItems,
            ),
          );
  }
}
