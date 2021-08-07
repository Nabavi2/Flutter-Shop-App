import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './loginPage.dart';
import 'package:provider/provider.dart';
import '../provider/shared_prefrences.dart';
import 'InternalOrders.dart';

class IpAddressScreen extends StatefulWidget {
  final String state;
  IpAddressScreen(this.state);
  @override
  _IpAddressScreenState createState() => _IpAddressScreenState();
}

class _IpAddressScreenState extends State<IpAddressScreen> {
  final form = GlobalKey<FormState>();
  TextEditingController tec = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tec.dispose();
  }

  void _saveForm() {
    final isValid = form.currentState.validate();
    if (!isValid) {
      return;
    }
    form.currentState.save();
    final ip = tec.text;
    Provider.of<SharedPrefrences>(context, listen: false).setData(ip);
    Navigator.of(context).pushNamed(LoginPage.routName);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/image/th.png"), fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("ثبت آی پی",
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                      const Text("لطفاً آی پی سرور خود را وارد کنید.",
                          style:
                              TextStyle(fontSize: 21, color: Colors.black87)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: size.height * 0.7,
                      width: size.width * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Form(
                        key: form,
                        child: Column(
                          children: [
                            Center(
                              child: Row(
                                children: [
                                  const Text(" آی پی:",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black87)),
                                  SizedBox(width: size.width * 0.012),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.blue),
                                    ),
                                    width: size.width * 0.65,
                                    height: size.height * 0.06,
                                    child: TextFormField(
                                      controller: tec,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            right: size.width * 0.12),
                                      ),
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return "لطفاً آی پی  را وارد کنید!";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.width * 0.05),
                            Padding(
                              padding:
                                  EdgeInsets.only(right: size.width * 0.012),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    buildElevatedButton(
                                        context: context,
                                        name: "انصراف",
                                        color: Colors.black26,
                                        func: () {
                                          if (widget.state == "setIp") {
                                            SystemNavigator.pop();
                                          } else if (widget.state ==
                                              "logReset") {
                                            Navigator.of(context).pop();
                                          } else {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    InternalOrders.routeName);
                                          }
                                        }),
                                    buildElevatedButton(
                                        context: context,
                                        name: "تأیید",
                                        color: Colors.blue,
                                        func: () {
                                          _saveForm();
                                        }),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton(
      {@required BuildContext context,
      @required String name,
      @required Color color,
      @required Function func}) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
        child: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
              horizontal: size.width * 0.12, vertical: size.height * 0.013)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(color),
        ),
        onPressed: func);
  }
}
