import 'dart:io';
import 'package:diyet/helper/databaseMethods.dart';
import 'package:diyet/views/AdminPages/DietPlanning.dart';
import 'package:diyet/views/AdminPages/DietsPage.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:diyet/helper/Helper.dart';

class CreateCustomer extends StatefulWidget {
  final user;
  const CreateCustomer({this.user}) : super();

  @override
  _CreateCustomer createState() => _CreateCustomer();
}

class _CreateCustomer extends State<CreateCustomer> {
  TextEditingController myController;
  TextEditingController chatCodeController;
  TextEditingController nameController;
  TextEditingController ageController;
  TextEditingController heightController;
  TextEditingController weightController;
  TextEditingController weightGoalController;
  bool _isHide = true;
  final _formKey = GlobalKey<FormState>();
  var imageUrl = null;
  var selectedDietPlan = "Seçilmedi";

  @override
  void initState() {
    setState(() {
      myController = TextEditingController(text: 'https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png');
      nameController = TextEditingController();
      chatCodeController = TextEditingController();
      ageController = TextEditingController();
      heightController = TextEditingController();
      weightController = TextEditingController();
      weightGoalController = TextEditingController();
    });
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  myValidator(value, element) {
    if (value == null || value.isEmpty) {
      return 'Lütfen ${element} giriniz.';
    }
    if (int.parse(value) <= 0 || int.parse(value) >= 999) {
      return "Lütfen geçerli ${element} değeri giriniz.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: 20,
            bottom: 20,
            right: 20,
            top: 50,
          ),
          child: Center(
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('Resim Url Giriniz'),
                                  content: TextFormField(
                                    controller: myController,
                                    cursorColor:
                                    Theme.of(context).cursorColor,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                      textColor: Color(0xFF6200EE),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('KAPAT'),
                                    ),
                                    FlatButton(
                                      textColor: Color(0xFF6200EE),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          imageUrl =
                                              myController.text;
                                        });
                                      },
                                      child: Text('KAYDET'),
                                    ),
                                  ],
                                ));
                          },
                          padding: EdgeInsets.all(0.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(myController.text),
                            backgroundColor: Colors.black12,
                            radius: 50,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    TextFormField(
                      controller: nameController,
                      cursorColor: Theme.of(context).cursorColor,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Kullanıcı Adı',
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        controller: chatCodeController,
                        cursorColor: Theme.of(context).cursorColor,
                        obscureText: _isHide,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Giriş Kodunu Değiştir',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isHide ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isHide = !_isHide;
                              });
                            },
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen giriş kodu giriniz.';
                          }
                          if (value.length >= 10 || value.length <= 4) {
                            return "Lütfen 4 - 10 haneli giriş kodu giriniz.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextFormField(
                                controller: ageController,
                                cursorColor: Theme.of(context).cursorColor,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Yaş',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  return myValidator(value, "Yaş");
                                }),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Flexible(
                            child: TextFormField(
                                controller: heightController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Boy',
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  return myValidator(value, "Boy");
                                }),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: weightController,
                              cursorColor: Theme.of(context).cursorColor,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Kilo',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                return myValidator(value, "Kilo");
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: weightGoalController,
                              cursorColor: Theme.of(context).cursorColor,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Hedef Kilo',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                return myValidator(value, "Hedef Kilo");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        height: 50,
                        margin: EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            var tempSelected = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Diets(toChoose: true,);
                                },
                              ),
                            );
                            if(tempSelected != null){
                              selectedDietPlan = tempSelected;
                            }
                            },
                          child: Text('DİYET PLANLAMA'),
                        )),
                    Container(
                        width: double.infinity,
                        height: 50,
                        margin: EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              // widget.user["chatCode"] = chatCodeController.text;
                              // widget.user["weight"] = weightController.text;
                              // widget.user["height"] = heightController.text;
                              // widget.user["weightGoal"] = weightGoalController.text;
                              // widget.user["age"] = ageController.text;
                              DatabaseMethods db = new DatabaseMethods();
                              db.addUser({
                                'age': ageController.text,
                                'weightGoal': weightGoalController.text,
                                'height': heightController.text,
                                'weight': weightController.text,
                                'chatCode': chatCodeController.text,
                                'mealListCode': selectedDietPlan.isEmpty ? '1' : selectedDietPlan,
                                'photoLink': myController.text,
                                'name': nameController.text,
                                'weightArray': [{'day': DateTime.now(), 'weight': weightController.text}]
                              }, chatCodeController.text);
                            }
                            else{
                              print("Hata!");
                            }
                          },
                          child: Text('EKLE'),
                        )),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
