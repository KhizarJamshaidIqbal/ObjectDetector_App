// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled4/constants/colors.dart';
import 'package:untitled4/widgets/CustomDrawer%20.dart';

class DetectionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(user: FirebaseAuth.instance.currentUser),
      appBar: AppBar(
        backgroundColor: Color(0xff1C232D),
        iconTheme: IconThemeData(color: Colors.yellow),
        elevation: 0.0,
        title: const Text(
          'Detection History',
          style: TextStyle(color: Colors.yellow),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('DetectionHistory')
            .where('userName',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No detection history available.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var detectionItem = snapshot.data!.docs[index];
              var imageUrl = detectionItem['image_url'] ?? '';
              var summary = detectionItem['summary'] ?? '';
              var timestamp =
                  detectionItem['timestamp']?.toDate() ?? DateTime.now();

              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrl,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Summary: $summary',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Timestamp: ${timestamp.toLocal()}',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _showDeleteConfirmationDialog(context, detectionItem.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, String documentId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text(
              "Are you sure you want to delete this detection item?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                _deleteDetectionItem(documentId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteDetectionItem(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('DetectionHistory')
          .doc(documentId)
          .delete();
    } catch (e) {
      print("Error deleting detection item: $e");
      // Handle the error as needed
    }
  }
}
