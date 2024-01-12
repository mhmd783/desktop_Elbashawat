import 'package:elbshwat/modules/dialoge.dart';
import 'package:elbshwat/prov/Prov.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class AllOrdersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AllOrdersScreen();
  }
}

class _AllOrdersScreen extends State<AllOrdersScreen> {
  Dialoge dialoge = new Dialoge();
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).calculatorders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<control>(builder: (context, val, child) {
          return Text("${val.totalpriceallorders}\$");
        }),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                dialoge.dash(context);
              },
              icon: Icon(Icons.menu)),
          Consumer<control>(builder: (context, val, child) {
            return Switch(
                activeColor: Colors.green,
                inactiveThumbColor: Colors.black,
                value: val.server.running,
                onChanged: (value) async {
                  await val.startOrStopServer();
                });
          }),
        ],
      ),
      body: Consumer<control>(builder: (context, val, child) {
        return Container(
          child: val.allorders.length == 0
              ? Container()
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: val.allorders.length,
                  itemBuilder: (context, i) {
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.brown,
                          radius: 22,
                          child: i == 25
                              ? Icon(
                                  Icons.delivery_dining_outlined,
                                  color: Colors.white,
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.table_bar,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "${i + 1}",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        title: Text("${val.allorders[i]['price']}\$"),
                        subtitle: Text("${val.allorders[i]['order']} order..."),
                        trailing: TextButton(
                            onPressed: () {
                              val.showordertable(i + 1);
                              all_orders(
                                  i + 1, val.allorders[i]['price'].toString());
                            },
                            child: Text("اظهار الطلبات")),
                      ),
                    );
                  },
                ),
        );
      }),
      floatingActionButton: Consumer<control>(builder: (context, val, child) {
        return FloatingActionButton(
          backgroundColor: Colors.brown,
          onPressed: () {
            search();
          },
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
        );
      }),
    );
  }

  Future<void> search() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Consumer<control>(builder: (context, val, child) {
          return AlertDialog(
            scrollable: true,
            backgroundColor: Colors.white,
            title: Text("بحث"),
            elevation: 10,
            content: Container(
              child: Column(children: [
                Text("اختار تاريخ البدايه"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2050),
                          ).then((value) {
                            if (value != null) {
                              // val.sdate = Jiffy.parse("$value")
                              //     .format(pattern: 'yyyy/MM/dd');
                              val.searchbydate_s(Jiffy.parse("$value")
                                  .format(pattern: 'yyyy/MM/dd'));
                            }
                          });
                        },
                        icon: Icon(
                          Icons.date_range,
                          size: 35,
                        )),
                    Text(
                      "${val.sdate}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Text("اختار تاريخ النهايه"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2050),
                          ).then((value) {
                            if (value != null) {
                              // val.edate = Jiffy.parse("$value")
                              //     .format(pattern: 'yyyy/MM/dd');
                              val.searchbydate_e(Jiffy.parse("$value")
                                  .format(pattern: 'yyyy/MM/dd'));
                            }
                          });
                        },
                        icon: Icon(
                          Icons.date_range,
                          size: 35,
                        )),
                    Text(
                      "${val.edate}",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ]),
            ),
            actions: <Widget>[
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.brown,
                child: IconButton(
                    onPressed: () {
                      val.calculatorders();
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              )
            ],
          );
        });
      },
    );
  }

  Future<void> all_orders(int table, String mony) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.white,
          elevation: 10,
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.brown,
                radius: 22,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.table_bar,
                      color: Colors.white,
                    ),
                    Text(
                      "$table",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text("$mony\$"),
            ],
          ),
          content: Consumer<control>(builder: (context, val, child) {
            return Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 250,
              child: ListView.builder(
                  itemCount: val.showorderstable.length,
                  itemBuilder: (context, i) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text("${val.showorderstable[i].drinks}"),
                        subtitle: Text(
                          "${val.showorderstable[i].number_order}   ${val.showorderstable[i].price}\$",
                          style: TextStyle(fontSize: 10),
                        ),
                        leading: CircleAvatar(
                          //radius: 50,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage("${val.showorderstable[i].image}"),
                        ),
                        trailing: Text("${val.showorderstable[i].time}"),
                      ),
                    );
                  }),
            );
          }),
          actions: <Widget>[
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.brown,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            )
          ],
        );
      },
    );
  }
}
