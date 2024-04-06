import 'package:app_store/views/buyers/nav_screens/productDetail/product_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  String _searchValue = '';

  SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade900,
          elevation: 0,
          title: TextFormField(
            onChanged: (value) {
              _searchValue = value;
            },
            decoration: const InputDecoration(
              labelText: 'Search For Products',
              labelStyle: TextStyle(
                color: Colors.white,
                letterSpacing: 4,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: _searchValue ==''? const Center(child: Text('Search For Products',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,letterSpacing: 5)),) : 
        StreamBuilder<QuerySnapshot>(
            stream: _productsStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

              final searchData = snapshot.data!.docs.where(
                (element) {
                  return element['productName']
                      .toLowerCase()
                      .contains(_searchValue.toLowerCase());
                },
              );

              return Column(
                children: searchData.map((e) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ProductDetailScreen(productData: e);
                      },));
                    },
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(e['imageUrl'][0]),
                          ),
                          Column(
                            children: [
                              Text(
                                e['productName'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold,color: Colors.yellow.shade900),
                              ),
                              Text(e['productPrice'].toStringAsFixed(2),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.yellow.shade900),)
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }));
  }
}
