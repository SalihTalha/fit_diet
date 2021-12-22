import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:diyet/helper/Helper.dart';
import 'package:diyet/helper/databaseMethods.dart';
import 'package:diyet/services/meal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chat.dart';
import 'list.dart';
import 'profile.dart';

class tabPages extends StatefulWidget {
  Map<String, dynamic> userMap = new Map();
  List<Map<String, dynamic>> listOfMealsInMealList = new List();
  Map<String, dynamic> mealListMap = new Map();

  tabPages(this.userMap, this.mealListMap, this.listOfMealsInMealList);

  @override
  _tabPagesState createState() => _tabPagesState(userMap, mealListMap, listOfMealsInMealList);
}

enum ThemeStyle {
  Dribbble,
  Light,
  NoElevation,
  AntDesign,
  BorderRadius,
  FloatingBar
}

class _tabPagesState extends State<tabPages> {

  Map<String, dynamic> userMap = new Map();
  List<Map<String, dynamic>> listOfMealsInMealList = new List();
  Map<String, dynamic> mealListMap = new Map();

  _tabPagesState(this.userMap, this.mealListMap, this.listOfMealsInMealList);


  @override
  void initState(){

    List<Meal> listOfMeals = [];

    List<dynamic> bigList = []; // Gün[ öğün adı [ öğün yemek kodları ] ] diğer öğün [..] , .. ] , diğer gün
    List<dynamic> list = []; // Öğün adı, [öğün yemek kodları], öğün adı, [öğün yemek kodları] ...
    List daysOfMealCounts = [];
    List mealCounts = []; // Her öğün için sırasıyla öğündeki yemek sayısı
    List tempList = [];
    List hours = [];
    List allHours = [];
    var tempMealCount = 0;

    mealListMap['mealNumbers'].forEach((key, val) {
      val.forEach((k, v){
        hours.add(v[0]);
        for(var i = 1; i < v.length; i++){
          tempList.add(int.parse(v[i]));
        }
        list.add(k);
        list.add(new List()..addAll(tempList));
        tempList.clear();
      });
      bigList.add(key);
      bigList.add(new List()..addAll(list));
      allHours.add(new List()..addAll(hours));
      hours.clear();
      list.clear();
    });


    var dayIndex = int.parse(DateTime.now().weekday.toString()) - 1;


    List minutes = []; // Her öğünün başlangıç saatinin dakika cinsinden değeri

    var now = int.parse(DateTime.now().hour.toString()) * 60 + int.parse(DateTime.now().minute.toString());
    var timeIndex = 0; // Sırada yenilmesi gereken öğünün indexi
    var temp;

    // tüm saatlere bakıp bugünün kaçıncı dakikasında olduğumuza göre kıyaslıyorum.
    // Yemek saatlerini dakika cinsinden minutes dizisine ekliyorum.
    //
    // Eklerken hangi öğünde olduğumuzu kontrol ediyorum ve o
    // öğünde isek timeIndex'u o öğünün indeksine ayarlıyorum.

    var minFound = 1440;

    for(var i = 0; i < allHours[dayIndex].length; i++){
      temp = int.parse((allHours[dayIndex][i]).toString().split(":")[0]) * 60 + int.parse((allHours[dayIndex][i]).toString().split(":")[1]);
      if(temp+45 > now){
        if(minFound > temp){
          timeIndex = i;
          minFound = temp;
        }
      }
    }

    List<Meal> mealListForNow;
    Map <dynamic, dynamic> mealMap = new Map();

    for(var i = 0; i < bigList[dayIndex*2+1][timeIndex*2+1].length; i++){
      // list listesinden mealCode'ları alıp mealMap'e mealCode: meal şeklinde yerleştiriyoruz.
      // Bunun için listOfMealsInMealList listesinden mealCode'u aynı olan meal'ı where ile buluyoruz.
      mealMap.putIfAbsent(bigList[dayIndex*2+1][timeIndex*2+1][i].toString(), () => listOfMealsInMealList.where((e) => (e['mealCode'] == bigList[dayIndex*2+1][timeIndex*2+1][i].toString())).toList()[0]);
    }
    // mealMap -> {mealCode: mealData}

    for(var i = 0; i < bigList[dayIndex*2+1][timeIndex*2+1].length; i++){

      listOfMeals.add( // Öğünde bulunan meal'ların listesi
          Meal(
            mealMap[bigList[dayIndex*2+1][timeIndex*2+1][i].toString()]['mealName'], // mealMap[13]['mealName']
            allHours[dayIndex][timeIndex],
            bigList[dayIndex*2+1][timeIndex*2].toString(),
            mealMap[bigList[dayIndex*2+1][timeIndex*2+1][i].toString()]['mealPhotoLink'],
            mealMap[bigList[dayIndex*2+1][timeIndex*2+1][i].toString()]['mealIngredients'],
            mealMap[bigList[dayIndex*2+1][timeIndex*2+1][i].toString()]['recipe'],
          )
      );
    }

    children.add(chatPage(userMap['chatCode']));
    children.add(profilePage(userMap, mealListMap, listOfMealsInMealList, listOfMeals));
    children.add(listPage(mealListMap, listOfMealsInMealList, list));
  }

  PageController _pageController = PageController(initialPage: 1);

  String chatPath;

  int _currentIndex = 1;

  ThemeStyle _currentStyle = ThemeStyle.Light;


  List <Widget> children = List<Widget>();

  void changePage(int index){
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        onPageChanged: (page){
          setState(() {
            _currentIndex = page;
          });
        },
        controller: _pageController,
        children: children,
      ),

      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 50,
        color: Colors.white,
        backgroundColor: const Color(0xFFE9E9E9),
        buttonBackgroundColor:  secondaryColorDark,
        items: [
          Icon(Icons.message),
          Icon(Icons.person),
          Icon(Icons.menu)
        ],
        onTap: changePage,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(
          milliseconds: 300,
        ),

      ),

    );
  }
}