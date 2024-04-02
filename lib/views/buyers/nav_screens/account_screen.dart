import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              backgroundColor: Colors.yellow.shade900,
              title: const Text('Profile',
                  style: TextStyle(letterSpacing: 2, color: Colors.white)),
              centerTitle: true,
              actions: const [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Center(
                    child: CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.yellow.shade900,
                  backgroundImage: NetworkImage(data['profileImage']),
                )),
                 Text(
                  data['fullname'],
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                 Text(
                  data['email'],
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(thickness: 2, color: Colors.grey),
                ),
                const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                const ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Phone'),
                ),
                const ListTile(
                  leading: Icon(Icons.shop),
                  title: Text('Cart'),
                )
              ],
            ),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
