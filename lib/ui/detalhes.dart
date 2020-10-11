import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class Detalhes extends StatefulWidget {
  final DocumentSnapshot document;

  Detalhes(this.document);

  @override
  _DetalhesState createState() => _DetalhesState();
}

class _DetalhesState extends State<Detalhes> {
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  String porte;

  @override
  void initState() {
    super.initState();

    if (widget.document['porte'] == 1) {
      setState(() {
        porte = 'Pequeno';
      });
    } else if (widget.document['porte'] == 2) {
      setState(() {
        porte = 'Medio';
      });
    } else {
      setState(() {
        porte = 'Grande';
      });
    }
  }

  void showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Column(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.chat),
                                  onPressed: () async {}),
                              Text("Chat")
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.phone),
                                  onPressed: (){
                                    launch("tel:${widget.document['telefone']}");
                                  }),
                              Text("Telefone")
                            ],
                          ))
                        ],
                      )
                    ],
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text(widget.document['nome']),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.zero,
            child: Center(
              child: Image.network(
                widget.document['imgUrl'],
                alignment: Alignment.center,
                width: 410,
                height: 305,
              ),
            ),
          ),
          Container(
            height: 298,
            color: Colors.limeAccent,
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    "Detalhes",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Expanded(
                          child: Text(
                        "Raça: " + widget.document['raca'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50.0),
                      child: Expanded(
                          child: Text(
                        "Idade: " + widget.document['idade'] + " Anos",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Expanded(
                          child: Text(
                        "Vacinado: " +
                            (widget.document['vacinado'] ? "Sim" : "Não"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50.0),
                      child: Expanded(
                          child: Text(
                        "Porte: " + porte,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      )),
                    )
                  ],
                ),
                Divider(
                  color: Colors.black,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Docil",
                            style: TextStyle(fontSize: 18),
                          ),
                          RatingBar(
                            initialRating: widget.document['docil'],
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 30,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: <Widget>[
                        Text(
                          "Brincalhao",
                          style: TextStyle(fontSize: 18),
                        ),
                        RatingBar(
                          initialRating: widget.document['brincalhao'],
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 30,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Inteligente",
                            style: TextStyle(fontSize: 18),
                          ),
                          RatingBar(
                            initialRating: widget.document['inteligente'],
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 30,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: <Widget>[
                        Text(
                          "Companheiro",
                          style: TextStyle(fontSize: 18),
                        ),
                        RatingBar(
                          initialRating: widget.document['companheiro'],
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 30,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: RaisedButton(
                    onPressed: () {
                      showOptions(context);
                    },
                    child: Text("Entrar em contato"),
                    color: Colors.amber,
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
