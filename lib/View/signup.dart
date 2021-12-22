import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import '../NetworkHandler.dart';

class Signup extends StatefulWidget {
  const Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // -------Formulaire
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // -------Base de donnée
  NetworkHandler networkHandler = NetworkHandler();

  // -------Controllers
  final TextEditingController birthInput = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pdp = TextEditingController();
  final TextEditingController _adresse = TextEditingController();
  final TextEditingController _tel = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _verifpassword = TextEditingController();

  // -------verif age
  int age;
  DateTime date = DateTime.now();

  // -------verif unicite email et username
  String errorText;
  String errorTextEmail;
  bool validate = false;
  bool validateEmail = false;

  bool circular = false; // -------Design chargement

  // -------Mots de passes "invisibles"
  bool crypte = true;
  bool crypte2 = true;

  @override
  void initState() {
    birthInput.text = "";
    _password.text = "";
    _verifpassword.text = "";
    _username.text = "";
    _fullname.text = "";
    _email.text = "";
    _pdp.text = "";
    _adresse.text = "";
    _tel.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // -------dimensions dynamiques
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // -------masque tel
    final maskFormatter = MaskTextInputFormatter(mask: '## ### ###');

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              width: width,
              height: height / 5,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: height / 13,
                    left: width * 0.4,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/logo.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: width,
              height: height / 10,
              child: Stack(
                children: [
                  Positioned(
                    top: 5,
                    left: 0,
                    child: SizedBox(
                      width: width,
                      height: 54,
                      child: Text(
                        "Lets's Get Started",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: HexColor("#223263"),
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w900,
                            height: 1),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 27,
                    left: 0,
                    child: SizedBox(
                      width: width,
                      height: 54,
                      child: Text(
                        "Create a new account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: HexColor("#9098B1"),
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: width,
              height: 65,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                controller: _fullname,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Entrez votre Nom et Prénom',
                  prefixIcon: const Icon(Icons.account_box_sharp),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor("#FF8000"), width: 1.0)),
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
                controller: _username,
                decoration: InputDecoration(
                  errorText: validate ? null : errorText,
                  border: const OutlineInputBorder(),
                  hintText: 'Entrez votre nom d\'utilisateur',
                  prefixIcon: const Icon(Icons.perm_identity),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor("#FF8000"), width: 1.0)),
                ),
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return "Veuillez renseigner un nom d'utilisateur.";
                //   } else {
                //     return null;
                //   }
                // },
              ),
            ),
            Container(
              width: width,
              height: 65,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  errorText: validateEmail ? null : errorTextEmail,
                  border: const OutlineInputBorder(),
                  hintText: 'Entrez votre email',
                  prefixIcon: const Icon(Icons.email),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor("#FF8000"), width: 1.0)),
                ),
                // validator: (value) {
                //   String pattern =
                //       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                //   if (value!.isEmpty) {
                //     return "Veuillez renseigner votre adresse mail";
                //   } else if (!RegExp(pattern).hasMatch(value)) {
                //     return "Veuillez renseigner une adresse mail valide";
                //   } else {
                //     return null;
                //   }
                // },
              ),
            ),
            Container(
              width: width,
              height: 65,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                controller: _adresse,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Entrez votre adresse',
                  prefixIcon: const Icon(Icons.home_outlined),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor("#FF8000"), width: 1.0)),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Veuillez renseigner l'adresse de votre domicile.";
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
                      borderSide:
                          BorderSide(color: HexColor("#FF8000"), width: 1.0)),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Veuillez renseigner votre numéro de téléphone.";
                  } else if (value.replaceAll(' ', '').length != 8) {
                    return "Veuillez renseigner un numéro de téléphone valide";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            // Row(
            //   children: [
            //     IconButton(
            //       icon: Icon(Icons.calendar_today_sharp),
            //       onPressed: () {
            //         DatePicker.showDatePicker(context,
            //             showTitleActions: true,
            //             minTime: DateTime(1900, 1, 1),
            //             maxTime: DateTime.now(), onChanged: (date) {
            //           // print('change $date');
            //         }, onConfirm: (date) {
            //           _naissance =
            //               DateFormat("dd/MM/yyyy").format(date).toString();
            //           print(_naissance);
            //         }, currentTime: DateTime.now(), locale: LocaleType.fr);
            //       },
            //     ),
            //     Container(
            //       width: width - 59,
            //       height: 65,
            //       margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
            //       child: TextFormField(
            //         readOnly: true,
            //         initialValue: _naissance,
            //         decoration: const InputDecoration(
            //           border: OutlineInputBorder(),
            //           // hintText: 'Choisir votre date de naissance',
            //           prefixIcon: Icon(Icons.cake),
            //           focusedBorder: OutlineInputBorder(),
            //         ),
            //         onSaved: (String? value) {
            //           _naissance = value;
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              width: width,
              height: 65,
              child: TextFormField(
                controller: birthInput,
                decoration: InputDecoration(
                  labelText: "Choisissez votre date de naissance",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.cake),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor("#FF8000"), width: 1.0)),
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
                        DateFormat('dd/MM/yyyy').format(pickedDate);
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
              width: width,
              height: 65,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                controller: _password,
                obscureText: crypte,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Entrez votre mot de passe',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon:
                        Icon(crypte ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        crypte = !crypte;
                      });
                    },
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor("#FF8000"), width: 1.0)),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Veuillez renseigner votre mot de passe.";
                  } else if (value.length < 8) {
                    return "Votre mot de passe doit contenir au moins 8 caractères";
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
                controller: _verifpassword,
                obscureText: crypte2,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Confirmez votre mot de passe',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon:
                        Icon(crypte2 ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        crypte2 = !crypte2;
                      });
                    },
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor("#FF8000"), width: 1.0)),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Veuillez renseigner votre mot de passe.";
                  } else if (value.length < 8) {
                    return "Votre mot de passe doit contenir au moins 8 caractères";
                  } else if (value != _password.text) {
                    return "Les mots de passes ne sont pas identiques";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: circular
                  ? LinearProgressIndicator()
                  : ElevatedButton(
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w900,
                            height: 1),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: HexColor("FF8000"),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                        shadowColor: Colors.orange,
                        elevation: 10.0, //buttons Material shadow
                      ),
                      onPressed: () async {
                        setState(() {
                          circular = true;
                        });
                        await checkUsername();
                        await checkEmail();
                        // print("username : " + _username.text);
                        // print("_fullname : " + _fullname.text);
                        // print("email : " + _email.text);
                        // print("_tel : " + _tel.text);
                        // print("adresse : " + _adresse.text);
                        // print("pdp : " + _pdp.text);
                        // print("birthInput : " + birthInput.text);
                        // print("_password : " + _password.text);

                        FocusScope.of(context).requestFocus(FocusNode());
                        if (_formKey.currentState.validate() &&
                            validate &&
                            validateEmail) {
                          Map<String, String> data = {
                            "username": _username.text,
                            "fullname": _fullname.text,
                            "email": _email.text,
                            "telephone": _tel.text.replaceAll(" ", ''),
                            "adresse": _adresse.text,
                            "pdp": _pdp.text,
                            "date_naissance": birthInput.text,
                            "password": _password.text
                          };
                          print(data);
                          await networkHandler.post("/user/signup", data);
                          setState(() {
                            circular = false;
                          });
                        } else {
                          setState(() {
                            circular = false;
                          });
                        }
                      },
                    ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account ?",
                    style: TextStyle(
                        fontSize: 12,
                        color: HexColor("#9098B1"),
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    child: Text("Sign In",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: HexColor("#FF8000"),
                            fontSize: 12)),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      print("Sign In");
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

  checkUsername() async {
    if (_username.text.length == 0) {
      setState(() {
        circular = false;
        validateEmail = false;
        errorText = "Veuillez renseigner votre nom d'utilisateur";
      });
    } else {
      var response =
          await networkHandler.get("/user/checkUsername/${_username.text}");
      if (response['Status']) {
        setState(() {
          validate = false;
          errorText = "Ce nom d'utilisateur est déjà utilisé";
        });
      } else {
        setState(() {
          validate = true;
        });
        errorText = "";
      }
    }
  }

  checkEmail() async {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    if (_email.text.length == 0) {
      setState(() {
        circular = false;
        validateEmail = false;
        errorTextEmail = "Veuillez renseigner votre adresse mail";
      });
    } else if (!RegExp(pattern).hasMatch(_email.text)) {
      return "Veuillez renseigner une adresse mail valide";
    } else {
      var response =
          await networkHandler.get("/user/checkEmail/${_email.text}");
      if (response['Status']) {
        setState(() {
          validateEmail = false;
          errorTextEmail = "Cette adresse mail a déjà été utilisée";
        });
      } else {
        setState(() {
          validateEmail = true;
        });
      }
    }
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
