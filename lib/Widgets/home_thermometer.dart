import 'package:flutter/material.dart';
import 'package:hub_control/Widgets/paints/add_button_.dart';
import 'package:hub_control/Widgets/paints/remove_button.dart';
import 'package:hub_control/Widgets/paints/scale_controller.dart';
import 'package:hub_control/Widgets/paints/thermo.dart';

import '../utils/dimension.dart';

class HomeThermometer extends StatefulWidget {
  const HomeThermometer({super.key});

  @override
  State<HomeThermometer> createState() => _HomeThermometerState();
}

class _HomeThermometerState extends State<HomeThermometer> {

  late int _i;
  @override
  void initState() {
    super.initState();
    setState(() {
      _i = 20;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimension.getScreenWidth() * 17/100,
      height: Dimension.getScreenHeight() * 45/100,
      child: Stack(
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
              child: Image.asset("assets/images/scale.png",fit: BoxFit.fill,)
          ),
          Positioned(
            top: Dimension.getScreenHeight() * 45/100 - Dimension.getScreenHeight() * _i/100 ,
            child: GestureDetector(
              onHorizontalDragDown: (details) {
              },
              child: Container(
                width: Dimension.getScreenWidth() * 17/100,
                height:20,
                child: CustomPaint(
                  foregroundPainter: ScaleController(),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right:0,
            child: InkWell(
              onTap: (){
                if (_i < 40) {
                  setState(() {
                    _i++;
                  });
                }
              },
              child: Container(
                width: Dimension.getScreenHeight() * 4/100,
                height: Dimension.getScreenHeight() * 4/100,
                // color: Colors.red,
                child: CustomPaint(
                  foregroundPainter: AddButton(),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: InkWell(
              onTap: (){
                if (_i > 10) {
                  setState(() {
                    _i--;
                  });
                }
              },
              child: Container(
                width: Dimension.getScreenHeight() * 4/100,
                height: Dimension.getScreenHeight() * 4/100,
                child: CustomPaint(
                  foregroundPainter: RemoveButton(),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
