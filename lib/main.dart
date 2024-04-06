import 'dart:io';
import 'package:app_store/provider/cart_provider.dart';
import 'package:app_store/vendor/provider/product_provider.dart';
import 'package:app_store/vendor/views/auth/vendor_auth_screen.dart';
import 'package:app_store/vendor/views/screens/main_vendor_screen.dart';
import 'package:app_store/views/buyers/auth/login_screen.dart';
import 'package:app_store/views/buyers/main_screen.dart';
import 'package:app_store/views/buyers/nav_screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyDUMxyyqqcevlfzRRPQ70MgC-3SLoQOttA",
              appId: "1:65116904318:android:7829bf1498b45fa424712f",
              messagingSenderId: "65116904318",
              projectId: "store-f6c88",
              storageBucket: "gs://store-f6c88.appspot.com"),
        )
      : await Firebase.initializeApp();
      
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) {
      return ProductProvider();
    }),
    ChangeNotifierProvider(create: (_) {
      return CartProvider();
    })
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const VendorAuthScreen());
  }
}
