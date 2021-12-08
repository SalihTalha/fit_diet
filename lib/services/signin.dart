import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet/services/auth.dart';
import 'package:diyet/views/chatCodePage.dart';
import './signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diyet/widgets/widget.dart';
import 'package:flutter/rendering.dart';

class signIn extends StatefulWidget {
  final Function toggleView;
  signIn(this.toggleView);

  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {
  FirebaseAuth auth = FirebaseAuth.instance;

  String email = '';
  String password = '';

  signMeIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
    }

    Future user = await authMethods.signInWithEmailAndPassword(email, password);


    if(user != null){
      print(user); // TODO
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){ return ChatCodePage();}));
    }
    else setState(() {
      isLoading = false;
    });

    //Firestore.instance.collection(auth.currentUser.uid).add({
    //  "admin": true,
    //  "message": "Hoşgeldiniz",
    //  "time": FieldValue.serverTimestamp()
    //});
  }

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            child: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: mainAppBar("Diyet"),
            body: SingleChildScrollView(
              child: Container(
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
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          TextFormField(
                            onChanged: (value){
                              email = value;
                            },
                            decoration: textField("Mail Adresi"),
                          ),
                          TextFormField(
                            onChanged: (value){
                              password = value;
                            },
                            obscureText: true,
                            decoration: textField("Şifre"),
                          ),
                        ]),
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
                        onTap: signMeIn,
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.green[600], Colors.green[800]]),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Text(
                            "Giriş Yap",
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
                            "Hesap Oluştur",
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
            ),
          );
  }
}
