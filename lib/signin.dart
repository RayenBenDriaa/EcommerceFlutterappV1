import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'NetworkHandler.dart';

class Signin extends StatefulWidget {
  const Signin({Key key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String _email;
  String _password;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  NetworkHandler networkHandler = NetworkHandler();
  final TextEditingController _email2 = TextEditingController();
  final TextEditingController _password2 = TextEditingController();

  final String _baseUrl = "127.0.0.1:4000";

  @override
  Widget _buildLogoButton({
    String image,
    VoidCallback onPressed,
  }) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: onPressed,
      child: SizedBox(
        height: 30,
        child: Image.asset(image),
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 55), // give it width

        _buildLogoButton(
          image: 'assets/images/google_logo.png',
          onPressed: () {},
        ),
        _buildLogoButton(
          image: 'assets/images/facebook_logo.png',
          onPressed: () {},
        ),
        SizedBox(width: 55), // give it width
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _keyForm,
        child: ListView(
          children: [
            Container(
                width: 90,
                height: 102,
                child: Stack(children: <Widget>[
                  Positioned(
                    child: Align(
                      alignment: Alignment(0, 0.7),
                      child: Container(
                        width: 120,
                        height: 54,
                        child: SizedBox(
                          height: 10,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                      ),
                    ),
                  ),
                ])),
            Container(
                width: 90,
                height: 70,
                child: Stack(children: <Widget>[
                  Positioned(
                    child: Align(
                        alignment: Alignment(0, 0.7),
                        child: Container(
                            width: 120,
                            height: 54,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 8,
                                  child: Text(
                                    'Welcome to ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromRGBO(34, 50, 99, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w900,
                                        height: 1 /*PERCENT not supported*/
                                        ),
                                  )),
                              Positioned(
                                  top: 32,
                                  left: 0,
                                  child: Text(
                                    'Sign in to continue',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromRGBO(144, 152, 177, 1),
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.normal,
                                        height: 1 /*PERCENT not supported*/
                                        ),
                                  )),
                            ]))),
                  ),
                ])),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                controller: _email2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Email',
                  prefixIcon: Icon(Icons.email),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFEF6C00), width: 2.0),
                  ),
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
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                controller: _password2,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Password',
                  prefixIcon: Icon(Icons.lock),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFFEF6C00), width: 2.0),
                  ),
                ),
                onSaved: (String value) {
                  _password = value;
                },
                validator: (String value) {
                  if (value == null || value.isEmpty) {
                    return "Le mot de passe ne doit pas etre vide";
                  } else if (value.length < 2) {
                    return "Le mot de passe doit avoir au moins 4 caractères";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  child: const Text("Signin"),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFEF6C00),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Georgia'),
                    shadowColor: Colors.orange,
                    elevation: 10.0, //buttons Material shadow
                  ),
                  onPressed: () {
                    if (_keyForm.currentState.validate()) {
                      _keyForm.currentState.save();
                      Map<String, dynamic> userData = {
                        "email": _email2.text,
                        "password": _password2.text
                      };

                      Map<String, String> headers = {
                        "Content-Type": "application/json; charset=UTF-8"
                      };

                      http
                          .post(Uri.http(_baseUrl, "/user/login"),
                              headers: headers, body: json.encode(userData))
                          .then((http.Response response) async {
                        if (response.statusCode == 200) {
                          Map<String, dynamic> userFromServer =
                              json.decode(response.body);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("email", _email);
                          prefs.setString("token", userFromServer["token"]);

                          Navigator.pushReplacementNamed(context, "/navbar");
                          print(userFromServer["token"]);
                        } else if (response.statusCode == 401) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  title: Text("Information"),
                                  content: Text(
                                      "Username et/ou mot de passe incorrect"),
                                );
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  title: Text("Information"),
                                  content: Text(
                                      "Une erreur s'est produite. Veuillez réessayer !"),
                                );
                              });
                        }
                      });
                    }
                  },
                )),
            Container(
              margin: EdgeInsets.all(24),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                  ),
                  Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[500],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        thickness: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Container(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildSocialButtons(),
                  ]),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: const Text("Forgot Password ? ",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, color: Colors.orange)),
                    onTap: () {
                      //Navigator.pushNamed(context, "/signup");
                        Navigator.pushNamed(context, "/login");
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account ?"),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: const Text("Register",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, color: Colors.orange)),
                    onTap: () {
                      Navigator.pushNamed(context, "/signup");
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
