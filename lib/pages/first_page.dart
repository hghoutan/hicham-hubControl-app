import 'package:flutter/material.dart';

import '../utils/thermo.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

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
      body: Center(
        child: Container(
          height: 490,
          width: 100,
          child: Stack(
            children: [
              Center(
                child: Positioned(
                  top: 0,
                  child: Container(
                    height: 300,
                    width: 50,
                    decoration: const BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius:  BorderRadius.all(Radius.circular(50)),
                    ),
                  )),
              Center(
                child: Container(
                  width: 225,
                ),
              )
            ],
          ),
        ),
        // child: ThermometerWidget(
        //     borderColor: Colors.red,
        //     innerColor: Colors.green,
        //     indicatorColor: Colors.red,
        //   ),
      ),
    );
  }
}
