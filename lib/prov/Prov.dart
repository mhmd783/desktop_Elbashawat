import 'dart:convert';
import 'dart:typed_data';

import 'package:elbshwat/dbhive/db.dart';
import 'package:elbshwat/prov/menudata.dart';
import 'package:elbshwat/server/server.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';

class control extends ChangeNotifier {
  Menu menuOpject = new Menu();
  int typen = 0;
  List newMenu = [];
  late Box myUsers = Hive.box<Users>("users");
  late Box myOrders = Hive.box<Orders>("orders");
  late Box myAllOrders = Hive.box<AllOrders>("allorders");
  late Box myorderreceve = Hive.box("orderreceve");
  int screennumber = 1;
  screen1(int i) {
    screennumber = i;
    notifyListeners();
  }

  screen2(int i) {
    screennumber = i;
    notifyListeners();
  }

  screen3(int i) {
    screennumber = i;
    notifyListeners();
  }

  screen4(int i) {
    screennumber = i;
    notifyListeners();
  }

  List type = [
    "كوفي",
    "فريشات",
    "ركن السوري",
    "وافل",
    "ديزرت",
    "شيشه",
    "مشروبات ساخنه",
    "سموزي",
    "تلاجه",
    "مشروبات ايس",
    "فروت",
    "سوبر كريب",
    "كريب فراخ",
    "كريب لحوم",
    "كريب جبن",
    "اضافات"
  ];

  refesh() {
    changetype(typen);
    notifyListeners();
  }

  changetype(int i) {
    typen = i;
    newMenu.clear();
    for (int i = 0; i < menuOpject.menu.length; i++) {
      if (menuOpject.menu[i]['type'] == type[typen]) {
        newMenu.add(menuOpject.menu[i]);
      }
    }
    notifyListeners();
  }

  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController title = new TextEditingController();
  adduser() {
    myUsers.put("${phone.text}",Users(
        name: name.text,
        phone: phone.text,
        title: title.text,
        send: "0",
        date: Jiffy.now().format(pattern: 'yyyy/MM/dd').toString(),
        time: Jiffy.parse('${DateTime.now()}').Hm.toString()));

    notifyListeners();
  }

  List users = [];
  getUsers() {
    users = [];
    for (int i = 0; i < myUsers.length; i++) {
      users.add(myUsers.getAt(myUsers.length - i - 1));
    }
    notifyListeners();
  }

//////////////////////////////////////////////////////////////////////////////////////
  //orders///////////////////////////////////////////////
  int numberOrder = 1;
  List orderschose = [];
  int totalPrice = 0;
  increaseorder() {
    numberOrder = numberOrder + 1;
    notifyListeners();
  }

  decreaseorder() {
    if (numberOrder > 1) {
      numberOrder = numberOrder - 1;
    }
    notifyListeners();
  }

  choseorder(int i) {
    totalPrice = totalPrice + (int.parse(newMenu[i]['price']) * numberOrder);
    orderschose.add({
      "drinks": newMenu[i]['drinks'],
      "price": '${(int.parse(newMenu[i]['price']) * numberOrder).toString()}',
      "old_price": newMenu[i]['price'],
      "image": newMenu[i]['image'],
      "numberOrder": numberOrder.toString(),
      "numberTable": "26",
    });
    numberOrder = 1;
    notifyListeners();
  }

  editnumbeorder(int i) {
    numberOrder = int.parse(orderschose[i]['numberOrder']);
    notifyListeners();
  }

  editchoseorder(int i) {
    orderschose[i]['numberOrder'] = numberOrder.toString();
    orderschose[i]['price'] =
        (int.parse(orderschose[i]['old_price']) * numberOrder).toString();
    totalPrice = 0;
    for (int y = 0; y < orderschose.length; y++) {
      totalPrice = totalPrice + int.parse(orderschose[y]['price']);
    }
    numberOrder = 1;
    notifyListeners();
  }

  deletchoseorder(int i) {
    orderschose.removeAt(i);
    totalPrice = 0;

    for (int y = 0; y < orderschose.length; y++) {
      totalPrice = totalPrice + int.parse(orderschose[y]['price']);
    }
    notifyListeners();
  }

  int numberTable = 26;
  choseTable(int i) {
    //i start 0 to  stor i in hive you shoud add 1 to i to start 1 to 25
    numberTable = i;
    for (int y = 0; y < orderschose.length; y++) {
      orderschose[y]['numberTable'] = (numberTable + 1).toString();
    }
    notifyListeners();
  }

  addorderstodb() {
    for (int i = 0; i < orderschose.length; i++) {
      myOrders.add(Orders(
          id: myOrders.length.toString(),
          name: '',
          phone: '',
          title: '',
          table_number: orderschose[i]['numberTable'],
          drinks: orderschose[i]['drinks'],
          price: orderschose[i]['price'],
          image: orderschose[i]['image'],
          old_price: orderschose[i]['old_price'],
          number_order: orderschose[i]['numberOrder'],
          pay: '0',
          send: '',
          date: Jiffy.now().format(pattern: 'yyyy/MM/dd').toString(),
          time: Jiffy.parse('${DateTime.now()}').Hm.toString()));

      // myAllOrders.add(AllOrders(
      //     id: myOrders.length.toString(),
      //     name: '',
      //     phone: '',
      //     title: '',
      //     table_number: orderschose[i]['numberTable'],
      //     drinks: orderschose[i]['drinks'],
      //     price: orderschose[i]['price'],
      //     image: orderschose[i]['image'],
      //     old_price: orderschose[i]['old_price'],
      //     number_order: orderschose[i]['numberOrder'],
      //     pay: '0',
      //     send: '',
      //     date: Jiffy.now().format(pattern: 'yyyy/MM/dd').toString(),
      //     time: Jiffy.parse('${DateTime.now()}').Hm.toString()));
    }
    myorderreceve.put("orderreceve","${myOrders.length}");
    orderschose = [];
    totalPrice = 0;
    numberTable = 26;
    notifyListeners();
  }

  ///show orders in screen orders //////////////////////
  int table = 26;
  choseTableOrder(int i) {
    table = i;
    ordersTable();
    notifyListeners();
  }

  cleartable() {
    table = 26;
    notifyListeners();
  }

  List showOrders = [];
  int totalpricetable = 0;
  ordersTable() {
    showOrders = [];
    totalpricetable = 0;
    for (int i = 0; i < myOrders.length; i++) {
      if (myOrders.getAt(i).table_number == (table + 1).toString() &&
          myOrders.getAt(i).pay == '0') {
        showOrders.add(myOrders.getAt(i));
        totalpricetable = totalpricetable + int.parse(myOrders.getAt(i).price);
      }
    }
    notifyListeners();
  }

  /////
  deletorderinorder(int y) async {
    int i = 0;
    while (i < myOrders.length) {
      if (myOrders.getAt(i).id == showOrders[y].id) {
        await myOrders.deleteAt(i);
        ordersTable();
      }
      i++;
    }
    notifyListeners();
  }

  endOrderTable() async {
    for (int y = 0; y < showOrders.length; y++) {
      myAllOrders.add(AllOrders(
          id: myOrders.length.toString(),
          name: '',
          phone: '',
          title: '',
          table_number: showOrders[y].table_number,
          drinks: showOrders[y].drinks,
          price: showOrders[y].price,
          image: showOrders[y].image,
          old_price: showOrders[y].old_price,
          number_order: showOrders[y].number_order,
          pay: '0',
          send: '',
          date: Jiffy.now().format(pattern: 'yyyy/MM/dd').toString(),
          time: Jiffy.parse('${DateTime.now()}').Hm.toString()));
    }
    int i = 0;

    while (i < myOrders.length) {
      if (myOrders.getAt(i).table_number == (table + 1).toString()) {
        await myOrders.deleteAt(i);
        i = i - 1;
      }
      i++;
    }
    myorderreceve.put("orderreceve","${myOrders.length}");
    ordersTable();

    notifyListeners();
  }

/////////////////////////////////////////////////////////////////////////////////////
  //AllOrders///////////////////////////////////
  int totalpriceallorders = 0;
  List allorders = [];
  String sdate = Jiffy.now().format(pattern: 'yyyy/MM/dd');
  String edate = Jiffy.now().format(pattern: 'yyyy/MM/dd');
  List ordersbydate_s_e = [];
  searchbydate_s(String sdat) {
    sdate = sdat;
    notifyListeners();
  }

  searchbydate_e(String edat) {
    edate = edat;
    notifyListeners();
  }

  int t1 = 0,
      t2 = 0,
      t3 = 0,
      t4 = 0,
      t5 = 0,
      t6 = 0,
      t7 = 0,
      t8 = 0,
      t9 = 0,
      t10 = 0,
      t11 = 0,
      t12 = 0,
      t13 = 0,
      t14 = 0,
      t15 = 0,
      t16 = 0,
      t17 = 0,
      t18 = 0,
      t19 = 0,
      t20 = 0,
      t21 = 0,
      t22 = 0,
      t23 = 0,
      t24 = 0,
      t25 = 0,
      t26 =0;
  int o1 = 0,
      o2 = 0,
      o3 = 0,
      o4 = 0,
      o5 = 0,
      o6 = 0,
      o7 = 0,
      o8 = 0,
      o9 = 0,
      o10 = 0,
      o11 = 0,
      o12 = 0,
      o13 = 0,
      o14 = 0,
      o15 = 0,
      o16 = 0,
      o17 = 0,
      o18 = 0,
      o19 = 0,
      o20 = 0,
      o21 = 0,
      o22 = 0,
      o23 = 0,
      o24 = 0,
      o25 = 0,
      o26 = 0;
  calculatorders() {
    t1 = 0;
    t2 = 0;
    t3 = 0;
    t4 = 0;
    t5 = 0;
    t6 = 0;
    t7 = 0;
    t8 = 0;
    t9 = 0;
    t10 = 0;
    t11 = 0;
    t12 = 0;
    t13 = 0;
    t14 = 0;
    t15 = 0;
    t16 = 0;
    t17 = 0;
    t18 = 0;
    t19 = 0;
    t20 = 0;
    t21 = 0;
    t22 = 0;
    t23 = 0;
    t24 = 0;
    t25 = 0;
    t26 = 0;
    o1 = 0;
    o2 = 0;
    o3 = 0;
    o4 = 0;
    o5 = 0;
    o6 = 0;
    o7 = 0;
    o8 = 0;
    o9 = 0;
    o10 = 0;
    o11 = 0;
    o12 = 0;
    o13 = 0;
    o14 = 0;
    o15 = 0;
    o16 = 0;
    o17 = 0;
    o18 = 0;
    o19 = 0;
    o20 = 0;
    o21 = 0;
    o22 = 0;
    o23 = 0;
    o24 = 0;
    o25 = 0;
    o26= 0;
    allorders = [];
    ordersbydate_s_e = [];
    totalpriceallorders = 0;
    for (int i = 0; i < myAllOrders.length; i++) {
      if (Jiffy.parse(myAllOrders.getAt(i).date)
              .isBetween(Jiffy.parse(sdate), Jiffy.parse(edate)) ||
          Jiffy.parse(myAllOrders.getAt(i).date).isSame(Jiffy.parse(sdate)) ||
          Jiffy.parse(myAllOrders.getAt(i).date).isSame(Jiffy.parse(edate))) {
        ///
        totalpriceallorders =
            totalpriceallorders + int.parse(myAllOrders.getAt(i).price);

        ///
        ordersbydate_s_e.add(myAllOrders.getAt(i));
        //make list to show
        if (int.parse(myAllOrders.getAt(i).table_number) == 1) {
          t1 = t1 + int.parse(myAllOrders.getAt(i).price);
          o1++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 2) {
          t2 = t2 + int.parse(myAllOrders.getAt(i).price);
          o2++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 3) {
          t3 = t3 + int.parse(myAllOrders.getAt(i).price);
          o3++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 4) {
          t4 = t4 + int.parse(myAllOrders.getAt(i).price);
          o4++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 5) {
          t5 = t5 + int.parse(myAllOrders.getAt(i).price);
          o5++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 6) {
          t6 = t6 + int.parse(myAllOrders.getAt(i).price);
          o6++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 7) {
          t7 = t7 + int.parse(myAllOrders.getAt(i).price);
          o7++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 8) {
          t8 = t8 + int.parse(myAllOrders.getAt(i).price);
          o8++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 9) {
          t9 = t9 + int.parse(myAllOrders.getAt(i).price);
          o9++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 10) {
          t10 = t10 + int.parse(myAllOrders.getAt(i).price);
          o10++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 11) {
          t11 = t1 + int.parse(myAllOrders.getAt(i).price);
          o11++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 12) {
          t12 = t12 + int.parse(myAllOrders.getAt(i).price);
          o12++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 13) {
          t13 = t13 + int.parse(myAllOrders.getAt(i).price);
          o13++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 14) {
          t14 = t14 + int.parse(myAllOrders.getAt(i).price);
          o14++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 15) {
          t15 = t15 + int.parse(myAllOrders.getAt(i).price);
          o15++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 16) {
          t16 = t16 + int.parse(myAllOrders.getAt(i).price);
          o15++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 17) {
          t17 = t17 + int.parse(myAllOrders.getAt(i).price);
          o17++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 18) {
          t18 = t18 + int.parse(myAllOrders.getAt(i).price);
          o18++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 19) {
          t19 = t19 + int.parse(myAllOrders.getAt(i).price);
          o19++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 20) {
          t20 = t20 + int.parse(myAllOrders.getAt(i).price);
          o20++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 21) {
          t21 = t21 + int.parse(myAllOrders.getAt(i).price);
          o21++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 22) {
          t22 = t22 + int.parse(myAllOrders.getAt(i).price);
          o22++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 23) {
          t23 = t23 + int.parse(myAllOrders.getAt(i).price);
          o23++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 24) {
          t24 = t24 + int.parse(myAllOrders.getAt(i).price);
          o24++;
        } else if (int.parse(myAllOrders.getAt(i).table_number) == 25) {
          t25 = t25 + int.parse(myAllOrders.getAt(i).price);
          o25++;
        }else if (int.parse(myAllOrders.getAt(i).table_number) == 26) {
          t26 = t26 + int.parse(myAllOrders.getAt(i).price);
          o26++;
        }
      }
    }
    allorders.add({"price": t1, "order": o1});
    allorders.add({"price": t2, "order": o2});
    allorders.add({"price": t3, "order": o3});
    allorders.add({"price": t4, "order": o4});
    allorders.add({"price": t5, "order": o5});
    allorders.add({"price": t6, "order": o6});
    allorders.add({"price": t7, "order": o7});
    allorders.add({"price": t8, "order": o8});
    allorders.add({"price": t9, "order": o9});
    allorders.add({"price": t10, "order": o10});
    allorders.add({"price": t11, "order": o11});
    allorders.add({"price": t12, "order": o12});
    allorders.add({"price": t13, "order": o13});
    allorders.add({"price": t14, "order": o14});
    allorders.add({"price": t15, "order": o15});
    allorders.add({"price": t16, "order": o16});
    allorders.add({"price": t17, "order": o17});
    allorders.add({"price": t18, "order": o18});
    allorders.add({"price": t19, "order": o19});
    allorders.add({"price": t20, "order": o20});
    allorders.add({"price": t21, "order": o21});
    allorders.add({"price": t22, "order": o22});
    allorders.add({"price": t23, "order": o23});
    allorders.add({"price": t24, "order": o24});
    allorders.add({"price": t25, "order": o25});
    allorders.add({"price": t26, "order": o26});

    print(totalpriceallorders);

    // for (int i = 0; i < myAllOrders.length; i++) {

    //   if (myAllOrders.getAt(i).table_number == 1) {
    //     allorders.add({
    //       ''
    //     });
    //   }
    // }

    notifyListeners();
  }

  List showorderstable = [];
  showordertable(int table) {
    showorderstable = [];
    for (int i = 0; i < ordersbydate_s_e.length; i++) {
      if (ordersbydate_s_e[i].table_number == table.toString()) {
        showorderstable.add(ordersbydate_s_e[i]);
      }
    }
    notifyListeners();
  }

  ///code server ///////////////////////////////////////////
  //mange server ///////////////////////////////////////////////////////

  //late Box mypatient = Hive.box<patient>("patient");
  TextEditingController messageController = TextEditingController();
  late Server server = Server(onData, onError);
  List<String> serverLogs = [];
  bool check = false;

  // @override
  void start() {
    server = Server(onData, onError);
    startOrStopServer();

    // super.onInit();
  }

  Future<void> startOrStopServer() async {
    if (server.running) {
      server.close();
      serverLogs.clear();
    } else {
      await server.start();
    }
    notifyListeners();
  }

  void onData(Uint8List data) async {
    serverLogs.clear();
    final receviedData = await String.fromCharCodes(data);
    serverLogs.add(receviedData);
    if (serverLogs[0] == 's') {
      serverLogs.clear();
    }
    await addpatientrecive();
    //update = true;

    notifyListeners();
  }

  void onError(dynamic error) {
    debugPrint("Error $error");
  }

  ///send date repeat and surgery

  //add to data recive to hive patient and payment
  addpatientrecive() async {
    //for (int i = 0; i < serverLogs.length; i += 1) {
    if (serverLogs.length > 0) {
      final decodedBytes = await base64.decode(serverLogs[0]);
      final decodedString = await utf8.decode(decodedBytes);
      Map data = await jsonDecode(decodedString);
      myUsers.put("${data['phone']}",Users(
          name: data['name'],
          phone: data['phone'],
          title: data['title'],
          send: "0",
          date: Jiffy.now().format(pattern: 'yyyy/MM/dd').toString(),
          time: Jiffy.parse('${DateTime.now()}').Hm.toString()));
      myOrders.add(Orders(
          id: myOrders.length.toString(),
          name: '',
          phone: '',
          title: '',
          table_number: data['table_number'],
          drinks: data['drinks'],
          price: data['price'],
          image: data['image'],
          old_price: data['old_price'],
          number_order: data['number_order'],
          pay: '0',
          send: '',
          date: Jiffy.now().format(pattern: 'yyyy/MM/dd').toString(),
          time: Jiffy.parse('${DateTime.now()}').Hm.toString()));
      print("ok0");
      serverLogs.clear();
    }
    //}

    serverLogs = [];

    notifyListeners();
  }

  /////////////////////////////////////////////////endserver
  ///
  //clearorderrecevenotification
  clearorderrecevenotification() {
    myorderreceve.put("orderreceve","${myOrders.length}");
    notifyListeners();
  }
}
