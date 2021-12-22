import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet/helper/Helper.dart';
import 'package:diyet/views/profileScreenDesign.dart';
import 'package:flutter/material.dart';

class ProfileDetailScreen extends StatefulWidget {
  Map<String, dynamic> userMap = new Map();
  ProfileDetailScreen(this.userMap);
  @override
  _ProfileDetailScreenState createState() => _ProfileDetailScreenState(userMap);
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> { // TODO Tasarım düzelt, kilo girdisi al.
  Map<String, dynamic> userMap = new Map();
  _ProfileDetailScreenState(this.userMap);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 150,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                      userMap['photoLink'],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text("50/100"),
                trailing: BarProgress(
                  name: "Protein",
                  color: Colors.blue,
                  progress: 0.5,
                  width: 500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text("30/100"),
                trailing: BarProgress(
                  name: "Karbonhidrat",
                  color: primaryColorLight,
                  progress: 0.3,
                  width: 500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text("60/100"),
                trailing: BarProgress(
                  name: "Yağ",
                  color: Colors.red,
                  progress: 0.6,
                  width: 500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ]),
          ),
        ],
      ),

      //Container(
      //child: Column(
      //children: [
      //  Center(
      //    child: CircleAvatar(
      //      radius: 100,
      //      backgroundColor: Colors.transparent,
      //      backgroundImage: NetworkImage(
      //        userMap['photoLink'],
      //      ),
      //    ),
      //  ),
      //  SizedBox(
      //    height: 20,
      //  ),
      //  RadialProgress(100, 100, 0.5),
      //  SizedBox(
      //    height: 20,
      //  ),
      //  ListTile(
      //    title: Text("50/100"),
      //    trailing: BarProgress(
      //      name: "Protein",
      //      color: Colors.blue,
      //      progress: 0.5,
      //      width: 500,
      //    ),
      //  ),
      //  SizedBox(height: 10,),
      //  ListTile(
      //    title: Text("30/100"),
      //    trailing: BarProgress(
      //      name: "Karbonhidrat",
      //      color: Colors.greenAccent,
      //      progress: 0.3,
      //      width: 500,
      //    ),
      //  ),
      //  SizedBox(
      //    height: 10,
      //  ),
      //  ListTile(
      //    title: Text("60/100"),
      //    trailing: BarProgress(
      //      name: "Yağ",
      //      color: Colors.red,
      //      progress: 0.6,
      //      width: 500,
      //    ),
      //  ),
      //  SizedBox(
      //    height: 10,
      //  ),
      //],
      //),
      //)
    );
  }
}
