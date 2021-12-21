import 'package:animations/animations.dart';
import 'package:diyet/helper/Helper.dart';
import 'package:diyet/services/meal.dart';
import 'package:diyet/views/meal_detail_screen.dart';
import 'package:diyet/views/profileDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart' as math;
import 'package:intl/intl.dart';

import 'basicListPage.dart';

class ProfileScreen extends StatelessWidget {
  List<Map<String, dynamic>> listOfMealsInMealList = new List();
  Map<String, dynamic> userMap = new Map();
  Map<String, dynamic> mealListMap = new Map();
  List<Meal> listOfMeals = [];
  TextEditingController kgController = new TextEditingController();

  ProfileScreen(this.userMap, this.mealListMap, this.listOfMealsInMealList,
      this.listOfMeals);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            height: height * 0.35,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomRight: const Radius.circular(20),
              ),
              child: Container(
                color: Colors.white,
                padding:
                    EdgeInsets.only(top: 5, left: 32, right: 16, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TODO , randevu takip, diyetisyen durumu ve mesaj saatleri
                    ListTile(
                      title: Text(day(DateTime.now().weekday),
                          style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          )),
                      subtitle: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "Merhaba, " + userMap['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      trailing: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                          userMap['photoLink'],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RadialProgress(
                            height * 0.18,
                            height * 0.18,
                            findProgress(
                                userMap['weightArray'], userMap['weightGoal']),
                            findKg(userMap['weightArray'])),
                        SizedBox(
                          width: 15,
                        ),
                        RadialProgress(
                          height * 0.18,
                          height * 0.18,
                          0.33,
                          "200/600",
                          color: secondaryColorLight,
                          textColor: secondaryColorDark,
                          text2: "Yürüyüş",
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.37,
            left: 0,
            right: 0,
            height: height * 0.54,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                      left: 32,
                      right: 16,
                    ),
                    child: Text(
                      "GÜNÜN YEMEKLERİ",
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 32,
                          ),
                          for (int i = 0; i < listOfMeals.length; i++)
                            OpenContainer(
                              closedBuilder:
                                  (context, VoidCallback openContainer) {
                                return GestureDetector(
                                    onTap: openContainer,
                                    child: MealCard(listOfMeals[i]));
                              },
                              openBuilder: (context, _) {
                                return MealDetailScreen(meal: listOfMeals[i]);
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 32, right: 32),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              secondaryColorDark,
                              secondaryColorDark,
                            ]),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, top: 16.0),
                                child: Text(
                                  "Günlük Hedefiniz",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Icon(
                                    Icons.directions_run,
                                    color: Colors.white,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      userMap['goal'],
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: OpenContainer(
                                  closedBuilder:
                                      (context, VoidCallback openContainer) {
                                    return GestureDetector(
                                      onTap: openContainer,
                                      child: Container(
                                        child: Icon(
                                          Icons.assignment_late_outlined,
                                          color: Colors.white,
                                        ),
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: Color(0xFF5B4D9D),
                                        ),
                                      ),
                                    );
                                  },
                                  openBuilder: (context, _) {
                                    return BasicList("Yasak Olan Yiyecekler",
                                        mealListMap['dontEats']);
                                  },
                                ),
                              ),
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: OpenContainer(
                                  closedBuilder:
                                      (context, VoidCallback openContainer) {
                                    return GestureDetector(
                                      onTap: openContainer,
                                      child: Container(
                                        child: Icon(Icons.assignment_turned_in,
                                            color: Colors.white),
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: Color(0xFF5B4D9D),
                                        ),
                                      ),
                                    );
                                  },
                                  openBuilder: (context, _) {
                                    return BasicList("Serbest Olan Yiyecekler",
                                        mealListMap['freeToEats']);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double findProgress(userMap, goal) {
    return (double.parse(userMap.first['weight']) -
            double.parse(userMap.last['weight'])) /
        (double.parse(userMap.first['weight']) - goal);
  }

  String findKg(userMap) {
    return (double.parse(userMap.first['weight']) -
            double.parse(userMap.last['weight']))
        .toStringAsFixed(2);
  }

  String day(int weekday) {
    switch (weekday) {
      case 1:
        return DateTime.now().month.toString() + 'Pazartesi';
      case 2:
        return DateTime.now().month.toString() + 'Salı';
      case 3:
        return DateTime.now().month.toString() + 'Çarşamba';
      case 4:
        return DateTime.now().month.toString() + 'Perşembe';
      case 5:
        return DateTime.now().month.toString() + 'Cuma';
      case 6:
        return DateTime.now().month.toString() + 'Cumartesi';
      case 7:
        return DateTime.now().month.toString() + 'Pazar';
    }
  }
}

class BarProgress extends StatelessWidget {
  final String name;
  final double progress, width;
  final Color color;

  const BarProgress({Key key, this.name, this.progress, this.color, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            name.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Stack(
          children: [
            Container(
              height: 10,
              width: width * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.grey,
              ),
            ),
            Container(
              height: 10,
              width: width * 0.5 * progress,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: color,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class RadialProgress extends StatelessWidget {
  final double height, width, progress;
  final String text, text2;
  final Color color;
  final Color textColor;

  RadialProgress(this.height, this.width, this.progress, this.text,
      {this.color: const Color(0xFF200087),
      this.textColor: const Color(0xFF200087),
      this.text2: "kg"});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RadialPainter(progress, color: color),
      child: Container(
        height: height,
        width: width,
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                text: text,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textColor),
              ),
              TextSpan(text: "\n"),
              TextSpan(
                text: text2,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: textColor),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class RadialPainter extends CustomPainter {
  final double progress;
  final Color color;
  RadialPainter(this.progress, {this.color: const Color(0xFF200087)});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90), math.radians(-380 * progress), false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard(@required this.meal);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE9E9E9),
      child: Container(
        color: const Color(0xFFE9E9E9),
        margin: const EdgeInsets.only(right: 20, bottom: 10),
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image.network(
                    meal.imagePath,
                    width: 150,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        meal.mealTimeName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.blueGrey),
                      ),
                      Text(
                        meal.mealName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.black87),
                      ),
                      Row(children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.black38,
                          size: 18,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          meal.mealTimeHour,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ]),
                      SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
