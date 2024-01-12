import 'package:elbshwat/prov/Prov.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Signup();
  }
}

class _Signup extends State<Signup> {
  double heigh = 310;
  late Box myorderreceve = Hive.box("orderreceve");
  @override
  void setState(VoidCallback fn) {
    if (myorderreceve.get('orderreceve') == null) {
      myorderreceve.put("orderreceve", "0");
    }
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: 350,
          width: double.infinity,
          child: Image.asset(
            'images/coffee1.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Consumer<control>(builder: (context, val, child) {
          return Container(
            margin: EdgeInsets.only(top: heigh),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45))),
            child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "اهلا في البشوات",
                  style: TextStyle(color: Colors.brown, fontSize: 30),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: val.name,
                    onTap: () {
                      setState(() {
                        heigh = 100;
                      });
                    },
                    onTapOutside: (ev) {
                      setState(() {
                        heigh = 310;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(
                            "[a-zA-Z0-9\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFBC1\uFBD3-\uFD3D\uFD50-\uFD8F\uFD92-\uFDC7\uFDF0-\uFDFD\uFE70-\uFE74\uFE76-\uFEFC ]"),
                      ),
                    ],
                    maxLength: 15,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.brown,
                      ),
                      label: Text(
                        "اسمك",
                        style: TextStyle(color: Colors.brown, fontSize: 17),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: val.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    ],
                    maxLength: 11,
                    keyboardType: TextInputType.number,
                    onTap: () {
                      setState(() {
                        heigh = 100;
                      });
                    },
                    onTapOutside: (ev) {
                      setState(() {
                        heigh = 310;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.brown,
                      ),
                      label: Text(
                        "رقمك",
                        style: TextStyle(color: Colors.brown, fontSize: 17),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: val.title,
                    onTap: () {
                      setState(() {
                        heigh = 100;
                      });
                    },
                    onTapOutside: (ev) {
                      setState(() {
                        heigh = 310;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(
                            "[a-zA-Z0-9\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFBC1\uFBD3-\uFD3D\uFD50-\uFD8F\uFD92-\uFDC7\uFDF0-\uFDFD\uFE70-\uFE74\uFE76-\uFEFC ]"),
                      ),
                    ],
                    maxLength: 50,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.title,
                        color: Colors.brown,
                      ),
                      label: Text(
                        "عنوانك",
                        style: TextStyle(color: Colors.brown, fontSize: 17),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(vertical: 30),
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15.0, // soften the shadow
                        spreadRadius: 5.0, //extend the shadow
                        offset: Offset(
                          5.0, // Move to right 5  horizontally
                          5.0, // Move to bottom 5 Vertically
                        ),
                      )
                    ],
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if (val.name.text != '' &&
                          val.phone.text.length >= 11 &&
                          val.title.text != '') {
                        val.adduser();
                        Navigator.of(context).pushNamed("menu1");
                      } else {
                        errordate(context);
                      }
                    },
                    child: Text(
                      "تسجيل",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15.0, // soften the shadow
                        spreadRadius: 5.0, //extend the shadow
                        offset: Offset(
                          5.0, // Move to right 5  horizontally
                          5.0, // Move to bottom 5 Vertically
                        ),
                      )
                    ],
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("menu1");
                    },
                    child: Text(
                      "تخطي",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ]),
            ),
          );
        })
      ]),
    );
  }

  errordate(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          elevation: 20,
          content: Text(
            "!!! اكمل بياناتك ",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    });
  }
}
