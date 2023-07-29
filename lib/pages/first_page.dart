import 'package:flutter/material.dart';

import '../Widgets/thermo.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HubControle"),
        backgroundColor: const Color(0xffF94892),
        leading: const Icon(
          Icons.menu,
          size: 26,
        ),
        actions: const [
          Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.settings,
                size: 26,
              ))
        ],
      ),
      body: Stack(
        children: [
        Positioned(
        left: 25,
        top: 50,
        width: 125,
        height: 400,
        child: Card(
          elevation: 6,
          child: Thermo(
            duration: const Duration(milliseconds: 1250),
            color: i.isOdd? Colors.red : Colors.green,
            value: i.isOdd? 0.9 : 0.1,
            curve: Curves.easeInOut,
          ),
        ),
      ),
      ]
    ),
    );
  }
}
