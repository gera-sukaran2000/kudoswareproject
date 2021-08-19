import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teachersapp/Models/Auth.dart';
import 'package:teachersapp/Models/Teachers.dart';
import 'package:teachersapp/screens/AuthScreen.dart';
import 'package:teachersapp/screens/DataOutput.dart';
import 'package:teachersapp/screens/SplashScreen.dart';
import 'package:teachersapp/screens/tabBar.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, StudentDataList>(
              update: (ctx, authObject, previousStudentsList) =>
                  StudentDataList(
                      authObject.Token,
                      authObject.userId,
                      previousStudentsList == null
                          ? []
                          : previousStudentsList.allData)),
        ],
        child: Consumer<Auth>(
          builder: (ctx, authObject, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.amber,
              primaryColor: Colors.blue[200],
              accentColor: Colors.black,
            ),
            home: authObject.isAuth
                ? TabBarScreen()
                : FutureBuilder(
                    future: authObject.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              'StudentData': (ctx) => DataOutput(),
            },
          ),
        ));
  }
}
