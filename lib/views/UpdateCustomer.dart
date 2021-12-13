import 'dart:io';
import 'package:diyet/views/DietPlanning.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import '../helper/Helper.dart';

class UpdateCustomer extends StatefulWidget {
  @override
  _UpdateCustomer createState() => _UpdateCustomer();
}

class _UpdateCustomer extends State<UpdateCustomer> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
        margin: EdgeInsets.only(
          left: 20,
          bottom: 20,
          right: 20,
          top: 50,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  FlatButton(
                    onPressed: null,
                    padding: EdgeInsets.all(0.0),
                    child: const CircleAvatar(
                      child: Icon(Icons.account_circle_outlined, size: 100),
                      radius: 50,
                    ),
                  ),
                ],
              ),
              Text("İsim Soyisim"),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Giriş Kodunu Değiştir',
                  ),
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextFormField(
                        cursorColor: Theme.of(context).cursorColor,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Yaş',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Boy',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        cursorColor: Theme.of(context).cursorColor,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Kilo',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        cursorColor: Theme.of(context).cursorColor,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Hedef Kilo',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () =>
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DietPlanning();
                        },
                      ),
                    ),
                  child: Text('DİYET PLANLAMA'),
                )
              ),
              Container(
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Respond to button press
                    },
                    child: Text('GÜNCELLE'),
                  )
              ),
            ],
          ),
        ),
      ),
    ),);
  }
}
