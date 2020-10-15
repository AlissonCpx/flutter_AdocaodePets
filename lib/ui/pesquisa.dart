import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trabalhoprofessor/ui/detalhes.dart';

class Pesquisa extends StatefulWidget {
  @override
  _PesquisaState createState() => _PesquisaState();
}

class _PesquisaState extends State<Pesquisa> {
  String pesq = "nome";
  String pesqText = "um Nome";
  TextEditingController valorPesq = TextEditingController();
  bool loadingList = false;

  List<DocumentSnapshot> documentsPesq = [];

  //Metodos
  void pesquisaAll() async {
    setState(() {
      loadingList = true;
    });
    List<DocumentSnapshot> documentList;
    documentList = (await Firestore.instance
            .collection("pet")
            .where(pesq, isEqualTo: valorPesq.text)
            .getDocuments())
        .documents;

    setState(() {
      documentsPesq.clear();
      documentsPesq = documentList;
      loadingList = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lime,
          title: Text("Pesquisa"),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  controller: valorPesq,
                  decoration: InputDecoration(
                    labelText: "Pesquise por " + pesqText,
                    prefixIcon: Icon(Icons.search),
                  ),
                )),
                IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      pesquisaAll();
                    })
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                        child: RaisedButton(
                  color: pesq != "nome" ? Colors.amber : Colors.limeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () {
                    setState(() {
                      pesq = "nome";
                      pesqText = "um Nome";
                    });
                  },
                  child: Text("Nome"),
                ))),
                Expanded(
                    child: Container(
                        child: RaisedButton(
                  color: pesq != "raca" ? Colors.amber : Colors.limeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () {
                    setState(() {
                      pesq = "raca";
                      pesqText = "uma Raça";
                    });
                  },
                  child: Text("Raça"),
                ))),
                Expanded(
                    child: Container(
                        child: RaisedButton(
                  color: pesq != "idade" ? Colors.amber : Colors.limeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () {
                    setState(() {
                      pesq = "idade";
                      pesqText = "uma Idade";
                    });
                  },
                  child: Text("Idade"),
                ))),
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemCount: documentsPesq.length,
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
                              documentsPesq[index]["imgUrl"],
                              width: 150,
                              height: 150,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  'Nome: ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  'Raça: ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  'Idade: ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    documentsPesq[index]["nome"],
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    documentsPesq[index]["raca"],
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    documentsPesq[index]["idade"],
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
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
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Detalhes(documentsPesq[index])));
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
            ))
          ],
        ));
  }
}
