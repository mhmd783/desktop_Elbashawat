import 'package:elbshwat/modules/dialoge.dart';
import 'package:elbshwat/prov/Prov.dart';
import 'package:elbshwat/view/printusers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UsersScreen();
  }
}

class _UsersScreen extends State<UsersScreen> {
  Dialoge dialoge = new Dialoge();
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<control>(context, listen: false).getUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<control>(builder: (context, val, child) {
          return Text("${val.users.length} Guest..");
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
      backgroundColor: Colors.white,
      body: Consumer<control>(builder: (context, val, child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          //height: 400,
          child: val.users == []
              ? SizedBox()
              : ListView.builder(
                  itemCount: val.users.length,
                  itemBuilder: (context, i) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                          onTap: () {
                            dialoge.showprofile(
                                context,
                                "${val.users[i].name}",
                                '${val.users[i].phone}',
                                "${val.users[i].title}");
                          },
                          title: Text("${val.users[i].name}"),
                          subtitle: Text(
                            "${val.users[i].phone}",
                            style: TextStyle(fontSize: 10),
                          ),
                          leading: CircleAvatar(
                            //radius: 50,
                            backgroundColor: Colors.brown,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          trailing: Text("${val.users[i].title}")),
                    );
                  }),
        );
      }),
      floatingActionButton: Consumer<control>(builder: (context, val, child) {
        return FloatingActionButton(
          backgroundColor: Colors.brown,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfUsers(users: val.users),
              ),
            );
          },
          child: Icon(
            Icons.picture_as_pdf,
            color: Colors.white,
          ),
        );
      }),
    );
  }
}
