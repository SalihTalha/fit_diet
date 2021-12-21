import 'package:diyet/helper/Helper.dart';
import 'package:diyet/views/AdminPages/mealslistPage.dart';
import 'package:flutter/material.dart';
import 'package:diyet/views/programDaySelectedView.dart';

class DietPlanningOperations extends StatefulWidget {
  @override
  _DietPlanningOperationsState createState() => _DietPlanningOperationsState();
}

class _DietPlanningOperationsState extends State<DietPlanningOperations> {
  var choosenMealList = new Map();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
          appBar: AppBar(
            title: Text("Öğün seç"),
            actions: [
              IconButton(icon: Icon(Icons.done), onPressed: (){
                Navigator.pop(context, choosenMealList);
              })
            ],
          ),
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
                      itemCount: 3,
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
                                  color: secondaryColorDark,
                                  child: ListTile(
                                    title: Center(
                                      child: Text(
                                        numbersToTimes([
                                          "1",
                                          "2",
                                          "3"
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
                                          return MealListPage(ogun: numbersToTimes([
                                            "1",
                                            "2",
                                            "3"
                                          ][index]), saat: ["09:00", "14:00", "18:00"][index]);
                                        },
                                      ),
                                    );
                                    if(tempChoosenMeals != [] && tempChoosenMeals != null){
                                      choosenMealList.addAll(tempChoosenMeals);
                                    }
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

  numbersToTimes(number) {
    switch (number) {
      case "1":
        return "Kahvaltı";
      case "2":
        return "Öğle Yemeği";
      case "3":
        return "Akşam Yemeği";
      default:
        return number;
    }
  }
}
