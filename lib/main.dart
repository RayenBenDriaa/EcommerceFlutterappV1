import 'package:flutter/material.dart';
import 'package:internal/View/signup.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'View/edituser.dart';
import 'signin.dart';
import 'View/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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
      theme: ThemeData(primarySwatch: Colors.amber),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
            home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
         "/signin": (BuildContext context) {
                return const Signin();
              },

        
        "/signup": (BuildContext context) {
          return const Signup();
        },
       
         "/edituser": (BuildContext context) {
                return const Edituser();
              },
            },
          );
        });
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kindacode.com'),
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
      body: Center(
        child: ElevatedButton(
          child: Text('Go to Other Screen'),
          onPressed: () {
            Navigator.pushNamed(context, "/signup");
          },
        ),
      ),
    );
  }
}
