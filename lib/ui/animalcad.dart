import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trabalhoprofessor/classes/util.dart';

class AnimalCad extends StatefulWidget {
  @override
  _AnimalCadState createState() => _AnimalCadState();
}

class _AnimalCadState extends State<AnimalCad> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  FirebaseUser currentUser;

  //Variaveis
  int porteCachorro = 1;
  bool vacinado = false;
  File imagem;
  bool loading = false;
  TextEditingController nome = TextEditingController();
  TextEditingController raca = TextEditingController();
  TextEditingController idade = TextEditingController();

  // notas

  double docil = 1.0;
  double companheiro = 1.0;
  double brincalhao = 1.0;
  double inteligente = 1.0;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      setState(() {
        currentUser = user;
      });
    });
  } //Metodos

  void cadastroPet() async {
    setState(() {
      loading = true;
    });
    final FirebaseUser user = await Util().getUser();

    if (user == null) {
      scaffoldkey.currentState.showSnackBar(SnackBar(
        content: Text("Não foi possivel efetuar o login. Tente novamente!"),
        backgroundColor: Colors.red,
      ));
    }

    Map<String, dynamic> data = {
      "user": user.uid,
      "senderName": user.displayName,
      "userPhotoUrl": user.photoUrl,
      'time': Timestamp.now(),
      'nome': nome.text,
      'raca': raca.text,
      'idade': idade.text,
      'vacinado': vacinado,
      'porte': porteCachorro,
      'docil': docil,
      'companheiro': companheiro,
      'brincalhao': brincalhao,
      'inteligente': inteligente
    };

    if (imagem != null) {
      StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(imagem);

      StorageTaskSnapshot taskSnapshot = await task.onComplete;
      String url = await taskSnapshot.ref.getDownloadURL();
      data['imgUrl'] = url;
    }
    Firestore.instance.collection("pet").add(data);
    setState(() {
      loading = false;
    });
    scaffoldkey.currentState.showSnackBar(SnackBar(
      content: Text("Cadastro Efetuado com Sucesso!"),
      duration: Duration(seconds: 3),
      onVisible: () {
        Future.delayed(Duration(seconds: 3)).then((value) {
          Navigator.pop(context);
        });
      },
      backgroundColor: Colors.amber,
    ));
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
                                  icon: Icon(Icons.camera_alt),
                                  onPressed: () async {
                                    final File imgFile =
                                        await ImagePicker.pickImage(
                                            source: ImageSource.camera);
                                    if (imgFile != null) {
                                      setState(() {
                                        imagem = imgFile;
                                      });
                                    }
                                  }),
                              Text("Camera")
                            ],
                          )),
                          Expanded(
                              child: Column(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.photo),
                                  onPressed: () async {
                                    final File imgFile =
                                        await ImagePicker.pickImage(
                                            source: ImageSource.gallery);
                                    if (imgFile != null) {
                                      setState(() {
                                        imagem = imgFile;
                                      });
                                    }
                                  }),
                              Text("Galeria")
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
                                    autofocus: false,
                                    controller: nome,
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
                                    controller: raca,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                        labelText: "Raça",
                                        labelStyle:
                                            TextStyle(color: Colors.green)),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 18.0),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Insira a raça do Pet";
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    controller: idade,
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
                                  padding: EdgeInsets.all(30.0),
                                  child: Text(
                                    "Insira uma foto:",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                imagem != null
                                    ? Image.file(
                                        imagem,
                                        width: 250,
                                        height: 250,
                                      )
                                    : GestureDetector(
                                        onTap: () async {
                                          showOptions(context);
                                        },
                                        child: Container(
                                          width: 150.0,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  offset: Offset(1.0, 6.0),
                                                  blurRadius: 75.0,
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: Column(
                                            children: <Widget>[
                                              Icon(
                                                Icons.camera_alt,
                                                size: 30,
                                              ),
                                              Text("Escolha uma foto")
                                            ],
                                          ),
                                        ),
                                      ),
                                Padding(
                                  padding: EdgeInsets.only(top: 40),
                                  child: loading
                                      ? CircularProgressIndicator()
                                      : RaisedButton(
                                          onPressed: () {
                                            if (formkey.currentState
                                                .validate()) {
                                              cadastroPet();
                                            }
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
