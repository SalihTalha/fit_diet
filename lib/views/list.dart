import 'package:diyet/views/programDaySelectedView.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class listPage extends StatefulWidget {

  List<Map<String, dynamic>> listOfMealsInMealList = new List();
  Map<String, dynamic> mealListMap = new Map();
  List<dynamic> list;

  listPage(this.mealListMap, this.listOfMealsInMealList, this.list);

  @override
  _listPageState createState() => _listPageState(mealListMap, listOfMealsInMealList, list);
}

class _listPageState extends State<listPage> {

  List<Map<String, dynamic>> listOfMealsInMealList = new List();
  Map<String, dynamic> mealListMap = new Map();
  List<dynamic> list;


  _listPageState(this.mealListMap, this.listOfMealsInMealList, this.list);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //print(mealListMap);
    //print(listOfMealsInMealList);
    //print(list);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                height: height * 0.25,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: const Radius.circular(40),
                  ),
                  child: Container(
                    color: Colors.white,
                    padding:
                        EdgeInsets.only(top: 5, left: 32, right: 16, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "HAFTALIK\nPROGRAM",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 26,
                            color: const Color(0xFF20008B),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final url = mealListMap['weekUrl'] != null ? mealListMap['weekUrl'].toString() : mealListMap['weekText'];
                            if (await canLaunch(url))
                            await launch(url);
                            else
                            // can't launch url, there is some error
                            throw "Could not launch $url";
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20),
                            ),
                            child: Container(
                              color: const Color(0xFFA5A5FF),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                      top: 8.0,
                                    ),
                                    child: Text(
                                      "Haftanın Tarifi",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20,
                                        color: const Color(0xFF010179),
                                      ),
                                    ),
                                  ),
                                  Image.network(
                                    mealListMap['weekImageUrl'],
                                    height: 80,
                                    width: 80,
                                  ),
                                  Text(
                                    mealListMap['weekText'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height * 0.25,
                height: height * 0.7,
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
                      itemCount: mealListMap['mealNumbers']?.length!= null ? mealListMap['mealNumbers'].length : 0,
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
                                        numbersToDays(mealListMap['mealNumbers'].keys.toList()[index]).toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          //print(index);
                                          //List<List<dynamic>> liste = [];
                                          //mealListMap[keys[index]].forEach((key, value) {
                                          //  List<dynamic> liste2 = [key, value];
                                          //  liste.add(liste2);
                                          //});
                                          return onTappedView(listOfMealsInMealList, mealListMap['mealNumbers'][(index+1).toString()]);
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
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  numbersToDays(number) {
    if(mealListMap['mealNumbers'].length == 2){
      if(number == "1") return "Haftaiçi";
      if(number == "2") return "Haftasonu";
    }
    switch(number){
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

  // no need to use anymore

  //fixTheList(){
  //  List<List<List<dynamic>>> weekListCopy = [];
  //  List<List<dynamic>> oneDayList = [];
  //  List<dynamic> hourAndMeal = [];
  //  list.forEach((key, value) {
  //    if(key != null){
  //      value.forEach((key2, value2){
  //        if(key2 != null){
  //          hourAndMeal.add(key2);
  //          hourAndMeal.add(value2);
  //        }
  //        oneDayList.add(hourAndMeal);
  //        hourAndMeal.clear();
  //      });
  //    }
  //    weekListCopy.add(oneDayList);
  //    oneDayList.clear();
  //  });
  //  setState(() {
  //    weekList = weekListCopy;
  //  });
  //}

}
