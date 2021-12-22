import 'package:flutter/material.dart';
import 'package:internal/View/login_page.dart';
import 'package:internal/View/signup.dart';
import 'package:internal/core/states/request_state.dart';
import 'package:internal/locator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'View/edituser.dart';
import 'signin.dart';
import 'View/signup.dart';

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
        breakpoints: [
          //ResponsiveBreakpoint.autoScale(360, name: MOBILE),
          //ResponsiveBreakpoint.resize(440, name: MOBILE),
          //ResponsiveBreakpoint.resize(350, name: TABLET),
          //ResponsiveBreakpoint.resize(350, name: DESKTOP),
        ],
      ),
      title: 'Ecommerce',
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (BuildContext context) {
          return const Signin();
        },
        "/signup": (BuildContext context) {
          return const Signup();
        },
        // "/editUser": (BuildContext context) {
        //   return const Edituser();
        // },
        '/editUser': (context) => const Edituser(),

        "/login": (BuildContext context) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<RequestState>(create: (_) => RequestState())
            ],
            child: MaterialApp(
              theme: ThemeData(
                primaryColor: Colors.teal,
              ),
              debugShowCheckedModeBanner: false,
              home:  const LoginPage(),
            ),
          );
        },
      },
    );
  }
}
