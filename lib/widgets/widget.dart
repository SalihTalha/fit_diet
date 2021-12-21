import 'package:diyet/helper/Helper.dart';
import 'package:flutter/material.dart';

InputDecoration textField(String hintText){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: secondaryColorDark,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  );
}

TextStyle simpleTextStyle(){
  return TextStyle(
    color: Colors.white,
  );
}

TextStyle nonSimpleTextStyle(){
  return TextStyle(
    color: Colors.white,
  );
}

AppBar mainAppBar(text){
  return AppBar(
    title: Text(text),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF3366FF),
              const Color(0xFF00CCFF),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    ),

  );
}