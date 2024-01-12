import 'package:elbshwat/dbhive/db.dart';
import 'package:elbshwat/prov/Prov.dart';
import 'package:elbshwat/view/allOrders.dart';
import 'package:elbshwat/view/menu1.dart';
import 'package:elbshwat/view/orders.dart';
import 'package:elbshwat/view/signup.dart';
import 'package:elbshwat/view/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(UsersAdapter());
  Hive.registerAdapter(OrdersAdapter());
  Hive.registerAdapter(AllOrdersAdapter());

  await Hive.openBox<Users>('users');
  await Hive.openBox<Orders>('orders');
  await Hive.openBox<AllOrders>('allorders');
  await Hive.openBox("orderreceve");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return control();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "signup": (context) => Signup(),
          "menu1": (context) => Menu1(),
          "orders": (context) => OrdersScreen(),
          "users": (context) => UsersScreen(),
          "allOrders": (context) => AllOrdersScreen(),
        },
        home: Signup(),
      ),
    );
  }
}
