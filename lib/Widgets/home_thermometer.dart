import 'package:flutter/material.dart';
import 'package:hub_control/Widgets/scale_controller.dart';
import 'package:hub_control/Widgets/thermo.dart';

import '../utils/dimension.dart';

class HomeThermometer extends StatefulWidget {
  const HomeThermometer({super.key});

  @override
  State<HomeThermometer> createState() => _HomeThermometerState();
}

class _HomeThermometerState extends State<HomeThermometer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Container(
          width: Dimension.getScreenWidth() * 17/100,
          height: Dimension.getScreenHeight() * 45/100,
          child: const Thermometer(),
        ),
        Positioned(
            top:  (Dimension.getScreenHeight() * 45/100 )* 0.5/6,
            left:(Dimension.getScreenWidth() * 17/100) * 1.5/6,
            bottom:  (Dimension.getScreenHeight() * 45/100) * 1/6,
            child: Image.asset("assets/images/scale.png",fit: BoxFit.fill, )
        ),
        Container(
          width: Dimension.getScreenWidth() * 17/100,
          height: Dimension.getScreenHeight() * 45/100,
          child: CustomPaint(
            foregroundPainter: ScaleController(),
          ),
        ),

      ],
    );
  }
}
