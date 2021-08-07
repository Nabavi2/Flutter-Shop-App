import 'package:Attendece/screen/ipAddress_screen.dart';
import 'package:flutter/material.dart';
import '../screen/InternalOrders.dart';
import '../screen/loginPage.dart';

class MainDrawer extends StatefulWidget {
  static const routeName = "/drawer";
  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/image/restaurant2.jpg",
                  ),
                  fit: BoxFit.cover),
            ),
            height: 240,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 49, bottom: 10),
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.save_alt_outlined, color: Colors.blue),
            title: const Text('ثبت سفارشات داخلی'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => InternalOrders(true)),
              );
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.add_shopping_cart_rounded, color: Colors.blue),
            title: const Text('ثبت سفارشات بیرونی'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => InternalOrders(false)),
              );
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.add_to_home_screen_sharp, color: Colors.blue),
            title: const Text('ثبت آی پی آدرس'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => IpAddressScreen("reset")));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.blue),
            title: const Text('خروج'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: const Text(
                          "هشدار !",
                          style: TextStyle(color: Colors.red, fontSize: 25),
                        ),
                        content: const Text(
                            'آیامطمئین هستید که میخواهید خارج شوید؟'),
                        actions: [
                          TextButton(
                            child: const Text('بلی'),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            onLongPress: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('خیر'),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (ctx) => InternalOrders(true)),
                              );
                            },
                          )
                        ],
                      ));
            },
          ),
        ],
      ),
    ));
  }
}
