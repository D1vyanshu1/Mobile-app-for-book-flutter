// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../screens/email_auth/login_screen.dart';

// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   void logOut() async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.popUntil(context, (route) => route.isFirst);
//     Navigator.pushReplacement(
//         context, CupertinoPageRoute(builder: (context) => LoginScreen()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Page"),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 logOut();
//               },
//               icon: Icon(Icons.exit_to_app))
//         ],
//       ),
//     );
//   }
// }

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DataDelete extends StatefulWidget {
  const DataDelete({Key? key}) : super(key: key);
  static const routeName = "datadelete";
  @override
  State<DataDelete> createState() => _DataDeleteState();
}

class _DataDeleteState extends State<DataDelete> {
  var isbnController = TextEditingController();
  final dbRef = FirebaseDatabase.instance.reference().child('Books');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Delete Book Data"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: isbnController,
                decoration: const InputDecoration(
                  labelText: "Enter Book ISBN Number",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text("Delete"),
                onPressed: () {
                  // Add delete button action here
                  if (isbnController.text.isNotEmpty) {
                    deleteData(isbnController.text);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteData(String isbn) {
    dbRef.child(isbn).remove().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Book data deleted successfully!"),
      ));
      isbnController.clear();
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed to delete book data."),
      ));
    });
  }
}
