import 'package:flutter/material.dart';

class demo extends StatefulWidget {
  const demo({super.key});

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.network("https://storage.googleapis.com/eat-and-share-4f0a0.appspot.com/images/1715367002496"),
    );
  }
}