import 'package:diyet/helper/databaseMethods.dart';
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
    print(_diets);
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
                children: new List.generate(
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
                                      color: Colors.grey[700],
                                      icon: Icon(Icons.add_outlined),
                                      onPressed: (){
                                        Navigator.pop(context, _diets[index]["mealListCode"]);
                                      },
                                    ) : Text((index+1).toString()),
                                    IconButton(
                                      color: Colors.grey[700],
                                      icon: Icon(Icons.settings),
                                      onPressed: (){Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Text("Diyet düzenle");
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
                    )),
              ),
            )));
  }
}

