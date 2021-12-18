import 'package:diyet/services/auth.dart';
import 'package:diyet/views/chatCodePage.dart';
import 'package:flutter/material.dart';
import 'package:diyet/widgets/widget.dart';

class signUp extends StatefulWidget {
  final Function toggleView;
  signUp(this.toggleView);

  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();

  signMeUp() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
    }

    Future user = await authMethods.signUpWithEmailAndPassword(email, password);

    print(user);

    if (user != null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return ChatCodePage();
      }));
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  final formKey = GlobalKey<FormState>();

  String username = '';
  String email = '';
  String password = '';
  String kg = '';
  String goal = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar("Diyet"),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              color: Colors.grey[800],
              height: MediaQuery.of(context).size.height - 50,
              alignment: Alignment.bottomCenter,
              child: Container(
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     begin: Alignment.topRight,
                //     end: Alignment.bottomLeft,
                //     stops: [0.1, 0.5, 0.7, 0.9],
                //     colors: [
                //     Colors.blue[400],
                //     Colors.blue[500],
                //     Colors.blue[700],
                //     Colors.blue[800],
                //     ],
                //   ),
                // ),
                padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                child: ListView(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              return val.isEmpty || val.length < 3
                                  ? "Lütfen isminizi giriniz"
                                  : null;
                            },
                            onChanged: (value) {
                              username = value;
                            },
                            decoration: textField("İsim"),
                          ),
                          TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)
                                  ? null
                                  : "Please provide a valid email address";
                            },
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: textField("Mail Adresi"),
                          ),
                          TextFormField(
                            obscureText: true,
                            onChanged: (value) {
                              email = value;
                            },
                            validator: (val) {
                              return val.length > 8
                                  ? null
                                  : "Lütfen 8 karakterden fazla şifre giriniz";
                            },
                            decoration: textField("Şifre"),
                          ),
                          TextFormField(
                            validator: (val) {
                              if (double.tryParse(val) != null ||
                                  int.tryParse(val) != null) {
                                return null;
                              }
                              return "Sayı Giriniz";
                            },
                            onChanged: (value) {
                              goal = value;
                            },
                            decoration: textField("Hedef Kilo"),
                          ),
                          TextFormField(
                            validator: (val) {
                              if (double.tryParse(val) != null ||
                                  int.tryParse(val) != null) {
                                return null;
                              }
                              return "Sayı Giriniz";
                            },
                            onChanged: (value) {
                              kg = value;
                            },
                            decoration: textField("Kilonuz"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          "Şifremi Unuttum!",
                          style: simpleTextStyle(),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: signMeUp,
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                            Colors.green[600],
                            Colors.green[800]
                          ]),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          "Kayıt Ol",
                          style: simpleTextStyle(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: widget.toggleView,
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          "Hesabım Var",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
