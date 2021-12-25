import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internal/shared/badge.dart';
import 'package:internal/shared/notifications.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../signin.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin {
  String id;
  String username = "eee";
  String email = "eee";
  String fullname = "eee";
  String adresse = "eee";
  String date_naissance = "eee";
  int telephone = 0;

   final String _baseUrl = "10.0.2.2:4000"; //Slim
  //final String _baseUrl = "192.168.1.2:4000"; //Sana

  Future<bool> fetchedDocs;

  Future<bool> fetchDocs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("token");
    //requete GET pour obtenir l'entité CIN d'un user

    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
      "token": id,
    };

    http.Response response =
        await http.get(Uri.http(_baseUrl, "/user/me"), headers: headers);
    if (response.body != "null") {
      //assigner la réponse à une MAP
      Map<String, dynamic> data = json.decode(response.body);
      //assigner les variable etat, date et couleurs à leurs valeurs correspandtes
      username = data["username"];
      email = data["email"];
      telephone = data["telephone"];
      fullname = data["fullname"];
      adresse = data["adresse"];
      date_naissance = data["date_naissance"];

      print(username);
    }

    return true;
  }

  @override
  void initState() {
    fetchedDocs = fetchDocs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
        future: fetchedDocs,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Future<Map<String, dynamic>> commonDel() async {
                  HttpClient httpClient = new HttpClient();
                  HttpClientRequest request =  await  httpClient.deleteUrl(Uri.parse(
                      "http://10.0.2.2:4000/user/deleteUser/"+email)) ;
                  print(email);
                  request.headers.set('content-type', 'application/json');
                  //request.add(utf8.encode(json.encode(null)));
                  HttpClientResponse response = await request.close();
                  String statusCode = response.statusCode.toString();
                  String reply = await response.transform(utf8.decoder).join();

                  print(reply);
                  if(statusCode == "200"){
                    print("done");
                    Navigator.of(context).pushNamed("/signin");
                  }
                  httpClient.close();
                }
                commonDel();
              },
              label: const Text('Delete'),
              icon: const Icon(Icons.delete),
              backgroundColor: Colors.orange,
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.orange,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              centerTitle: true,
              title: Text(
                "My Profile",
                style: TextStyle(
                    color: Color.fromRGBO(34, 50, 99, 1),
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w900,
                    height: 1 /*PERCENT not supported*/

                    ),
              ),

              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  icon: IconBadge(
                    icon: Icons.add_shopping_cart_sharp,
                    size: 25.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return Notifications();
                        },
                      ),
                    );
                  },
                  tooltip: "Shopping Card",
                ),

              ],
            ),
            body: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10, 10.0, 0),
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  username,
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  email,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.remove("token");
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          //TODO LOGOUT

                                          return Signin();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Logout",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.orange,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        flex: 3,
                      ),
                    ],
                  ),
                  Divider(),
                  Container(height: 15.0),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Account Information".toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Full Name",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      fullname,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 20.0,
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/editUser");

                        // TODO edit rayen
                      },
                      tooltip: "Edit",
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      email,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Phone",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(telephone.toString()),
                  ),
                  ListTile(
                    title: Text(
                      "Address",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      adresse,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Date of Birth",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      date_naissance,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
