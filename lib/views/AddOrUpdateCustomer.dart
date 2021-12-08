import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
import '../helper/Helper.dart';

class AddOrUpdateCustomer extends StatefulWidget {
  @override
  _AddOrUpdateCustomer createState() => _AddOrUpdateCustomer();
}

class _AddOrUpdateCustomer extends State<AddOrUpdateCustomer> {

  File image;

 // _takeImage() async{
//    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
//    this.setState(() {
 //     image = picture;
 //   });
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Müşteri Ekle'),
        backgroundColor: themaColor,
      ),
      body: Container(
        margin: EdgeInsets.all(
          20,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
          FlatButton(
          onPressed: null,
              padding: EdgeInsets.all(0.0),
              child: const CircleAvatar(
                child:Icon(Icons.account_circle_outlined, size: 100),
                radius: 50,
              ),),
                ],
              ),
              TextFormField(
                cursorColor: Theme.of(context).cursorColor,
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle_outlined),
                  labelText: 'Ad',
                ),
              ),
              TextFormField(
                cursorColor: Theme.of(context).cursorColor,
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle_outlined),
                  labelText: 'Soyad',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Boy",
                  icon: Icon(Icons.account_circle_outlined),
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Kilo",
                  icon: Icon(Icons.account_circle_outlined),
                ),
                keyboardType: TextInputType.number,
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Respond to button press
                  },
                  child: Text('EKLE'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
