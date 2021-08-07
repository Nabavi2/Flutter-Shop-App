import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  startTime() {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  navigationPage() {
    Navigator.of(context).pushNamed('/');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return new Scaffold(
        backgroundColor: Colors.white,
        body: new Stack(
          fit: StackFit.expand,
          children: [
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Container(
                  width: size.width * 0.250,
                  height: size.height * 0.250,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("assets/image/icon2.jpg"),
                    ),
                  ),
                ),
                const Text(
                  "رستورانت گیلاتو",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.05),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: size.width * 0.43,
                  width: size.width * 0.8,
                  child: Column(
                    children: [
                      new CircularProgressIndicator(),
                      SizedBox(height: size.width * 0.1),
                      const ProducerText("شرکت تکنالوژی طوطیا"),
                      SizedBox(height: 10),
                      const ProducerText("Tutia Tech ICT Company"),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class ProducerText extends StatelessWidget {
  final String text;
  const ProducerText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),
    );
  }
}
