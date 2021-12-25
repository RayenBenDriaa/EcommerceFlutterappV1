import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../NetworkHandler.dart';

class Edituser extends StatefulWidget {
  const Edituser({Key key}) : super(key: key);

  @override
  State<Edituser> createState() => _EdituserState();
}

class _EdituserState extends State<Edituser> {
  
   String _nom;
   String _email;
   String _password;
   String _prenom;
   String _numtel;
   String _repeatPassword;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  NetworkHandler networkHandler = NetworkHandler();
  final TextEditingController _nom2 = TextEditingController();
  final TextEditingController _email2 = TextEditingController();
  final TextEditingController _prenom2 = TextEditingController();
  final TextEditingController _addresse2 = TextEditingController();
  final TextEditingController _numtel2 = TextEditingController();
   final TextEditingController birthInput = TextEditingController();
  final TextEditingController _tel = TextEditingController();
  final maskFormatter = MaskTextInputFormatter(mask: '## ### ###');

  final String _baseUrl = "10.0.2.2:4000";
  String _username;
  SharedPreferences prefs;
  Future<bool> userinfo;
  Future<bool> getUserInfo() async {
    prefs = await SharedPreferences.getInstance();
    _username = prefs.getString("username");

    return true;
  }

  @override
  void initState() {
    userinfo = getUserInfo();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    int age;
    DateTime date = DateTime.now();
    // Figma Flutter Generator PrincipalctaWidget - INSTANCE
    return FutureBuilder(
        future: userinfo,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Container(
            decoration: const BoxDecoration(),
            child: Scaffold(
                body: Form(
                    key: _keyForm,
                    child: ListView(children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(15, 40, 15, 0),
                          child: Column(children: [
                            Container(
                                width: 72,
                                height: 72,
                                child: Stack(children: <Widget>[
                                  Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                          width: 72,
                                          height: 72,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16),
                                              bottomLeft: Radius.circular(16),
                                              bottomRight: Radius.circular(16),
                                            ),
                                            color:
                                                Color.fromRGBO(255, 128, 0, 1),
                                          ))),
                                  Positioned(
                                      top: 20,
                                      left: 22,
                                      child: Container(
                                          width: 32,
                                          height: 31.999998092651367,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/vector40stroke.png'),
                                            ),
                                          ))),
                                ])),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 35, 10, 10),
                              child: TextFormField(
                                controller: _email2,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Modifier votre email',
                                  prefixIcon: const Icon(Icons.email),
                                  fillColor: Colors.white,
                                ),
                                onSaved: (String value) {
                                  _email = value;
                                },
                                validator: (String value) {
                                  String pattern =
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                                  if (value == null || value.isEmpty) {
                                    return "L'adresse email ne doit pas etre vide";
                                  } else if (!RegExp(pattern).hasMatch(value)) {
                                    return "L'adresse email est incorrecte";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: width,
                              height: 65,
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: TextFormField(
                                controller: _prenom2,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Modifier votre Nom et Prénom',
                                  prefixIcon:
                                      const Icon(Icons.account_box_sharp),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor("#FF8000"),
                                          width: 1.0)),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Veuillez renseigner votre nom et prénom.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: width,
                              height: 65,
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: TextFormField(
                                controller: _tel,
                                keyboardType: TextInputType.number,
                                inputFormatters: [maskFormatter],
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Entrez votre numéro de téléphone',
                                  prefixIcon: const Icon(Icons.phone),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor("#FF8000"),
                                          width: 1.0)),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Veuillez renseigner votre numéro de téléphone.";
                                  } else if (value.replaceAll(' ', '').length !=
                                      8) {
                                    return "Veuillez renseigner un numéro de téléphone valide";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: width,
                              height: 65,
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: TextFormField(
                                controller: _addresse2,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Modifier votre  adresse',
                                  prefixIcon: const Icon(Icons.home_outlined),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor("#FF8000"),
                                          width: 1.0)),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Veuillez renseigner votre  adresse";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              width: width,
                              height: 65,
                              child: TextFormField(
                                controller: birthInput,
                                decoration: InputDecoration(
                                  labelText: "Modifier votre date de naissance",
                                  border: const OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.cake),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor("#FF8000"),
                                          width: 1.0)),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  DateTime pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                  );
                                  if (pickedDate != null) {
                                    date = pickedDate;
                                    String formattedDate =
                                        DateFormat('dd/MM/yyyy')
                                            .format(pickedDate);
                                    // _naissance = formattedDate;
                                    setState(() {
                                      birthInput.text = formattedDate;
                                    });
                                    print(birthInput.text);
                                  } else {
                                    print("Pas de date ");
                                  }
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Veuillez renseigner votre date de naissance.";
                                  } else {
                                    age = calculateAge(date);
                                    print(age);
                                    if (age < 18) {
                                      return "Vous devez être agé de minimum 18ans pour créer un compte";
                                    } else {
                                      return null;
                                    }
                                  }
                                  // return null;
                                  // }
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: TextFormField(
                                controller: _pass,
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: "Modifier Mot de passe",
                                  prefixIcon: const Icon(Icons.lock),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor("#FF8000"),
                                          width: 1.0)),
                                ),
                                onSaved: (String value) {
                                  _password = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Le mot de passe ne doit pas etre vide";
                                  } else if (value.length < 5) {
                                    return "Le mot de passe doit avoir au moins 5 caractères";
                                  } else {
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
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: "Repeter le mot de passe",
                                  prefixIcon: const Icon(Icons.lock),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor("#FF8000"),
                                          width: 1.0)),
                                ),
                                onSaved: (String value) {
                                  _repeatPassword = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Le mot de passe ne doit pas etre vide";
                                  } else if (value.length < 5) {
                                    return "Le mot de passe doit avoir au moins 5 caractères";
                                  } else if (value != _pass.text) {
                                    return "password not Matching";
                                  } else {
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
                                    onPressed: () async {
                                      _keyForm.currentState.save();

                                    Map<String, String> userData = {
                                      "username": _username,
                                        "email": _email2.text,
                                        "fullname": _prenom2.text,
                                        "adresse": _addresse2.text,
                                        "telephone":
                                            _tel.text.replaceAll(" ", ''),
                                        "date_naissance": birthInput.text,
                                        "password": _pass.text,
                                      };
                                      await networkHandler.post(
                                          "/user/editUser", userData);

                                    // Map<String, String> headers = {
                                      //   "Content-Type":
                                      //       "application/json; charset=UTF-8"
                                      // };

                                    // http
                                      //     .put(Uri.http(_baseUrl, '/user/editUser'),
                                      //         headers: headers,
                                      //         body: json.encode(userData))
                                      //     .then((http.Response response) {
                                      //   if (response.statusCode == 200) {
                                      //     return const AlertDialog(
                                      //       title: Text("Information"),
                                      //       content: Text("works !"),
                                      //     );
                                      //   } else {
                                      //     showDialog(
                                      //         context: context,
                                      //         builder: (BuildContext context) {
                                      //           return const AlertDialog(
                                      //             title: Text("Information"),
                                      //             content: Text(
                                      //                 "Une erreur s'est produite. Veuillez réessayer !"),
                                      //           );
                                      //         });
                                      //   }
                                      // });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromRGBO(255, 128, 0, 1),
                                    ),
                                    child: const Text(
                                      "Edit Account ",
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  )),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 50),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: Text("Go back",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: HexColor("#FF8000"),
                                            fontSize: 16)),
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      Navigator.pushNamed(context, "/navbar");
                                    },
                                  )
                                ],
                              ),
                            )
                          ]))
                    ]))),
        );
        }
    );
  }
  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}
