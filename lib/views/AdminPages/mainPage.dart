import 'package:diyet/main.dart';
import 'package:diyet/views/AdminPages/CreateCustomer.dart';
import 'package:diyet/views/AdminPages/DietsPage.dart';
import 'package:diyet/views/AdminPages/chatAdmin.dart';
import 'package:diyet/views/AdminPages/Customers.dart';
import 'package:diyet/views/AdminPages/UpdateCustomer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diyet/helper/Helper.dart';

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
        'text': 'Diyetler',
        'onTap': Diets(
          toChoose: false,
        )
      },
      {'text': 'Kullanıcılar', 'onTap': Customers()},
      {'text': 'Kullanıcı Ekle', 'onTap': CreateCustomer()},
    ];

    var topView = [
      Padding(
        padding: const EdgeInsets.all(24.0),
        child: Image.network(
            "https://www.researchgate.net/publication/335975371/figure/fig1/AS:806095123652619@1569199462871/Hacker-stock-photo-Image-credit-hacker-1-iaBeta-C-2017-Public-Domain.png"),
      ),
      Text("Hoşgeldiniz, Salih Talha"),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
            children: new List.from(topView)
              ..addAll(
                List.generate(values.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 24.0, left: 24.0, right: 24.0, bottom: 10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => values[index]['onTap']),
                        );
                      },
                      child: Container(
                        color: primaryColor,
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
              )),
      ),
    );
  }
}
