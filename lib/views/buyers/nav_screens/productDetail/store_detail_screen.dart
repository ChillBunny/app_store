import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoreDetailScreen extends StatelessWidget {
  final dynamic storeData;

  const StoreDetailScreen({super.key, required this.storeData});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();
    return Scaffold(
        appBar: AppBar(
          title: Text(storeData['bussinessName']),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _productsStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: Colors.yellow.shade900,),);
              }

              if(snapshot.data!.docs.isEmpty){
                return const Center(
                  child: Text('No Product Uploaded',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                );
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['full_name']),
                    subtitle: Text(data['company']),
                  );
                }).toList(),
              );
            }));
  }
}
