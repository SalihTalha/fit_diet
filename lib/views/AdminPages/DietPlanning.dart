import 'package:diyet/helper/Helper.dart';
import 'package:diyet/helper/databaseMethods.dart';
import 'package:diyet/views/AdminPages/DietPlanningOperations.dart';
import 'package:diyet/views/AdminPages/mainPage.dart';
import 'package:flutter/material.dart';

class DietPlanning extends StatefulWidget {
  final diet;

  const DietPlanning ({ this.diet }): super();

  @override
  _DietPlanning createState() => _DietPlanning();
}

class _DietPlanning extends State<DietPlanning> {

  var choosenMealList = new Map();
  @override
  Widget build(BuildContext context) {
    TextEditingController freeToEat = new TextEditingController(text: widget.diet["freeToEats"] != null ? widget.diet["freeToEats"].join(',') : "");
    TextEditingController name = new TextEditingController(text: widget.diet['mealListCode'] != null ? widget.diet['mealListCode']: '');
    TextEditingController dontEat = new TextEditingController(text: widget.diet['dontEats'] != null ? widget.diet['dontEats'].join(','): '');
    TextEditingController weekImageUrl = new TextEditingController(text: widget.diet['weekImageUrl'] != null ? widget.diet['weekImageUrl']: '');
    TextEditingController weekName = new TextEditingController(text: widget.diet['weekText'] != null ? widget.diet['weekText']: '');
    TextEditingController weekUrl = new TextEditingController(text: widget.diet['weekUrl'] != null ? widget.diet['weekUrl']: '');

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
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    controller: freeToEat,
                    cursorColor: Theme.of(context).cursorColor,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Serbest Olan Yiyecekler',
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    controller: dontEat,
                    cursorColor: Theme.of(context).cursorColor,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Yasak Olan Yiyecekler',
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    controller: weekImageUrl,
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
                    controller: weekName,
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
                    controller: weekUrl,
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
                        primary: primaryColor,
                      ),
                      onPressed: () async => {
                        choosenMealList = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DietPlanningOperations();
                          },
                        ),
                      ),
                      },
                      child: Text('DİYET PLANLAMA'),
                    )),
                Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.pop(
                                context
                            ),
                          },
                          child: Text('GERİ'),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            DatabaseMethods().addMealList({
                              'dontEats': dontEat.text.split(','),
                              'freeToEats': freeToEat.text.split(','),
                              'weekImageUrl': weekImageUrl.text,
                              'weekUrl': weekUrl.text,
                              'weekText': weekName.text,
                              'mealListCode': name.text,
                              'mealNumbers': {
                                '1': choosenMealList,
                                '2': choosenMealList,
                                '3': choosenMealList,
                                '4': choosenMealList,
                                '5': choosenMealList,
                                '6': choosenMealList,
                                '7': choosenMealList,
                              }
                            }),
                            Navigator.pop(
                                context
                            ),
                          },
                          child: Text('KAYDET'),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
