import 'dart:io';
import '../views/AdminMainPage.dart';
import '../views/DietPlanningOperations.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import '../helper/Helper.dart';

class DietPlanning extends StatefulWidget {
  @override
  _DietPlanning createState() => _DietPlanning();
}

class _DietPlanning extends State<DietPlanning> {
  TextEditingController cont = new TextEditingController();
  TextEditingController cont1 = new TextEditingController();
  TextEditingController cont2 = new TextEditingController();
  TextEditingController cont3 = new TextEditingController();
  TextEditingController cont4 = new TextEditingController();
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
                    controller: cont,
                    cursorColor: Theme.of(context).cursorColor,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Free To Eat',
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    controller: cont1,
                    cursorColor: Theme.of(context).cursorColor,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Dont Eat',
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    controller: cont2,
                    cursorColor: Theme.of(context).cursorColor,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Haftalık Öneri Resiminin Linki',
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    controller: cont3,
                    cursorColor: Theme.of(context).cursorColor,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Haftalık Öneri',
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    controller: cont4,
                    cursorColor: Theme.of(context).cursorColor,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Haftalık Önerinin Linki',
                    ),
                  ),
                ),
                Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DietPlanningOperations();
                          },
                        ),
                      ),
                      child: Text('DİYET PLANLAMA'),
                    )),
                Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      onPressed: () => {
                        //TODO addMealList çağıralacak + user'a atama kodunu çağır
                        print(cont.text +
                            " " +
                            cont1.text +
                            " " +
                            cont2.text +
                            " " +
                            cont3.text +
                            " " +
                            cont4.text),
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AdminManinPage();
                            },
                          ),
                        ),
                      },
                      child: Text('BİTİR'),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
