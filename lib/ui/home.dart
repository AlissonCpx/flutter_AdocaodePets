import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trabalhoprofessor/ui/animalcad.dart';
import 'package:trabalhoprofessor/ui/detalhes.dart';
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
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AnimalCad()));
        },
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
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection('pet')
                          .orderBy('time')
                          .snapshots(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          default:
                            List<DocumentSnapshot> documents =
                                snapshot.data.documents.toList();

                            return ListView.builder(
                              itemCount: documents.length,
                              reverse: false,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Colors.yellow,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(2.0),
                                            child: Image.network(
                                              documents[index]["imgUrl"],
                                              width: 150,
                                              height: 150,
                                            ),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 10.0),
                                                child: Text(
                                                  'Nome: ',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 10.0),
                                                child: Text(
                                                  'Raça: ',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 10.0),
                                                child: Text(
                                                  'Idade: ',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10.0),
                                                  child: Text(
                                                    documents[index]["nome"],
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10.0),
                                                  child: Text(
                                                    documents[index]["raca"],
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10.0),
                                                  child: Text(
                                                    documents[index]["idade"],
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: RaisedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context, MaterialPageRoute(builder: (context) => Detalhes(documents[index])));
                                                },
                                                color: Colors.amber,
                                                child: Text("Adotar"),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  borderOnForeground: true,
                                );
                              },
                            );
                        }
                      }),
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
