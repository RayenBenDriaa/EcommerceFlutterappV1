import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'View/edituser.dart';
import 'signin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( builder: (context, widget) => ResponsiveWrapper.builder(
              ClampingScrollWrapper.builder(context, widget!),
              defaultScale: true,
              minWidth: 480,
              defaultName: MOBILE,
              breakpoints: [
                ResponsiveBreakpoint.autoScale(360, name: MOBILE),
                ResponsiveBreakpoint.resize(440, name: MOBILE),
                ResponsiveBreakpoint.resize(350, name: TABLET),
                ResponsiveBreakpoint.resize(350, name: DESKTOP),
              ],
            ),
        title: 'Ecommerce',
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (BuildContext context) {
            return const Signin();
          },
           "/editUser": (BuildContext context) {
            return const Edituser();
          },
      
      },
    );
  }
}
