import 'package:animations/animations.dart';
import 'package:diyet/services/meal.dart';
import 'package:diyet/views/profileScreenDesign.dart';
import 'package:flutter/material.dart';

import 'meal_detail_screen.dart';

class ProgramMealSelectedView extends StatelessWidget {
  Map<String, dynamic> newMap;
  List mealListMapToday;
  String timeName;
  ProgramMealSelectedView(this.newMap, this.mealListMapToday, this.timeName);

  @override
  Widget build(BuildContext context) {
    List<Meal> meals = [];
    for (var i = 1; i < mealListMapToday.length; i++) {
      meals.add(new Meal(
        newMap[mealListMapToday[i]]['mealName'],
        mealListMapToday[0].toString(),
        timeName,
        newMap[mealListMapToday[i]]['mealPhotoLink'],
        newMap[mealListMapToday[i]]['mealIngredients'],
        newMap[mealListMapToday[i]]['recipe'],
      ));
    }
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context,index) => Divider(color: Colors.transparent,),
          itemCount: meals.length,
          itemBuilder: (BuildContext context, int index) {
            return OpenContainer(
              closedBuilder: (context, VoidCallback openContainer) {
                return GestureDetector(
                  onTap: openContainer,
                  child: ListTile(
                    leading: Image.network(meals[index].imagePath),
                    title: Text(
                      meals[index].mealName,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
              openBuilder: (context, _) {
                return MealDetailScreen(meal: meals[index]);
              },
            );
          }),
    );
  }
}
