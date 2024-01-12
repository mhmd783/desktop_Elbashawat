import 'package:elbshwat/dbhive/db.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Delet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Delet();
  }
}

class _Delet extends State<Delet> {
  late Box myUsers = Hive.box<Users>("users");
  late Box myOrders = Hive.box<Orders>("orders");
  late Box myAllOrders = Hive.box<AllOrders>("allorders");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: IconButton(
            onPressed: () {
              myAllOrders.deleteFromDisk();
              myOrders.deleteFromDisk();
              myUsers.deleteFromDisk();
            },
            icon: Icon(Icons.delete)),
      )),
    );
  }
}
