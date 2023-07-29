import 'package:flutter/material.dart';

import '../utils/dimension.dart';

class DayColumn extends StatelessWidget {
  const DayColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height:Dimension.getScreenHeight()*.7,
      width: Dimension.getWidth(25),
      decoration: BoxDecoration(
          color: Colors.amberAccent
      ),
    );
  }
}
