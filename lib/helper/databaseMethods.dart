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

  addMealList(mealListCode, mealListData) async {
    mealListCode = "3";
    var sample_meal_list_data = {
      "dontEats": ["Herşey serbest"],
      "freeToEats": ["Herşey serbest"],
      "mealListCode": mealListCode,
      "weekImageUrl":
          "https://i.nefisyemektarifleri.com/2016/10/12/gobek-eriten-ve-kabizlik-gideren-yogurt-kuru-bilgi-ve-resimli.jpg",
      "weekText": "Yoğurtlu Kür",
      "weekUrl":
          "https://www.nefisyemektarifleri.com/gobek-eriten-ve-kabizlik-gideren-yogurt-kuru-bilgi-ve-resimli/",
      "mealNumbers": {
        "1": {
          "1. Ara": ["11:00", "13", "13", "13", "13", "13"],
          "Kahvaltı": ["11:00", "13", "13", "13", "13", "13"],
          "Öğlen Yemeği": ["11:00", "13", "13", "13", "13", "13"],
          "Akşam Yemeği": ["11:00", "13", "13", "13", "13", "13"],
          "Gece Yemeği": ["11:00", "13", "13", "13", "13", "13"],
        },
        "2": {
          "1. Ara": ["11:00", "13", "13", "13", "13", "13"],
          "Kahvaltı": ["11:00", "13", "13", "13", "13", "13"],
          "Öğlen Yemeği": ["11:00", "13", "13", "13", "13", "13"],
          "Akşam Yemeği": ["11:00", "13", "13", "13", "13", "13"],
          "Gece Yemeği": ["11:00", "13", "13", "13", "13", "13"],
        },
        "3": {
          "1. Ara": ["11:00", "13", "13", "13", "13", "13"],
          "Kahvaltı": ["11:00", "13", "13", "13", "13", "13"],
          "Öğlen Yemeği": ["11:00", "13", "13", "13", "13", "13"],
          "Akşam Yemeği": ["11:00", "13", "13", "13", "13", "13"],
          "Gece Yemeği": ["11:00", "13", "13", "13", "13", "13"],
        },
        "4": {
          "1. Ara": ["11:00", "13", "13", "13", "13", "13"],
          "Kahvaltı": ["11:00", "13", "13", "13", "13", "13"],
          "Öğlen Yemeği": ["11:00", "13", "13", "13", "13", "13"],
          "Akşam Yemeği": ["11:00", "13", "13", "13", "13", "13"],
          "Gece Yemeği": ["11:00", "13", "13", "13", "13", "13"],
        },
        "5": {
          "1. Ara": ["11:00", "13", "13", "13", "13", "13"],
          "Kahvaltı": ["11:00", "13", "13", "13", "13", "13"],
          "Öğlen Yemeği": ["11:00", "13", "13", "13", "13", "13"],
          "Akşam Yemeği": ["11:00", "13", "13", "13", "13", "13"],
          "Gece Yemeği": ["11:00", "13", "13", "13", "13", "13"],
        },
        "6": {
          "1. Ara": ["11:00", "13", "13", "13", "13", "13"],
          "Kahvaltı": ["11:00", "13", "13", "13", "13", "13"],
          "Öğlen Yemeği": ["11:00", "13", "13", "13", "13", "13"],
          "Akşam Yemeği": ["11:00", "13", "13", "13", "13", "13"],
          "Gece Yemeği": ["11:00", "13", "13", "13", "13", "13"],
        },
        "7": {
          "1. Ara": ["11:00", "13", "13", "13", "13", "13"],
          "Kahvaltı": ["11:00", "13", "13", "13", "13", "13"],
          "Öğlen Yemeği": ["11:00", "13", "13", "13", "13", "13"],
          "Akşam Yemeği": ["11:00", "13", "13", "13", "13", "13"],
          "Gece Yemeği": ["11:00", "13", "13", "13", "13", "13"],
        }
      }
    };
    final snapShot = await FirebaseFirestore.instance
        .collection("mealLists")
        .doc(mealListCode)
        .get();

    if (snapShot == null || !snapShot.exists) {
      await FirebaseFirestore.instance
          .collection("mealLists")
          .doc(mealListCode)
          .set(sample_meal_list_data);
    } else {
      return false;
    }
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
