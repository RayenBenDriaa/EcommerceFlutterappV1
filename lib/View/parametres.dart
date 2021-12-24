import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Parametres extends StatefulWidget {
  const Parametres({Key key}) : super(key: key);

  @override
  _ParametresState createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {
  int selectedIndex = 0;
  Widget _explorer = Explorer();
  Widget _panier = Panier();
  Widget _favoris = Favoris();
  Widget _profil = Profil();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      child: Scaffold(
          // backgroundColor: HexColor("#FF8000"),
          appBar: AppBar(
            title: Text(
              "Paramètres",
              textAlign: TextAlign.center,
            ),
          ),
          body: Stack(
            children: <Widget>[
              getBody,
              Positioned(
                left: -5,
                right: -5,
                bottom: 0,
                child: bottomNavigationBar,
              ),
            ],
          )),
    );
  }

  Widget get getBody {
    if (this.selectedIndex == 0) {
      return this._explorer;
    } else if (this.selectedIndex == 1) {
      return this._panier;
    } else if (this.selectedIndex == 2) {
      return this._favoris;
    } else
      return this._profil;
  }

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        showUnselectedLabels: false,
        backgroundColor: HexColor("#FF8000"),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        iconSize: 30,
        selectedLabelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            fontFamily: "Poppins",
            letterSpacing: 0.5),
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.explore_outlined,
                size: 35,
              ),
            ),
            label: "Explorer",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 35,
              ),
            ),
            label: "Panier",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.favorite_border_outlined,
                size: 35,
              ),
            ),
            label: "Favoris",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.account_circle_outlined,
                size: 35,
              ),
            ),
            label: "Profil",
          ),
        ],
        onTap: (int index) {
          this.onTapHandler(index);
        },
      ),
    );
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
}

class Explorer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Page Explorer"));
  }
}

class Panier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Page Panier"));
  }
}

class Favoris extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Page Favoris"));
  }
}

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Page Profil"));
  }
}
