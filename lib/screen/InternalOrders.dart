import 'package:flutter/material.dart';
import '../widget/tabBarViewItem.dart';
import '../widget/cardOrder.dart';
import '../provider/catesTablesFoodmenu.dart';
import 'package:provider/provider.dart';
import '../widget/main_drawer.dart';
import 'package:persian_fonts/persian_fonts.dart';

class InternalOrders extends StatefulWidget {
  final bool isInternal;
  InternalOrders(this.isInternal);
  static const routeName = "/internalOrders";

  @override
  _InternalOrdersState createState() => _InternalOrdersState();
}

class _InternalOrdersState extends State<InternalOrders>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  bool _isLoading = false;
  bool _isInit = true;
  int len = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<CatesTablesFoodmenu>(context, listen: false)
          .fetchCatesAndTables()
          .then((_) {
        setState(() {
          _isLoading = false;
          len = Provider.of<CatesTablesFoodmenu>(context, listen: false)
              .cates
              .length;
          tabController = TabController(vsync: this, length: len);
        });
      });
    }
    _isInit = false;
  }

  ScrollController sc = new ScrollController();
  @override
  Widget build(BuildContext context) {
    final String appBarTitleKey = widget.isInternal ? "داخلی" : "بیرونی";
    Size size = MediaQuery.of(context).size;
    var provider = Provider.of<CatesTablesFoodmenu>(context);
    List<Tab> tabsList = provider.cates
        .map((item) => Tab(
            child: Text(item.name,
                style: PersianFonts.Shabnam.copyWith(
                  color: Colors.blue,
                  fontSize: 16,
                ))))
        .toList();
    List<TabBarViewItem> tbvItems = provider.cates
        .map((item) => TabBarViewItem(
            cateId: item.categoryId.toString(), cateName: item.name))
        .toList();

    return DefaultTabController(
      length: provider.cates.length,
      child: WillPopScope(
        onWillPop: () => showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("هشدار!"),
            content:
                Text("آیا مطمئن هستید که می خواهید از این صفحه خارج شوید؟"),
            actions: [
              TextButton(
                  child: Text("خیر"),
                  onPressed: () => Navigator.of(context).pop(false)),
              TextButton(
                  child: Text("بله"),
                  onPressed: () => Navigator.of(context).pop(true)),
            ],
          ),
        ),
        child: Scaffold(
            backgroundColor: Color(0xfff5f6fa),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "ثبت سفارشات $appBarTitleKey",
                style: PersianFonts.Shabnam.copyWith(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            drawer: MainDrawer(),
            body: _isLoading
                ? Container(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: size.width * 0.03),
                        color: Color(0xfff5f6fa),
                        width: double.infinity,
                        child: TabBar(
                          controller: tabController,
                          indicatorColor: Colors.red,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorWeight: 4,
                          isScrollable: true,
                          labelColor: Colors.red,
                          unselectedLabelColor: Colors.blue,
                          tabs: tabsList,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Scrollbar(
                              controller: sc,
                              showTrackOnHover: true,
                              isAlwaysShown: true,
                              child: Column(children: [
                                SizedBox(height: size.height * 0.01),
                                Container(
                                    child: Column(
                                  children: [
                                    SizedBox(height: size.height * 0.02),
                                    Container(
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: size.width * 0.03,
                                                vertical: size.height * 0.01),
                                            decoration: BoxDecoration(
                                              border: Border.symmetric(
                                                  horizontal: BorderSide(
                                                color: Colors.black26,
                                              )),
                                              color: const Color(0xfff3f3f3),
                                            ),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 0),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                40,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right:
                                                            size.width * 0.05),
                                                    child:
                                                        const TabBarListHeader(
                                                            "نام"),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const TabBarListHeader(
                                                          "قیمت"),
                                                      SizedBox(
                                                          width: size.width *
                                                              0.09),
                                                      const TabBarListHeader(
                                                          "تعداد"),
                                                      SizedBox(
                                                          width: size.width *
                                                              0.08),
                                                      const TabBarListHeader(
                                                          "پروسس"),
                                                    ],
                                                  ),
                                                ]),
                                          ),
                                          const SizedBox(height: 5),
                                          Container(
                                            height: size.height * 0.4,
                                            width: double.infinity,
                                            child: TabBarView(
                                                controller: tabController,
                                                children: tbvItems),
                                          ),
                                        ])),
                                    SizedBox(height: size.height * 0.02),
                                    CardOrder(widget.isInternal),
                                    SizedBox(height: size.height * 0.04),
                                  ],
                                )),
                              ]),
                            )),
                      ),
                    ],
                  )),
      ),
    );
  }
}

class TabBarListHeader extends StatelessWidget {
  final String text;
  const TabBarListHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }
}
