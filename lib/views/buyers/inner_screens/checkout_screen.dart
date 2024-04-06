import 'package:app_store/provider/cart_provider.dart';
import 'package:app_store/views/buyers/inner_screens/edit_profile.dart';
import 'package:app_store/views/buyers/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
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
              elevation: 0,
              backgroundColor: Colors.yellow.shade900,
              title: const Text(
                'Checkout',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: ListView.builder(
                shrinkWrap: true,
                itemCount: cartProvider.getCartItem.length,
                itemBuilder: (context, index) {
                  final cartData =
                      cartProvider.getCartItem.values.toList()[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: SizedBox(
                        height: 170,
                        child: Row(children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(cartData.imageUrl[0]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartData.productName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 5,
                                  ),
                                ),
                                Text(
                                  '\$' +
                                      " " +
                                      cartData.price.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 5,
                                    color: Colors.yellow.shade900,
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: null,
                                  child: Text(
                                    cartData.productSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                  );
                }),
            bottomSheet: data['address'] == ''
                ? TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return EditProfileScreen(
                          userData: data,
                        );
                      })).whenComplete(() {
                        Navigator.pop(context);
                      });
                    },
                    child: const Text('Enter Billing Address'))
                : Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: InkWell(
                      onTap: () {
                        EasyLoading.show(status: 'Placing Order');

                        ///we want to be able to place order, but now know ,in future
                        ///
                        cartProvider.getCartItem.forEach((key, item) {
                          final orderId = const Uuid().v4();
                          firestore.collection('orders').doc(orderId).set({
                            'orderId': orderId,
                            'vendorId': item.vendorId,
                            'email': data['email'],
                            'phone': data['phoneNumber'],
                            'address': data['address'],
                            'buyerId': data['buyerId'],
                            'fullName': data['fullName'],
                            'buyerPhoto': data['profileImage'],
                            'productName': item.productName,
                            'productPrice': item.price,
                            'productId': item.productId,
                            'productImage': item.imageUrl,
                            'quantity': item.productQuantity,
                            'productSize': item.productSize,
                            'scheduleDate': item.scheduleDate,
                            'orderDate': DateTime.now(),
                            'accepted': false,
                          }).whenComplete(() {
                            setState(() {
                              cartProvider.getCartItem.clear();
                            });
                            EasyLoading.dismiss();
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const MainScreen();
                            }));
                          });
                        });
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade900,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'PLACE ORDER',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 6,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        }

        return Center(
          child: CircularProgressIndicator(
            color: Colors.yellow.shade900,
          ),
        );
      },
    );
  }
}
