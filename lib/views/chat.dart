import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diyet/views/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:diyet/helper/databaseMethods.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

class chatPage extends StatefulWidget {
  String chatPath;
  chatPage(this.chatPath);

  @override
  _chatPageState createState() => _chatPageState(chatPath);
}

class _chatPageState extends State<chatPage> {
  @override
  void initState() {
    DatabaseMethods().getChats(chatPath).then((val) {
      setState(() {
        chats = val;
      });
    });
    Timer(
        Duration(milliseconds: 200),
        scrollToBottom
    );
    super.initState();
  }

  scrollToBottom() {
    if (sc.hasClients)
      sc.animateTo(
        sc.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 500),
      );
    else
      print("Scroll Controller has not attached!");
  }

  DatabaseMethods db = new DatabaseMethods();

  ScrollController sc = new ScrollController();

  String chatPath;
  TextEditingController cont = new TextEditingController();

  Stream<QuerySnapshot> chats;

  _chatPageState(this.chatPath);

  Widget chatMessages() {

    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {

        return snapshot.hasData
            ? ListView.builder(
                controller: sc,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data.documents[index].get('message'),
                    sendByMe: !snapshot.data.documents[index].get('admin'),
                  );
                })
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: 70,
                ),
                child: chatMessages(),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Color(0x54FFFFFF),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cont,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              hintText: "Mesaj Yaz",
                              hintStyle: TextStyle(color: Colors.black38),
                              border: InputBorder.none),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          addMessage();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF),
                            ]),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.send),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addMessage() {
    if (cont.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": cont.text,
        'time': DateTime.now().millisecondsSinceEpoch,
        'admin': false,
      };

      DatabaseMethods().addMessage(chatPath, chatMessageMap);

      cont.clear();
    }
    scrollToBottom();
  }
}

giveMeHour() {
  DateTime now = DateTime.now();
  return now.year.toString() +
      twoChars(now.month.toString()) +
      twoChars(now.day.toString()) +
      twoChars(now.hour.toString()) +
      twoChars(now.minute.toString()) +
      twoChars(now.second.toString());
}

twoChars(String a) {
  if (a.length == 1) {
    return '0' + a;
  } else
    return a;
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: sendByMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23))
              : BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23)),
          gradient: LinearGradient(
            colors: sendByMe
                ? [const Color(0xFF5B4D9D), const Color(0xFF5B4D95)]
                : [const Color(0xff2A75BC), const Color(0xff007EF4)],
          ),
        ),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
