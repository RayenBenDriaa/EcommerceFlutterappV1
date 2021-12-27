import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:internal/NetworkHandler.dart';
import 'package:internal/View/login_page.dart';
import 'package:internal/View/profile.dart';
import 'package:internal/core/states/request_state.dart';
import 'package:internal/locator.dart';
import 'package:internal/shared/splash_screen.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'View/edituser.dart';
import 'View/explorer.dart';
import 'View/favoris.dart';
import 'View/panier.dart';
import 'View/signin.dart';
import 'View/signup.dart';
import 'View/navBar.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            builder: (context, widget) => ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, widget),
              defaultScale: true,
              minWidth: 480,
              defaultName: MOBILE,
              // breakpoints: [
              //   ResponsiveBreakpoint.autoScale(360, name: MOBILE),
              //   ResponsiveBreakpoint.resize(440, name: MOBILE),
              //   ResponsiveBreakpoint.resize(350, name: TABLET),
              //   ResponsiveBreakpoint.resize(350, name: DESKTOP),
              // ],
            ),
            title: 'Ecommerce',

            darkTheme: ThemeData.dark(),
            themeMode: currentMode,

            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // CUSTOMIZE showDatePicker Colors
              colorScheme: ColorScheme.light(primary: HexColor("#FF8000")),
              buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            routes: {
              "/": (BuildContext context) {
                return const SpalshScreen();
              },
              "/signin": (BuildContext context) {
                return const Signin();
              },
              "/signup": (BuildContext context) {
                return const Signup();
              },
              "/editUser": (BuildContext context) {
                return const Edituser();
              },
              "/profile": (BuildContext context) {
                return Profile();
              },
              "/navbar": (BuildContext context) {
                return HomeScreen();
              },
              "/login": (BuildContext context) {
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider<RequestState>(
                        create: (_) => RequestState())
                  ],
                  child: MaterialApp(
                    theme: ThemeData(
                      primaryColor: Colors.teal,
                    ),
                    debugShowCheckedModeBanner: false,
                    home: const LoginPage()
                  ),
                );
              },
            },
          );
        });
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
          "",
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
              icon: Icon(MyApp.themeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: () {
                MyApp.themeNotifier.value =
                MyApp.themeNotifier.value == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
              })
        ],

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
