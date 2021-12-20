import 'package:diyet/views/AdminPages/mealslistPage.dart';
import 'package:flutter/material.dart';
import 'package:diyet/views/programDaySelectedView.dart';

class DietPlanningOperations extends StatefulWidget {
  @override
  _DietPlanningOperationsState createState() => _DietPlanningOperationsState();
}

class _DietPlanningOperationsState extends State<DietPlanningOperations> {
  var choosenMealList = [];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                // top: height * 0.25,
                // height: height * 0.7,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(20),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 18, bottom: 60),
                    color: const Color(0xFFE9E9E9),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 7,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            right: 30.0,
                            left: 30.0,
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(60),
                            ),
                            child: Container(
                              color: Colors.transparent,
                              child: Card(
                                child: Container(
                                  color: const Color(0xFF200087),
                                  child: ListTile(
                                    title: Center(
                                      child: Text(
                                        numbersToDays([
                                          "1",
                                          "2",
                                          "3",
                                          "4",
                                          "5",
                                          "6",
                                          "7"
                                        ][index]),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    onTap: () async {
                                      var tempChoosenMeals = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return MealListPage();
                                          },
                                        ),
                                      );
                                      if(tempChoosenMeals != []){
                                        choosenMealList.add(tempChoosenMeals);
                                      }
                                      print(choosenMealList);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  numbersToDays(number) {
    switch (number) {
      case "1":
        return "Pazartesi";
      case "2":
        return "Salı";
      case "3":
        return "Çarşamba";
      case "4":
        return "Perşembe";
      case "5":
        return "Cuma";
      case "6":
        return "Cumartesi";
      case "7":
        return "Pazar";
      default:
        return number;
    }
  }
}
