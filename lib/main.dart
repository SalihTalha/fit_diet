import 'package:diyet/views/Customers.dart';
import 'package:diyet/views/chatCodePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:diyet/views/AdminPages/mainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diyet',
      home: HomeS(),
    );
  }
}

class HomeS extends StatefulWidget {
  @override
  _HomeSState createState() => _HomeSState();
}

class _HomeSState extends State<HomeS> {

  //Future<void> chatRef = FirebaseDatabase.instance.reference().child('mesajlar').child("12345").orderByKey().once().then((DataSnapshot snapshot) {
  //  print(snapshot.value);
  //  print(snapshot.value['202010060724']);
  //});

  @override
  Widget build(BuildContext context) {
    return Customers();
  }
}
