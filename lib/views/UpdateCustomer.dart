import 'dart:io';
import 'package:diyet/helper/databaseMethods.dart';
import 'package:diyet/views/DietPlanning.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import '../helper/Helper.dart';

class UpdateCustomer extends StatefulWidget {
  final user;

  const UpdateCustomer({this.user}) : super();

  @override
  _UpdateCustomer createState() => _UpdateCustomer();
}

class _UpdateCustomer extends State<UpdateCustomer> {
  TextEditingController myController;
  TextEditingController chatCodeController;
  TextEditingController ageController;
  TextEditingController heightController;
  TextEditingController weightController;
  TextEditingController weightGoalController;
  bool _isHide = true;
  final _formKey = GlobalKey<FormState>();
  var imageUrl = null;

  @override
  void initState() {
    setState(() {
      myController = TextEditingController(text: widget.user["photoLink"]);
      chatCodeController = TextEditingController(text: widget.user["chatCode"]);
      ageController = TextEditingController(text: widget.user["age"]);
      heightController = TextEditingController(text: widget.user["height"].toString());
      weightController = TextEditingController(text: widget.user["weight"].toString());
      weightGoalController = TextEditingController(text: widget.user["weightGoal"].toString());
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
                            backgroundImage: NetworkImage(widget.user["photoLink"]),
                            backgroundColor: Colors.transparent,
                            radius: 50,
                          ),
                        ),
                      ],
                    ),
                    Text(widget.user["name"]),
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
                            child: Container(),
                          ),
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
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        height: 50,
                        margin: EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DietPlanning();
                              },
                            ),
                          ),
                          child: Text('DİYET PLANLAMA'),
                        )),
                    Container(
                        width: double.infinity,
                        height: 50,
                        margin: EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              widget.user["chatCode"] = chatCodeController.text;
                              widget.user["weight"] = weightController.text;
                              widget.user["height"] = heightController.text;
                              widget.user["weightGoal"] = weightGoalController.text;
                              widget.user["age"] = ageController.text;
                            }
                          },
                          child: Text('GÜNCELLE'),
                        )),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
