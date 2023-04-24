import '/datadisplay.dart';
import '/dataenter.dart';
// import '/datadelete.dart'; // new

import '/buttons.dart';
// import '/dataenter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// import 'login.dart';
// import 'signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // runApp(MyApp());
}

class MyAppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Books Management System"),
        ),
        body: const Buttons(),
      ),
      routes: {
        // '/': (context) => LoginPage(),
        // LoginPage.routeName: (context) => const LoginPage(),
        DataEnter.routeName: (context) => const DataEnter(),
        DataDisplay.routeName: (context) => const DataDisplay(),
        // DataDelete.routeName: (context) => const DataDelete(),
      },
    );
  }
}
