import 'package:diyet/helper/Helper.dart';
import 'package:diyet/helper/databaseMethods.dart';
import 'package:diyet/views/AdminPages/chatAdmin.dart';
import 'package:diyet/views/AdminPages/UpdateCustomer.dart';
import 'package:flutter/material.dart';

class Customers extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  var _users = [];

@override
  void initState() {
  DatabaseMethods().getUserList().then((val) {
    setState(() {
      _users=val;
    });
  });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  print(_users);
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
        top: 50,
      ),
      child: Column(
        children: new List.generate(
            _users.length,
            (index) => Card(
                  child: Container(
                    height: 150,
                    color: Colors.white,
                    child: Row(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                          child: Image.network(
                            _users[index]["photoLink"],
                            fit: BoxFit.cover,
                          ),
                        ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(_users[index]["name"]),
                      ),
                      flex: 8,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            color: primaryColorLight,
                            icon: Icon(Icons.message),
                            onPressed: (){Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return chatAdminPage(_users[index]["chatCode"]);
                                  },
                              ),
                            );
                            },
                          ),
                          IconButton(
                            color: primaryColorDark,
                            icon: Icon(Icons.settings),
                            onPressed: (){Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return UpdateCustomer(user: _users[index]);                                },
                              ),
                            );
                            },
                          ),
                        ],
                      )
                    )
                  ],
                    ),
                  ),
                )),
      ),
    )));
  }
}

