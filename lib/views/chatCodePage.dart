import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet/views/tabPage.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 5),child:Text("Loading" )),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}

class ChatCodePage extends StatefulWidget {


  @override
  _ChatCodePageState createState() => _ChatCodePageState();
}

class _ChatCodePageState extends State<ChatCodePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController code = new TextEditingController();

  final databaseReference = FirebaseFirestore.instance.collection('users');
  bool error = false;

  @override
  Widget build(BuildContext context) { // TODO: Sayfa tasarımını düzelt. Yanlış kod girilirseyi düzelt.


    return Scaffold(
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
            key: _formKey,
                    child: TextFormField(
                      controller: code,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          labelText: 'Kodunuzu Girin',
                        errorText: error ? "Geçersiz!" : null,
                        alignLabelWithHint: true,
                      ),
                      validator: (value){
                        if(value.isEmpty) return "Lütfen kodunuzu giriniz";
                        return null;
                      },
                    )
                ),
                SizedBox(height: 8.0,),
                RaisedButton(
                  onPressed: () {
                    if(code.text.isNotEmpty) {
                      List<Map<String, dynamic>> listOfMealsInMealList = new List();
                      Map<String, dynamic> userMap = new Map();
                      Map<String, dynamic> mealListMap = new Map();
                      showAlertDialog(context);
                      databaseReference.where('chatCode', isEqualTo: code.text).get().then((value) {
                        if(value.docs.isNotEmpty){
                          if(value.docs.length != 1) {
                            Navigator.pop(context); // TODO ADMIN HATA YAPTIĞI DURUM. AYNI CHAT CODE 1 KİŞİDEN FAZLASINA VERİLMİŞ
                          }
                          value.docs.forEach( (element) {
                            userMap.addAll(element.data());
                          });
                          //print(userMap);
                          FirebaseFirestore.instance.collection('mealLists').where('mealListCode', isEqualTo: userMap['mealListCode']).get().then((value) {
                            value.docs.forEach((element) {
                              mealListMap.addAll(element.data());
                              List list = []; // Bu list tüm yiyecek kodlarını barındırır. (1 yiyecek için olan mealCode)
                              mealListMap['mealNumbers'].forEach((key, value) {value.forEach((key, value){ for(var i = 1; i < value.length; i++) if(!list.contains(value[i])) list.add(value[i]); }); });
                              //print(mealListMap); // TODO Arama yapılan liste en fazla 10 eleman olabiliyor. O yüzden her gün için farklı arama yapıp farklı bir map'de tutabiliriz.
                              //print(list);
                              FirebaseFirestore.instance.collection('meals').where('mealCode', whereIn: list).get().then((value) {
                                value.docs.forEach((element) {
                                  listOfMealsInMealList.add(element.data());
                                });
                                //print(listOfMealsInMealList);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                                  return tabPages(userMap, mealListMap, listOfMealsInMealList);
                                }));
                              });

                            });
                          });
                        }
                        else{
                          Navigator.pop(context);
                          setState(() {
                            error = true;
                          });
                        }
                      });
                    }
                    else{
                      setState(() {
                        error = true;
                      });
                    }
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.lightBlue,
                          Colors.blue
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child:
                    Text('Başla', style: TextStyle(fontSize: 20)),
                    )
                    ),
          ],
          )
          ),
              ),
            );
  }
}
