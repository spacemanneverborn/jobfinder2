import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firestore Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Adding a document to Firestore
            await FirebaseFirestore.instance.collection('test').add({
              'name': 'Test User',
              'timestamp': FieldValue.serverTimestamp(),
            });
            print('Document added to Firestore');
          },
          child: Text('Add Document'),
        ),
      ),
    );
  }
}
