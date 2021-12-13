import 'package:diyet/views/UpdateCustomer.dart';
import 'package:flutter/material.dart';

class Customers extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  @override
  Widget build(BuildContext context) {
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
            5,
            (index) => Card(
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return UpdateCustomer();
                        },
                      ),
                    ),
                      child: Container(
                    height: 150,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                              child: Text("Image"),//Image.asset(""),
                            ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text("İsim Soyisim"),
                          ),
                          flex: 8,
                        ),
                      ],
                    ),
                  )),
                )),
      ),
    )));
  }
}
