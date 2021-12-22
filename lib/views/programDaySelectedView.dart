import 'package:diyet/helper/Helper.dart';
import 'package:diyet/views/programMealSelectedView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'basicListPage.dart';

onTappedView(List<Map<String, dynamic>> listOfMealsInMealList,
    Map<String, dynamic> mealListMapToday) {
  // List<Meal> yemekListesi; (ileride böyle alacak) ve meal_detail_screen'e geçişi olacak

  print(listOfMealsInMealList);
  print(mealListMapToday);

  Map<String, dynamic> newMap = new Map();

  for (var i = 0; i < listOfMealsInMealList.length; i++) {
    newMap.putIfAbsent(
        listOfMealsInMealList[i]['mealCode'], () => listOfMealsInMealList[i]);
  }

  print(newMap);
  List metaData = [];
  List temp = [];
  List data = [];

  mealListMapToday.forEach((key, value) {
    metaData.add(key.toString());
    metaData.add(value[0].toString());
    metaData.add(value.length - 1);
    for (var i = 1; i < value.length; i++) temp.add(value[i]);
  });

  swap(no1, no2){
    var temp1,temp2,temp3;
    temp1 = metaData[no1*3];
    temp2 = metaData[no1*3+1];
    temp3 = metaData[no1*3+2];
    metaData[no1*3] = metaData[no2*3];
    metaData[no1*3+1] = metaData[no2*3+1];
    metaData[no1*3+2] = metaData[no2*3+2];
    metaData[no2*3] = temp1;
    metaData[no2*3+1] = temp2;
    metaData[no2*3+2] = temp3;
  }

  toMinute(number){
    return int.parse(number.split(":")[0]) * 60 + int.parse(number.split(":")[1]);
  }

  var min = 0;

  for(var i = 0; i < (metaData.length / 3).round(); i++){
    min = i;
    for(var j = i; j < (metaData.length / 3).round(); j++){
      if(toMinute(metaData[min*3+1]) > toMinute(metaData[j*3+1])){
        min = j;
      }
    }
    swap(i, min);
  }

  print(temp);
  print(metaData);

  return Scaffold(
      body: Center(
          child: ListView.builder(
    itemCount: (metaData.length / 3).round(),
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
                      child: ListTile(
                    title: Center(
                      child: Text(
                        metaData[index * 3],
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontSize: 26,
                        ),
                      ),
                    ),
                    subtitle: Center(
                      child: Text(
                        metaData[index * 3 + 1],
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.white54,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProgramMealSelectedView(
                            newMap,
                            mealListMapToday[metaData[index * 3].toString()],
                            metaData[index * 3]
                                .toString());
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  )));
}
