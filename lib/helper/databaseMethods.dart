import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseMethods {

  getChats(String chatRoomId) async {
    return Firestore.instance
        .collection(chatRoomId)
        .orderBy('time')
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, chatMessageData) {
    Firestore.instance
        .collection(chatRoomId)
        .add(chatMessageData).catchError((e) {
      print(e.toString());
    });
  }

  getMealList(String mealCode) async {
    return Firestore.instance
        .collection("mealLists")
        .document(mealCode)
        .collection("meals")
        .snapshots();
  }

  getUserList() async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection("users").getDocuments();
    var data = querySnapshot.docs.map((doc) => doc.data()).toList();
    return data;
  }

/*
  *     YEMEK LİSTESİ ALMA
  *
  * child: StreamBuilder(
              stream: meals,
              builder: (context, snapshot) {
                return snapshot.hasData ?
                ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return Text(snapshot.data.documents[index].get('mealName') + snapshot.data.documents[index].get('mealHour') );
                    })
                    : Container();
              }
            ),
  *
  *
  * */

}