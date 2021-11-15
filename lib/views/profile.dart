import 'package:diyet/services/meal.dart';
import 'package:diyet/views/profileScreenDesign.dart';
import 'package:flutter/material.dart';

class profilePage extends StatefulWidget {
  List<Map<String, dynamic>> listOfMealsInMealList = new List();
  Map<String, dynamic> userMap = new Map();
  Map<String, dynamic> mealListMap = new Map();
  List<Meal> listOfMeals = [];

  profilePage(this.userMap, this.mealListMap, this.listOfMealsInMealList, this.listOfMeals);
  @override
  _profilePageState createState() => _profilePageState(userMap, mealListMap, listOfMealsInMealList, this.listOfMeals);
}

class _profilePageState extends State<profilePage> {


  List<Map<String, dynamic>> listOfMealsInMealList = new List();
  Map<String, dynamic> userMap = new Map();
  Map<String, dynamic> mealListMap = new Map();
  List<Meal> listOfMeals = [];

  _profilePageState(this.userMap, this.mealListMap, this.listOfMealsInMealList, this.listOfMeals);

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(userMap, mealListMap, listOfMealsInMealList, listOfMeals);
  }
}
