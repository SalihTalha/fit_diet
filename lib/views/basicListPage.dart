import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicList extends StatelessWidget {
  String top;
  List<dynamic> list;

  BasicList(this.top, this.list);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20,),
            Center(
              child: Text(
                top,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 10,),
            for (int i = 0; i < list.length; i++)
              Column(
                children: [
                  SizedBox(height: 4,),
                  Center(
                    child: Text(
                      list[i],
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
