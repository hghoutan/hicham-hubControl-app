import 'package:flutter/material.dart';
import 'package:hub_control/Widgets/paints/add_button_.dart';
import 'package:hub_control/Widgets/paints/remove_button.dart';
import 'package:hub_control/Widgets/paints/scale_controller.dart';
import 'package:hub_control/Widgets/paints/thermo.dart';

import '../pages/first_page.dart';
import '../utils/dimension.dart';
import '../Widgets/day_column.dart' as main;

class HomeThermometer extends StatefulWidget {
  final FirstPageState firstPage;
  const HomeThermometer({super.key,required this.firstPage});

  @override
  State<HomeThermometer> createState() => _HomeThermometerState();
}

class _HomeThermometerState extends State<HomeThermometer> {

  late double _i;
  late double n = 41;
  @override
  void initState() {
    super.initState();
    setState(() {
      _i = 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    Offset offset = Offset(Dimension.getScreenHeight() * 45/100 - (Dimension.getScreenHeight() * _i/100), 0);
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
            top: offset.dx,
            left: 0,
            child: GestureDetector(
              onPanUpdate: (details){
                setState(() {
                 if (details.delta.dy > 0) {
                     if (_i > 10.5) {
                       setState(() {
                         _i = _i - ((details.delta.dy * 0.64)/13);
                       });
                       if (n > 41 ) {
                         n = n - (details.delta.dy/13);
                         widget.firstPage.setTemp(n.floor());
                       }
                     }
                 }
                 else{
                   if (_i < 41) {
                     setState(() {
                       _i = _i - ((details.delta.dy * 0.64)/13);
                     });
                     if (n < 90 ) {
                       n = n - (details.delta.dy/13);
                       widget.firstPage.setTemp(n.ceil());
                     }
                   }

                 }

                });
              },
              behavior: HitTestBehavior.translucent,
              child: SizedBox(
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
                if (_i < 41) {
                  setState(() {
                    _i = _i + 0.64;
                  });
                  if (n < 89 ) {
                    n ++;
                    widget.firstPage.setTemp(n.ceil());
                  }
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
                if (_i > 10.5) {
                  setState(() {
                    _i = _i - 0.64;
                  });
                  if (n > 41) {
                    n--;
                    widget.firstPage.setTemp(n.floor());
                  }

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
