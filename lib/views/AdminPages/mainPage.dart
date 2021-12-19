import 'package:diyet/main.dart';
import 'package:diyet/views/AdminPages/CreateCustomer.dart';
import 'package:diyet/views/AdminPages/chatAdmin.dart';
import 'package:diyet/views/AdminPages/Customers.dart';
import 'package:diyet/views/AdminPages/UpdateCustomer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage() : super();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    var values = [
      {
        'text': 'Kullanıcı İşlemleri',
        'onTap': HomeS()
      },
      {
        'text': 'Kullanıcılar',
        'onTap': Customers()
      },
      {
        'text': 'Kullanıcı Ekle',
        'onTap': CreateCustomer()
      },
      {
        'text': 'Profil',
        'onTap': HomeS()
      }
    ];
    return Scaffold(
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(4, (index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => values[index]['onTap']),
                    );

                  },
                  child: Container(
                    color: Colors.lightBlue,
                    child: Center(
                      child: Text(
                        values[index]['text'],
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                ),
              );
            }),
        ),
      ),
    );
  }
}
