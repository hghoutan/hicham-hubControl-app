

import 'package:flutter/material.dart';
import 'package:hub_control/utils/dimension.dart';

class CircularDay extends StatelessWidget {
  final String day;
  final bool active;
  const CircularDay({super.key,required this.day,required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimension.getScreenHeight() * 5.5/100,
      width: Dimension.getScreenHeight() * 5.5/100,
      decoration: BoxDecoration(
        color: active ? const Color(0xffF94892): null,
        borderRadius: BorderRadius.circular(Dimension.getScreenHeight() * 2.75/100),
        border: Border.all(width: 1,color: active ? Colors.white : Colors.black54)

      ),
      child:  Center(
        child: Text(
          day,
          style:  TextStyle(
            fontSize: 22,
            color: active ? Colors.white : null
          ),

        ),
      ),
    );
  }
}
