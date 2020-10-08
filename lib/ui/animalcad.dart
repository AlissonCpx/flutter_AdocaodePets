import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AnimalCad extends StatefulWidget {
  @override
  _AnimalCadState createState() => _AnimalCadState();
}

class _AnimalCadState extends State<AnimalCad> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  int porteCachorro = 1;
  bool vacinado = false;

  // notas

  double docil = 1.0;
  double companheiro = 1.0;
  double brincalhao = 1.0;
  double inteligente = 1.0;




  //Metodos




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Adoção"),
        centerTitle: true,
        backgroundColor: Colors.lime,
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 165.0),
                  color: Colors.lightGreenAccent,
                  height: 438,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Form(
                            key: formkey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "Nome do Pet",
                                        labelStyle:
                                            TextStyle(color: Colors.green)),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 18.0),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Insira o nome do Pet";
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: "Idade do Pet",
                                        labelStyle:
                                            TextStyle(color: Colors.green)),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 18.0),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Insira a idade do seu pet";
                                      }
                                    },
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 7.0, left: 10.0),
                                      child: Text(
                                        "Porte do Pet: ",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.green,
                                            border: Border.all()),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: DropdownButton(
                                              dropdownColor: Colors.green,
                                              iconSize: 30,
                                              value: porteCachorro,
                                              items: [
                                                DropdownMenuItem(
                                                  child: Text(
                                                    "Pequeno",
                                                  ),
                                                  value: 1,
                                                ),
                                                DropdownMenuItem(
                                                  child: Text("Medio"),
                                                  value: 2,
                                                ),
                                                DropdownMenuItem(
                                                    child: Text("Grande"),
                                                    value: 3),
                                              ],
                                              onChanged: (value) {
                                                setState(() {
                                                  porteCachorro = value;
                                                });
                                              }),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 7.0, left: 40.0),
                                      child: Text(
                                        "Vacinado: ",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    Checkbox(
                                      value: vacinado,
                                      activeColor: Colors.green,
                                      onChanged: (value) {
                                        setState(() {
                                          vacinado = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 40.0, right: 40.0, top: 30.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Dócil",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(
                                          color: Colors.black,
                                        ),
                                      ],
                                    )),
                                RatingBar(
                                  initialRating: docil,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      docil = rating;
                                    });
                                  },
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 40.0, right: 40.0, top: 30.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Companheiro",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(
                                          color: Colors.black,
                                        ),
                                      ],
                                    )),
                                RatingBar(
                                  initialRating: companheiro,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      companheiro = rating;
                                    });
                                  },
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 40.0, right: 40.0, top: 30.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Brincalhão",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(
                                          color: Colors.black,
                                        ),
                                      ],
                                    )),
                                RatingBar(
                                  initialRating: brincalhao,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      brincalhao = rating;
                                    });
                                  },
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 40.0, right: 40.0, top: 30.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Inteligente",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(
                                          color: Colors.black,
                                        ),
                                      ],
                                    )),
                                RatingBar(
                                  initialRating: inteligente,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 0.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      inteligente = rating;
                                    });
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 40),
                                  child: RaisedButton(
                                    onPressed: () {
                                      if (formkey.currentState.validate()) {}
                                    },
                                    child: Text("Cadastrar"),
                                    color: Colors.green,
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  )),
              Positioned(
                bottom: 425,
                left: 100,
                child: Image.asset(
                  "assets/catanddog.png",
                  width: 200,
                  height: 200,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
