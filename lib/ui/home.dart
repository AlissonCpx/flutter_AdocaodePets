import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trabalhoprofessor/ui/drawer.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
        centerTitle: true,
        title: Text("Adote um Amigo"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      drawer: DrawerPet(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 165.0),
                  color: Colors.lightGreenAccent,
                  height: 438,
                ),
                Positioned(
                  child: Image.asset(
                    "assets/dogs.png",
                  ),

                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
