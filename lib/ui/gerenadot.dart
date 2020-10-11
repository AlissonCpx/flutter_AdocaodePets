import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Gerenciador extends StatefulWidget {
  final String userId;

  Gerenciador(this.userId);

  @override
  _GerenciadorState createState() => _GerenciadorState();
}

class _GerenciadorState extends State<Gerenciador> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Cadastros de Adoções"),
        centerTitle: true,
        backgroundColor: Colors.lime,
      ),
      body: Container(
        color: Colors.lightGreenAccent,
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('pet')
            .where("user", isEqualTo: widget.userId)
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
                  List<DocumentSnapshot> meusDocuments =
                      snapshot.data.documents.toList();
                  return ListView.builder(
                    itemCount: meusDocuments.length,
                    reverse: false,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                          background: Container(
                            color: Colors.red,
                            child: Align(
                              alignment: Alignment(-0.9, 0.0),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                          direction: DismissDirection.startToEnd,
                          child: ListTile(
                            trailing: IconButton(icon: Icon(Icons.chat), onPressed: () {
                            }),
                            subtitle: Text(meusDocuments[index]["raca"]),
                            title: Text(meusDocuments[index]["nome"] ,
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(meusDocuments[index]["imgUrl"]),
                            ),
                          ),
                        onDismissed: (direction) async {
                            int ultimoIndex = index;

                            DocumentSnapshot ultimoReg = meusDocuments[ultimoIndex];

                            CollectionReference pet = await Firestore.instance.collection('pet');
                           await pet.document(meusDocuments[ultimoIndex].documentID).delete();
                          setState(() {
                            meusDocuments.removeAt(index);
                          });

                            final snack = SnackBar(
                              content: Text("Pet \"${ultimoReg["nome"]}\" removido"),
                              action: SnackBarAction(
                                  label: "Desfazer",
                                  onPressed: () {
                                    setState(() {
                                      meusDocuments.insert(ultimoIndex, ultimoReg);
                                    });
                                    Map<String, dynamic> data = {
                                      "user": ultimoReg["user"],
                                      "senderName": ultimoReg["senderName"],
                                      "userPhotoUrl": ultimoReg["userPhotoUrl"],
                                      'time': ultimoReg["time"],
                                      'nome': ultimoReg["nome"],
                                      'raca': ultimoReg["raca"],
                                      'idade': ultimoReg["idade"],
                                      'vacinado': ultimoReg["vacinado"],
                                      'porte': ultimoReg["porte"],
                                      'docil': ultimoReg["docil"],
                                      'companheiro': ultimoReg["companheiro"],
                                      'brincalhao': ultimoReg["brincalhao"],
                                      'inteligente': ultimoReg["inteligente"],
                                      'telefone': ultimoReg["telefone"],
                                      'imgUrl': ultimoReg["imgUrl"]
                                    };
                                    Firestore.instance.collection("pet").add(data);
                                  }),
                              duration: Duration(seconds: 3),
                            );

                            Scaffold.of(context).removeCurrentSnackBar();
                            Scaffold.of(context).showSnackBar(snack);
                        },

                      );
                    },
                  );
              }
            }),
      ),
    );
  }
}
