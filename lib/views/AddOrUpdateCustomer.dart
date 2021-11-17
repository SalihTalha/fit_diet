import 'package:flutter/material.dart';

class AddOrUpdateCustomer extends StatefulWidget {
  @override
  _AddOrUpdateCustomer createState() => _AddOrUpdateCustomer();
}

class _AddOrUpdateCustomer extends State<AddOrUpdateCustomer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        20,
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                ),
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
                child: Text('ADD'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

