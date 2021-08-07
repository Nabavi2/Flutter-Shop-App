import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../provider/Auth.dart';
import 'internalOrders.dart';
import './ipAddress_screen.dart';
import 'package:persian_fonts/persian_fonts.dart';

class LoginPage extends StatefulWidget {
  static const routName = "/loginPage";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _isLoading = false;
  final _form1 = GlobalKey<FormState>();

  bool _isVisiblePass;

  @override
  void initState() {
    super.initState();
    _isVisiblePass = true;
  }

  TextEditingController _userName = TextEditingController();

  TextEditingController _password = TextEditingController();

  Future<void> _saveform() async {
    String em = _userName.text;
    String pasw = _password.text;
    final isValidate = _form1.currentState.validate();
    if (!isValidate) {
      return;
    }
    _form1.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      final isCorrect = await Provider.of<Auth>(context, listen: false)
          .login(em, pasw)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        return value;
      });

      if (isCorrect) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => InternalOrders(true)));
      } else {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text(
                    "خطا در ورود!",
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  ),
                  content: const Text(
                      "چنین ایمیل یا رمز عبوری در سیستم موجود نیست!\nلطفاً ایمیل و رمز عبور درست را وارد کنید!"),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'تائید',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  ],
                )).then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      }
    } catch (error) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text(
                  "خطا در اتصال!",
                  style: TextStyle(color: Colors.red, fontSize: 25),
                ),
                content: const Text(
                    "اتصال به سرور ممکن نیست!\nاین خطا می تواند در اثر وارد کردن آی پی اشتباه و یا خاموش بودن سرور به وجود بیاید."),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'تائید',
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                ],
              )).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("هشدار!"),
          content: Text("آیا مطمئن هستید که می خواهید از برنامه خارج شوید؟"),
          actions: [
            TextButton(
                child: Text("خیر"),
                onPressed: () => Navigator.of(context).pop(false)),
            TextButton(
                child: Text("بله"),
                onPressed: () => SystemNavigator.pop(animated: true)),
          ],
        ),
      ),
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/image/tutia2.jpg"),
            fit: BoxFit.cover,
          )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                flex: 3,
                child: Container(
                    padding: EdgeInsets.only(top: size.height * 0.15),
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.25),
                                  child: const Text("خوش آمدید!",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center),
                                ),
                                const Text("ورود به سیستم",
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ))
                              ],
                            ))
                      ],
                    )),
              ),
              SizedBox(height: size.height * 0.06),
              Flexible(
                fit: FlexFit.loose,
                flex: 5,
                child: Container(
                  color: Colors.white,
                  child: Form(
                    key: _form1,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : SingleChildScrollView(
                              physics: ScrollPhysics(),
                              child: Column(
                                children: [
                                  SizedBox(height: size.height * 0.05),
                                  TextFormField(
                                    controller: _userName,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                        Radius.circular(18),
                                      )),
                                      contentPadding: EdgeInsets.only(
                                          right: size.width * 0.025),
                                      labelText: "ایمیل",
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18))),
                                    ),
                                    validator: (val) {
                                      if (val == null) {
                                        return "لطفاً ایمیل خود را وارد کنید!";
                                      } else if (!(val.contains("@") &&
                                          val.contains(".com"))) {
                                        return "ایمیل شما باید @ و .com باید داشته باشد!";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  SizedBox(height: size.height * 0.04),
                                  TextFormField(
                                    controller: _password,
                                    keyboardType: TextInputType.text,
                                    obscureText: _isVisiblePass,
                                    decoration: InputDecoration(
                                      labelText: "رمز عبور",
                                      contentPadding: EdgeInsets.only(
                                          right: size.width * 0.04),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(18))),
                                      suffixIcon: IconButton(
                                          icon: _isVisiblePass
                                              ? const Icon(Icons.visibility)
                                              : const Icon(
                                                  Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              _isVisiblePass = !_isVisiblePass;
                                            });
                                          }),
                                    ),
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "لطفاً رمز عبور خود را وارد کنید!";
                                      } else if (val.length < 4) {
                                        return "رمز شما باید از ۶ حرف بیشتر باشد!";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: size.width * 0.4),
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                            textStyle: TextStyle(
                                                color: Colors.black26)),
                                        child: Text(
                                          "ثبت آی پی",
                                          style: PersianFonts.Shabnam.copyWith(
                                              fontSize: 18),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      IpAddressScreen(
                                                          "logReset")));
                                        }),
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  Container(
                                    height: size.height * 0.06,
                                    width: size.width * 0.70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: ElevatedButton(
                                      child: const Text("ورود",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          )),
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: const BorderRadius.all(
                                                      Radius.circular(30)))),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xff0106fe)),
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.symmetric(
                                                  horizontal: size.width * 0.18,
                                                  vertical:
                                                      size.height * 0.01))),
                                      onPressed: _saveform,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
