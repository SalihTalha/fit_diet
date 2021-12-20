import 'package:animations/animations.dart';
import 'package:diyet/main.dart';
import 'package:diyet/services/meal.dart';
import 'package:diyet/views/AdminPages/CreateCustomer.dart';
import 'package:diyet/views/AdminPages/chatAdmin.dart';
import 'package:diyet/views/AdminPages/Customers.dart';
import 'package:diyet/views/AdminPages/UpdateCustomer.dart';
import 'package:diyet/views/meal_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diyet/helper/databaseMethods.dart';

class MealListPage extends StatefulWidget {

  final String ogun;
  final String saat;

  const MealListPage ({this.ogun, this.saat}): super();

  @override
  _MealListPageState createState() => _MealListPageState();
}

class _MealListPageState extends State<MealListPage> {
  var meals = [];
  var choosenMeals = [];
  var choosenMealsResult = [];

  @override
  void  initState() {
    DatabaseMethods().getMealList().then((val) {
      setState(() {
        print(val);
        for (var i = 0; i < val.length; i++) {
          meals.add(new Meal(
            val[i]['mealName'].toString(),
            widget.saat,
            widget.ogun,
            val[i]['mealPhotoLink'].toString(),
            val[i]['mealIngredients'],
            val[i]['recipe'].toString(),
            val[i]['mealCode'].toString(),
          ));
        }
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yemekleri seç"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => {
          for(var i = 0; i < choosenMeals.length; i++){
            choosenMealsResult.add(choosenMeals[i].mealCode),
          },
          choosenMealsResult.insert(0, widget.saat),
          Navigator.pop(context, {widget.ogun : choosenMealsResult}),
          },
        ),
        actions: [
          IconButton(icon: Icon(Icons.done), onPressed: (){
            for(var i = 0; i < choosenMeals.length; i++){
              choosenMealsResult.add(choosenMeals[i].mealCode);
            }
            choosenMealsResult.insert(0, widget.saat);
            Navigator.pop(context, {widget.ogun : choosenMealsResult});
          })
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
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
                      trailing: IconButton(
                        icon: choosenMeals.contains(meals[index])? Icon(Icons.remove): Icon(Icons.add),
                        onPressed: (){
                          setState(() {
                            if(choosenMeals.contains(meals[index])){
                              choosenMeals.remove(meals[index]);
                            }
                            else{
                              choosenMeals.add(meals[index]);
                            }
                          });
                        },
                      ),
                    ),
                  );
                },
                openBuilder: (context, _) {
                  return MealDetailScreen(meal: meals[index]);
                },
              );
            })
      ),
    );
  }
}
