import 'package:elbshwat/prov/Prov.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Dialoge {
  Future<void> dash(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.white,
          elevation: 10,
          title: Text(""),
          content: Consumer<control>(builder: (context, val, child) {
            return Container(
                width: 200,
                height: 280,
                child: Column(
                  children: [
                    Card(
                      color:
                          val.screennumber == 1 ? Colors.brown : Colors.white,
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          val.screen1(1);
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacementNamed("menu1");
                        },
                        title: Text(
                          "Menu",
                          style: TextStyle(
                              color: val.screennumber == 1
                                  ? Colors.white
                                  : Colors.brown),
                        ),
                        leading: CircleAvatar(
                          //radius: 50,
                          backgroundColor: val.screennumber == 1
                              ? Colors.white
                              : Colors.white,
                          child: Icon(
                            Icons.menu_book,
                            color: Colors.brown,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color:
                          val.screennumber == 2 ? Colors.brown : Colors.white,
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          val.screen2(2);
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacementNamed("orders");
                        },
                        title: Text(
                          "Orders",
                          style: TextStyle(
                              color: val.screennumber == 2
                                  ? Colors.white
                                  : Colors.brown),
                        ),
                        leading: CircleAvatar(
                          //radius: 50,
                          backgroundColor: val.screennumber == 2
                              ? Colors.white
                              : Colors.brown,
                          child: Icon(
                            Icons.shopping_cart,
                            color: val.screennumber == 2
                                ? Colors.brown
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color:
                          val.screennumber == 3 ? Colors.brown : Colors.white,
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          val.screen3(3);
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacementNamed("allOrders");
                        },
                        title: Text(
                          "All Orders",
                          style: TextStyle(
                              color: val.screennumber == 3
                                  ? Colors.white
                                  : Colors.brown),
                        ),
                        leading: CircleAvatar(
                          //radius: 50,
                          backgroundColor: val.screennumber == 3
                              ? Colors.white
                              : Colors.brown,
                          child: Icon(
                            Icons.shopping_cart,
                            color: val.screennumber == 3
                                ? Colors.brown
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color:
                          val.screennumber == 4 ? Colors.brown : Colors.white,
                      elevation: 5,
                      child: ListTile(
                        onTap: () {
                          val.screen4(4);
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacementNamed("users");
                        },
                        title: Text(
                          "Guestes",
                          style: TextStyle(
                              color: val.screennumber == 4
                                  ? Colors.white
                                  : Colors.brown),
                        ),
                        leading: CircleAvatar(
                          //radius: 50,
                          backgroundColor: val.screennumber == 4
                              ? Colors.white
                              : Colors.brown,
                          child: Icon(
                            Icons.group,
                            color: val.screennumber == 4
                                ? Colors.brown
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
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

  Future<void> showprofile(
      BuildContext context, String name, String phone, String title) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Consumer<control>(builder: (context, val, child) {
          return AlertDialog(
            scrollable: true,
            title: Row(
              children: [
                Icon(Icons.person),
                Text(name),
              ],
            ),
            elevation: 10,
            content: Center(
                child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.phone)),
                    Text(
                      textAlign: TextAlign.end,
                      phone,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.title)),
                    Text(
                      textAlign: TextAlign.end,
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
            actions: <Widget>[
              Consumer<control>(builder: (context, val, child) {
                return Container(
                  //width: 70,
                  child: Row(children: [
                    Expanded(
                      child: CircleAvatar(
                        backgroundColor: Colors.brown,
                        child: IconButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: phone));
                            },
                            icon: Icon(
                              Icons.copy,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    Expanded(
                      child: CircleAvatar(
                        backgroundColor: Colors.brown,
                        child: IconButton(
                            onPressed: () async {
                              //call(String number) async {
                              String number = phone;
                              final Uri uri = Uri(
                                scheme: 'tel',
                                path: '$number',
                              );
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              } else {
                                print('error');
                              }
                              //}
                            },
                            icon: Icon(
                              Icons.call,
                              color: Colors.white,
                            )),
                      ),
                    )
                  ]),
                )
                    // MaterialButton(
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   child:CircleAvatar(
                    //     backgroundColor: Colors.brown,
                    //     child: Icon(Icons.arrow_back,color: Colors.white,)),
                    // )

                    ;
              }),
            ],
          );
        });
      },
    );
  }

  Future<void> all_orders(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.white,
          elevation: 10,
          title: Consumer<control>(builder: (context, val, child) {
            return Text("${val.myOrders.length}\$");
          }),
          content: Consumer<control>(builder: (context, val, child) {
            return Container(
              width: 200,
              height: 250,
              child: ListView.builder(
                  itemCount: val.myOrders.length,
                  itemBuilder: (context, i) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                            "${val.myOrders.getAt(val.myOrders.length - i - 1).drinks}"),
                        subtitle: Text(
                          "${val.myOrders.getAt(val.myOrders.length - i - 1).number_order}   ${int.parse(val.myOrders.getAt(val.myOrders.length - i - 1).price)}\$",
                          style: TextStyle(fontSize: 10),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.brown,
                          radius: 22,
                          child: val.myOrders
                                      .getAt(val.myOrders.length - i - 1)
                                      .table_number ==
                                  "26"
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
                                      "${val.myOrders.getAt(val.myOrders.length - i - 1).table_number}",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        // trailing: Container(
                        //   width: 70,
                        //   child: Row(children: [
                        //     Container(
                        //       width: 35,
                        //       child: IconButton(
                        //           onPressed: () {
                        //             val.editnumbeorder(i);

                        //           },
                        //           icon: Icon(
                        //             Icons.edit,
                        //             color: Colors.brown,
                        //           )),
                        //     ),
                        //     Container(
                        //       width: 35,
                        //       child: IconButton(
                        //           onPressed: () {
                        //             val.deletchoseorder(i);
                        //           },
                        //           icon: Icon(Icons.delete)),
                        //     )
                        //   ]),
                        // ),
                      ),
                    );
                  }),
            );
          }),
          actions: <Widget>[
            Container(
              height: 50,
              width: double.infinity,
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
              child: Consumer<control>(builder: (context, val, child) {
                return MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (val.orderschose.length > 0) {
                    } else {}
                  },
                  child: Text(
                    "تاكيد",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
