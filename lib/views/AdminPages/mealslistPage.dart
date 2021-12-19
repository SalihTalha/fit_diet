import 'package:diyet/main.dart';
import 'package:diyet/views/AdminPages/CreateCustomer.dart';
import 'package:diyet/views/AdminPages/chatAdmin.dart';
import 'package:diyet/views/AdminPages/Customers.dart';
import 'package:diyet/views/AdminPages/UpdateCustomer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:diyet/helper/databaseMethods.dart';

class MealListPage extends StatefulWidget {
  const MealListPage() : super();

  @override
  _MealListPageState createState() => _MealListPageState();
}

class _MealListPageState extends State<MealListPage> {
  @override
  Widget build(BuildContext context) {
    var values = DatabaseMethods().getMealList();
    return Scaffold(
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(4, (index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                child: Container(
                  color: Colors.lightBlue,
                  child: Center(
                    child: Text(
                      values[index]['mealName'],
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
