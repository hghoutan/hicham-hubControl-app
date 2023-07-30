import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hub_control/Widgets/home_button.dart';
import 'package:hub_control/utils/dimension.dart';

import '../Widgets/scale_controller.dart';
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
        title: const Text("HubControl"),
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
            top: Dimension.getHeight(48),
            right: Dimension.getHeight(48),
            child: Stack(
              children: [
              Container(
                width: Dimension.getHeight(180),
                height: Dimension.getHeight(180),
                child: const HomeButton(),
              ),
                SizedBox(
                  width: Dimension.getHeight(180),
                  height: Dimension.getHeight(180),
                  child: Center(
                    child: Container(
                      width: Dimension.getHeight(150),
                      height: Dimension.getHeight(150),
                      child:  Column(
                        children: [
                          SizedBox(
                            height: Dimension.getHeight(15),
                          ),
                          const Text(
                            "Off",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(
                            height: Dimension.getHeight(10),
                          ),
                          const Text(
                            "Turn on in",
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const Text(
                            "Mode",
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      )
                    ),
                  ),
                ),
            ]
            ),
          ),
          Center(
            child: Stack(
            children:[
              Container(
              width: Dimension.getWidth(120),
              height: Dimension.getHeight(600),
                child: const Thermometer(),
              ),
              Positioned(
                  top:  Dimension.getHeight(600) * 0.5/6,
                  left:Dimension.getWidth(120) * 1.5/6,
                  bottom: Dimension.getHeight(600) * 1/6,
                  child: Image.asset("assets/images/scale.png",fit: BoxFit.fill, )
              ),
              Container(
                width: Dimension.getWidth(120),
                height: Dimension.getHeight(600),
                child: CustomPaint(
                  foregroundPainter: ScaleController(),
                ),
              ),

            ],
        ),
          ),
        ]
      )
    );
  }
}


