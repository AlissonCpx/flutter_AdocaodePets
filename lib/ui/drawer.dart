import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DrawerPet extends StatefulWidget {
  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<DrawerPet> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Variaveis
  String nameUser = "";

  String urlFotoUser;

  FirebaseUser currentUser;

  bool isloading = false;
  bool saindoLoading = false;

  // Metodos

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      setState(() {
        currentUser = user;
        nameUser = user.displayName;
        urlFotoUser = user.photoUrl;
      });
    });
  }

  Future<FirebaseUser> _getUser() async {
    if (currentUser != null) return currentUser;

    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final AuthResult authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final FirebaseUser user = authResult.user;

      return user;
    } catch (error) {
      return null;
    }
  }

  void fazLogin() async {
    setState(() {
      isloading = true;
    });

    final FirebaseUser user = await _getUser();

    if (user != null) {
      setState(() {
        isloading = false;
        urlFotoUser = user.photoUrl;
        nameUser = user.displayName;
      });
    }
  }

  Widget listaMenu(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.all(10.0),
          leading: Icon(
            Icons.star,
            color: Colors.black,
            size: 40,
          ),
          title: Text(
            "Favoritos",
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {},
          selected: true,
        ),
        ListTile(
          contentPadding: EdgeInsets.all(10.0),
          leading: Icon(
            Icons.home,
            color: Colors.black,
            size: 40,
          ),
          title: Text(
            "Home",
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {},
          selected: true,
        ),
        ListTile(
          contentPadding: EdgeInsets.all(10.0),
          leading: Icon(
            Icons.phone,
            size: 40,
            color: Colors.black,
          ),
          title: Text(
            "Contato",
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {},
          selected: true,
        ),
        Divider(
          color: Colors.black,
        ),
        ListTile(
          contentPadding: EdgeInsets.all(10.0),
          leading: Icon(
            Icons.exit_to_app,
            size: 40,
            color: urlFotoUser != null ? Colors.black : Colors.grey,
          ),
          title: Text(
            "Sair",
            style: TextStyle(
                color: urlFotoUser != null ? Colors.black : Colors.grey),
          ),
          onTap: () {
            FirebaseAuth.instance.signOut();
            googleSignIn.signOut();

            setState(() {
              saindoLoading = true;
              urlFotoUser = "";
              nameUser = "";
            });

            Future.delayed(Duration(seconds: 2)).then((value) {
              setState(() {
                saindoLoading = false;
              });
            });
          },
          enabled: urlFotoUser != null ? true : false,
        ),
      ],
    );
  }

  Widget trocaFoto() {
    if (urlFotoUser != null && urlFotoUser.isNotEmpty) {
      return Container(
          margin: EdgeInsets.zero,
          height: 140,
          width: 140,
          child: CircleAvatar(
            backgroundImage: NetworkImage(urlFotoUser),
          ));
    } else {
      return Container(
          margin: EdgeInsets.zero,
          height: 130,
          width: double.infinity,
          child: CircleAvatar(
            backgroundColor: Colors.amber,
            child: Icon(
              Icons.person,
              color: Colors.black,
              size: 100,
            ),
          ));
    }
  }

  Widget verifUser() {
    if (nameUser.isEmpty) {
      return Container(
        width: 200,
        child: RaisedButton(
          onPressed: fazLogin,
          color: Colors.amberAccent,
          child: Text("Faça Login"),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(10.0),
        child: Text(
          nameUser,
          style: TextStyle(fontSize: 18),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: saindoLoading
          ? LinearProgressIndicator(
              backgroundColor: Colors.amber,
            )
          : Container(
              color: Colors.yellow,
              child: DrawerHeader(
                decoration: BoxDecoration(),
                child: Column(
                  children: <Widget>[
                    trocaFoto(),
                    verifUser(),
                    isloading ? LinearProgressIndicator() : Container(),
                    listaMenu(context),
                  ],
                ),
              ),
            ),
    );
  }
}
