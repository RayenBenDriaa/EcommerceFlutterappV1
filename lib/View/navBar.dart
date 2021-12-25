import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internal/View/explorer.dart';
import 'package:internal/View/favoris.dart';
import 'package:internal/View/panier.dart';
import 'package:internal/View/profile.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  PageController _pageController = PageController();
  List<Widget> _screens = [Explorer(), Panier(), Favoris(), Profile()];

  void _onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _itemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }
  // Widget _explorer = Explorer();
  // Widget _panier = Panier();
  // Widget _favoris = Favoris();
  // Widget _profil = Profil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      // backgroundColor: HexColor("#FF8000"),
      appBar: AppBar(
        title: const Text(
          "Paramètres",
          textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar: navbar,
    );
  }

  Widget get navbar {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
      child: BottomNavigationBar(
          onTap: _itemTapped,
          type: BottomNavigationBarType.fixed,
          currentIndex: this.selectedIndex,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          backgroundColor: HexColor("#FF8000"),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          iconSize: 30,
          selectedLabelStyle: const TextStyle(
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
                  Icons.person_outline_outlined,
                  size: 35,
                ),
              ),
              label: "Profil",
            )
          ]),
    );
  }
}
