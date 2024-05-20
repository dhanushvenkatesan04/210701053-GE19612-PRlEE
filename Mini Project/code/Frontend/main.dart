import 'package:flutter/material.dart';
import 'package:pree/pages/addFood.dart';
import 'package:pree/pages/demo.dart';
import 'package:pree/pages/login.dart';
import 'package:pree/pages/receiver/viewFood.dart';
import 'package:pree/provider/loginuid.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => loginuid(),)
    ],
    child: MaterialApp(
      // debugShowCheckedModeBanner: true,
      home: Center(child: Login()),
    ),
  ));
}

