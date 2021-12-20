import 'package:cloud_firestore/cloud_firestore.dart';

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
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  changeDiet(userCode, mealCode) async {
    final snapShot = await FirebaseFirestore.instance.collection('users').where('chatCode', isEqualTo: userCode)
        .get();
    var data = snapShot.docs.map((doc) => doc.data()).toList();
    if (data.isNotEmpty){
      data[0]['mealListCode'] = mealCode;
    }
    print(data);
    await addUser(data[0], userCode);
  }

  Future<void> addUser(userData, userCode) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userCode)
        .set(userData);
  }

  addMealList(mealListData) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("mealLists")
        .doc(mealListData['mealListCode'])
        .get();

    if (snapShot == null || !snapShot.exists) {
      await FirebaseFirestore.instance
          .collection("mealLists")
          .doc(mealListData['mealListCode'])
          .set(mealListData);
    } else {
      return false;
    }
  }

  getUserList() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("users").getDocuments();
    var data = querySnapshot.docs.map((doc) => doc.data()).toList();
    return data;
  }

  getMealList() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("meals").getDocuments();
    var data = querySnapshot.docs.map((doc) => doc.data()).toList();
    return data;
  }

  getDietsList() async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection("mealLists").getDocuments();
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
