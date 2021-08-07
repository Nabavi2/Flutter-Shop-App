import 'package:flutter/material.dart';
import 'screen/InternalOrders.dart';
import './provider/ordersList.dart';
import './provider/catesTablesFoodmenu.dart';
import './provider/categoryItems.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './screen/splash_screen.dart';
import './provider/Auth.dart';
import 'package:persian_fonts/persian_fonts.dart';
import './screen/ipAddress_screen.dart';
import 'screen/loginPage.dart';
import './provider/shared_prefrences.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (ctx) => SharedPrefrences(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isInit = true;
  bool _isIp = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      _isIp =
          await Provider.of<SharedPrefrences>(context).hasData().then((value) {
        return value;
      });
    }
    _isInit = false;
  }

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (ctx) => OrdersList(), child: InternalOrders(true)),
        ChangeNotifierProvider(
            create: (ctx) => CatesTablesFoodmenu(),
            child: InternalOrders(true)),
        ChangeNotifierProvider(
          create: (ctx) => CategoryItems(),
          child: InternalOrders(true),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
          child: LoginPage(),
        ),
      ],
      child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: [Locale("fa", "IR")],
          locale: Locale("fa", "IR"),
          debugShowCheckedModeBanner: false,
          title: 'Attendece',
          theme: ThemeData(
            textTheme: PersianFonts.shabnamTextTheme,
            primaryColor: Colors.blue,
            appBarTheme: AppBarTheme(color: Colors.blue),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: "/splash_screen",
          routes: {
            "/": (ctx) => _isIp ? LoginPage() : IpAddressScreen("setIp"),
            "/splash_screen": (context) => SplashScreen(),
            LoginPage.routName: (ctx) => LoginPage(),
            InternalOrders.routeName: (ctx) => InternalOrders(true),
          }),
    );
  }
}
