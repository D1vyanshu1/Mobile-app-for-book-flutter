import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class DataDisplay extends StatefulWidget {
  const DataDisplay({Key? key}) : super(key: key);
  static const routeName = "datadisplay";
  @override
  State<DataDisplay> createState() => _DataDisplayState();
}

class _DataDisplayState extends State<DataDisplay> {
  // Query dbRef = FirebaseDatabase.instance.ref().child('Books');
  // DatabaseReference reference = FirebaseDatabase.instance.ref().child('Books');
  final fb = FirebaseDatabase.instance;
  var l, g, k;
  // int t1 = 0;
  late DatabaseReference ref;
  @override
  void initState() {
    // TODO: implement initState
    ref = fb.ref().child('Books');
    super.initState();
  }

  void deleteBook(String key) {
    ref.child(key).remove();
  }

  // void editBook(String key, List<String> currentData) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       // Create a TextEditingController for each input field
  //       final TextEditingController bookNameController =
  //           TextEditingController(text: currentData[0]);
  //       final TextEditingController authorNameController =
  //           TextEditingController(text: currentData[1]);
  //       final TextEditingController bookNumberController =
  //           TextEditingController(text: currentData[2]);
  //       final TextEditingController bookPagesController =
  //           TextEditingController(text: currentData[3]);
  //       final TextEditingController bookYearController =
  //           TextEditingController(text: currentData[4]);

  //       return AlertDialog(
  //         title: const Text('Edit Book'),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               TextField(
  //                 controller: bookNameController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Book Name',
  //                 ),
  //               ),
  //               TextField(
  //                 controller: authorNameController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Author Name',
  //                 ),
  //               ),
  //               TextField(
  //                 controller: bookNumberController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Book Number',
  //                 ),
  //               ),
  //               TextField(
  //                 controller: bookPagesController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Book Pages',
  //                 ),
  //               ),
  //               TextField(
  //                 controller: bookYearController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Book Year',
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               // Update the book data in the database
  //               ref.child(key).update({
  //                 'itemname': bookNameController.text,
  //                 'authorname': authorNameController.text,
  //                 'booknumber': bookNumberController.text,
  //                 'bookpages': bookPagesController.text,
  //                 'bookyear': bookYearController.text,
  //               });

  //               // Update the local list that's used to display the data
  //               setState(() {
  //                 currentData[0] = bookNameController.text;
  //                 currentData[1] = authorNameController.text;
  //                 currentData[2] = bookNumberController.text;
  //                 currentData[3] = bookPagesController.text;
  //                 currentData[4] = bookYearController.text;
  //               });

  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Save'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void editBook(String key, List<String> currentData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Create a TextEditingController for each input field
        final TextEditingController bookNameController =
            TextEditingController(text: currentData[0]);
        final TextEditingController authorNameController =
            TextEditingController(text: currentData[1]);
        final TextEditingController bookNumberController =
            TextEditingController(text: currentData[2]);
        final TextEditingController bookPagesController =
            TextEditingController(text: currentData[3]);
        final TextEditingController bookYearController =
            TextEditingController(text: currentData[4]);

        return AlertDialog(
          title: const Text('Edit Book'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: bookNameController,
                  decoration: const InputDecoration(
                    labelText: 'Book Name',
                  ),
                ),
                TextField(
                  controller: authorNameController,
                  decoration: const InputDecoration(
                    labelText: 'Author Name',
                  ),
                ),
                TextField(
                  controller: bookNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Book Number',
                  ),
                ),
                TextField(
                  controller: bookPagesController,
                  decoration: const InputDecoration(
                    labelText: 'Book Pages',
                  ),
                ),
                TextField(
                  controller: bookYearController,
                  decoration: const InputDecoration(
                    labelText: 'Book Year',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Update the book data in the database
                ref.child(key).update({
                  'itemname': bookNameController.text,
                  'authorname': authorNameController.text,
                  'booknumber': bookNumberController.text,
                  'bookpages': bookPagesController.text,
                  'bookyear': bookYearController.text,
                });

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Books data'),
        ),
        body: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  var v = snapshot.value.toString();
                  print(v);
                  g = v.replaceAll(RegExp("{|}|itemname: |price: |id: "), "");
                  g.trim();
                  l = g.split(',');
                  print(l);
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: Colors.grey.shade300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),

                              Text(
                                l[0],
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),
                              // const Spacer(),
                              Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                l[1],
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                l[2],
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                l[3],
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                l[4],
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => deleteBook(snapshot.key!),
                                child: const Text('Delete'),
                              ),
                              IconButton(
                                onPressed: () {
                                  editBook(snapshot.key!, l);
                                },
                                icon: Icon(Icons.edit),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
}
