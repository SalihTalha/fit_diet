import 'package:diyet/helper/Helper.dart';
import 'package:diyet/helper/databaseMethods.dart';
import 'package:diyet/views/AdminPages/DietPlanning.dart';
import 'package:diyet/views/AdminPages/chatAdmin.dart';
import 'package:diyet/views/AdminPages/UpdateCustomer.dart';
import 'package:flutter/material.dart';

class Diets extends StatefulWidget {
  final toChoose;
  const Diets ({ this.toChoose }): super();

  @override
  _DietsState createState() => _DietsState();
}

class _DietsState extends State<Diets> {
  var _diets = [];

  @override
  void initState() {
    DatabaseMethods().getDietsList().then((val) {
      setState(() {
        _diets=val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var addView = [Card(
      child: Container(
        height: 150,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text("Yeni Diyet Oluştur"),
              ),
              flex: 8,
            ),
            Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      color: primaryColorLight,
                      icon: Icon(Icons.add_outlined),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DietPlanning(diet: 'new');
                            },
                          ),
                        );
                      },
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    ),];

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
                top: 50,
              ),
              child: Column(
                children: new List.from(addView)..addAll(
                  List.generate(
                    _diets.length,
                        (index) => Card(
                      child: Container(
                        height: 150,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Image.network(
                                  _diets[index]["weekImageUrl"],
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                                    return Text('Image Not Given');
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(_diets[index]["mealListCode"]),
                              ),
                              flex: 8,
                            ),
                            Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    widget.toChoose ? IconButton(
                                      color: secondaryColorDark,
                                      icon: Icon(Icons.add_outlined),
                                      onPressed: (){
                                        Navigator.pop(context, _diets[index]["mealListCode"]);
                                      },
                                    ) : Text((index+1).toString()),
                                    IconButton(
                                      color: secondaryColorDark,
                                      icon: Icon(Icons.settings),
                                      onPressed: (){Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            print(_diets[index]);
                                            return DietPlanning(diet: _diets[index]);
                                          },
                                        ),
                                      );
                                      },
                                    ),
                                  ],
                                )
                            )
                          ],
                        ),
                      ),
                    )
                ),
                )
              ),
            )));
  }
}

