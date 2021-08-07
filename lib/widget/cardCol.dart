import 'package:flutter/material.dart';

class CardCol extends StatefulWidget {
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController payment;
  final TextEditingController disCount;
  final TextEditingController transportFee;
  final TextEditingController address;
  CardCol({
    @required this.name,
    @required this.phone,
    @required this.payment,
    @required this.disCount,
    @required this.transportFee,
    @required this.address,
  });
  @override
  _CardColState createState() => _CardColState();
}

class _CardColState extends State<CardCol> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("مشخصات مشتری:",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "نام",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        TextFormField(
          controller: widget.name,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
            contentPadding: EdgeInsets.only(right: size.width * 0.025),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "لطفاً! نام شخص را وارد کنید";
            } else {
              return null;
            }
          },
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "شمارۀ تماس",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        TextFormField(
          controller: widget.phone,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
            contentPadding: EdgeInsets.only(right: size.width * 0.025),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "لطفاً! شماره تماس را وارد کنید";
            } else {
              return null;
            }
          },
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "مقدار پرداخت",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        TextFormField(
          controller: widget.payment,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
            contentPadding: EdgeInsets.only(right: size.width * 0.025),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "لطفاً مقدار پرداخت را وارد کنید";
            } else {
              return null;
            }
          },
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "تخفیف",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        TextFormField(
          controller: widget.disCount,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
            contentPadding: EdgeInsets.only(right: size.width * 0.025),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "فیس ترانسپورت",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        TextFormField(
          controller: widget.transportFee,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
            contentPadding: EdgeInsets.only(right: size.width * 0.025),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "آدرس",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        TextFormField(
          controller: widget.address,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(10),
            )),
            contentPadding: EdgeInsets.only(right: size.width * 0.025),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
        SizedBox(
          height: size.height * 0.04,
        )
      ],
    );
  }
}
