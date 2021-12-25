import 'dart:math';

import 'package:flutter/material.dart';
import 'package:internal/View/login_page.dart';
import 'package:internal/View/profile.dart';
import 'package:internal/core/states/request_state.dart';
import 'package:internal/locator.dart';
import 'package:internal/shared/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:hexcolor/hexcolor.dart';

import 'View/edituser.dart';
import 'signin.dart';
import 'View/signup.dart';
import 'View/navBar.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // CUSTOMIZE showDatePicker Colors
        colorScheme: ColorScheme.light(primary: HexColor("#FF8000")),
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
      // supportedLocales: ln10.all,
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
          return NavBar();
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
              home: const LoginPage(),
            ),
          );
        },
      },
    );
  }
}
