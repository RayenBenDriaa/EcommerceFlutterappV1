import 'dart:convert';

import 'package:flutter/material.dart';

import 'dart:math' as math;
import 'package:http/http.dart' as http;

class Edituser extends StatefulWidget {
  const Edituser({Key? key}) : super(key: key);

  @override
  State<Edituser> createState() => _EdituserState();
}

class _EdituserState extends State<Edituser> {
  late String? _nom;
  late String? _email;
  late String? _password;
  late String? _prenom;
  late String? _numtel;
  late String? _repeatPassword;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  final String _baseUrl = "10.0.2.2:4000";

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator PrincipalctaWidget - INSTANCE
    return Container(
      decoration: const BoxDecoration(

      ),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
              key: _keyForm,
              child: ListView(
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(15, 100, 15, 0),
                        child: Column(
                            children: [



                              Container(
                                  width: 72,
                                  height: 72,

                                  child: Stack(
                                      children: <Widget>[
                                        Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                                width: 72,
                                                height: 72,
                                                decoration: BoxDecoration(
                                                  borderRadius : BorderRadius.only(
                                                    topLeft: Radius.circular(16),
                                                    topRight: Radius.circular(16),
                                                    bottomLeft: Radius.circular(16),
                                                    bottomRight: Radius.circular(16),
                                                  ),
                                                  color : Color.fromRGBO(255, 128, 0, 1),
                                                )
                                            )
                                        ),Positioned(
                                            top: 20,
                                            left: 22,
                                            child: Container(
                                                width: 32,
                                                height: 31.999998092651367,
                                                decoration: const BoxDecoration(image: DecorationImage(
                                                  image: AssetImage('assets/images/vector40stroke.png'),

                                                                ),

                                                          )



                                            )
                                        ),
                                      ]
                                  )
                              ),


                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 35, 10, 10),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Email",
                                    fillColor: Colors.white,
                                  ),
                                  onSaved: (String? value) {
                                    _email = value;
                                  },
                                  validator: (String? value) {
                                    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                                    if(value == null || value.isEmpty) {
                                      return "L'adresse email ne doit pas etre vide";
                                    }
                                    else if(!RegExp(pattern).hasMatch(value)) {
                                      return "L'adresse email est incorrecte";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                child: TextFormField(

                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(), labelText: "Full name"),
                                  onSaved: (String? value) {
                                    _nom = value;
                                  },
                                  validator: (value) {
                                    if(value == null || value.isEmpty) {
                                      return "le nom ne doit pas etre vide";
                                    }
                                    else if(value.length < 2) {
                                      return "le nom doit avoir au moins 2 caractères";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: TextFormField(
                                  controller: _pass,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(), labelText: "Mot de passe"),
                                  onSaved: (String? value) {
                                    _password = value;
                                  },
                                  validator: (value) {
                                    if(value == null || value.isEmpty) {
                                      return "Le mot de passe ne doit pas etre vide";
                                    }
                                    else if(value.length < 5) {
                                      return "Le mot de passe doit avoir au moins 5 caractères";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                child: TextFormField(
                                  controller: _confirmPass,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(), labelText: "Repeter le mot de passe"),
                                  onSaved: (String? value) {
                                    _repeatPassword = value;
                                  },
                                  validator: (value) {
                                    if(value == null || value.isEmpty) {
                                      return "Le mot de passe ne doit pas etre vide";
                                    }
                                    else if(value.length < 5) {
                                      return "Le mot de passe doit avoir au moins 5 caractères";
                                    }else if(value != _pass.text){
                                      return "password not Matching";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                              ),








                              Container(
                                width: 343,
                                height: 57,
                                child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _keyForm.currentState!.save();



                                          Map<String, dynamic> userData = {

                                            "username":"rayen",
                                            "email" : _email,
                                            "password":_password,
                                          };
                                          Map<String, String> headers = {
                                            "Content-Type": "application/json; charset=UTF-8"
                                          };



                                          http.put(Uri.http(_baseUrl, '/user/editUser'), headers: headers,body: json.encode(userData) )
                                              .then((http.Response response) {
                                            if(response.statusCode == 200) {
                                              return const AlertDialog(
                                                title: Text("Information"),
                                                content: Text("works !"),
                                              );

                                            }
                                            else {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return const AlertDialog(
                                                      title: Text("Information"),
                                                      content: Text("Une erreur s'est produite. Veuillez réessayer !"),
                                                    );
                                                  });
                                            }
                                          });




                                      },
                                      style:  ElevatedButton.styleFrom(
                                        primary : Color.fromRGBO(255, 128, 0, 1),

                                      ),
                                      child: const Text("Edit Account ",textScaleFactor: 1.2,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14,letterSpacing: 0.5,),),

                                    )
                                ),
                              ),





                            ]))]))),
    );
  }
}

