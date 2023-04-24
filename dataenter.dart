import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DataEnter extends StatefulWidget {
  const DataEnter({Key? key}) : super(key: key);
  static const routeName = "datenter";
  @override
  State<DataEnter> createState() => _DataEnterState();
}

class _DataEnterState extends State<DataEnter> {
  var titleController = TextEditingController();
  var isbnController = TextEditingController();
  var authorController = TextEditingController();
  var pageController = TextEditingController();
  var priceController = TextEditingController();
  final dbRef = FirebaseDatabase.instance.ref();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My App"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Book Title",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: isbnController,
                  decoration: const InputDecoration(
                    labelText: "ISBN Number",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: authorController,
                  decoration: const InputDecoration(
                    labelText: "Author Name",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: pageController,
                  decoration: const InputDecoration(
                    labelText: "Total Pages",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: "Price in Dollars",
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text("Submit"),
                  onPressed: () {
                    // Add submit button action here
                    if (titleController.text.isNotEmpty &&
                        isbnController.text.isNotEmpty &&
                        authorController.text.isNotEmpty &&
                        pageController.text.isNotEmpty &&
                        priceController.text.isNotEmpty) {
                      insertData(
                          titleController.text,
                          isbnController.text,
                          authorController.text,
                          pageController.text,
                          priceController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void insertData(
      String title, String isbn, String author, String page, String price) {
    String? key = dbRef.child("book").push().key;
    dbRef.child('Books').child(key!).set({
      'Book Title': title,
      'Book ISBN': isbn,
      'Book Author': author,
      'Book Pages': page,
      'Book Price': price,
    });
    titleController.clear();
    isbnController.clear();
    authorController.clear();
    pageController.clear();
    priceController.clear();
  }
}
