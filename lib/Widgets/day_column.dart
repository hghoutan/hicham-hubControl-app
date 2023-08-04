import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/time.dart';
import '../utils/Constants.dart';
import '../utils/dimension.dart';

class DayColumn extends StatefulWidget {

  final List<Time> times;
  late  Time? oldTime ;
  final bool disable;
  DayColumn({required this.times,super.key, this.oldTime,this.disable = false});

  @override
  State<DayColumn> createState() => _DayColumnState();
}

class _DayColumnState extends State<DayColumn> {
  List<Widget> children = [
  ];
@override
  void initState() {
  super.initState();

  }
  @override
  Widget build(BuildContext context) {
    late Color color = const Color(0xffD2D2D2);
    children = [];
    var total = 0.0;
    if (widget.oldTime != null) {
      if (widget.oldTime!.stTime != 0 ) {
        Color? oldColor;
        switch(widget.oldTime!.comfortSetting) {
          case "Off":
            oldColor = const Color(0xffD2D2D2);
            break;
          case "Sleep":
            oldColor = const Color(0xfffbbd2d);
            break;
          case "Home":
            oldColor = const Color(0xffFDA629);
            break;
          case "Away":
            oldColor = const Color(0xffEABD25);
            break;
          case "Other":
            oldColor = const Color(0xffD2D2D2);
            break;
        }
        children.add(
            Container(
              height:  Dimension.getScreenHeight() * .7,
              width: Dimension.getScreenWidth(),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(6.0),topLeft: Radius.circular(6.0)),
                color: oldColor!,
              ),
            )
        );
        // total = total + (widget.times[0].stTime!/ 1440) * Dimension.getScreenHeight() * .7;
      }

    }

    if (widget.times.isNotEmpty ) {
      for (var i=0;i<widget.times.length;i++){
        switch(widget.times[i].comfortSetting) {
          case "Off":
            color = const Color(0xffD2D2D2);
            break;
          case "Sleep":
            color = const Color(0xfffbbd2d);
            break;
          case "Home":
            color = const Color(0xffFDA629);
            break;
          case "Away":
            color = const Color(0xffEABD25);
            break;
          case "Other":
            color = const Color(0xffD2D2D2);
            break;

        }
        if (widget.times[i].stTime == widget.times[0].stTime) {
          children.add(
              Container(
                height:  Dimension.getScreenHeight() * .7
                    - (((widget.times[i].stTime!)/ 1440) * Dimension.getScreenHeight() * .7),
                width: Dimension.getScreenWidth(),
                decoration: BoxDecoration(
                  borderRadius:  widget.oldTime == null ?
                  const BorderRadius.only(topRight: Radius.circular(6.0),topLeft: Radius.circular(6.0)) :
                  const BorderRadius.only(topRight: Radius.circular(0.0),topLeft: Radius.circular(0.0)),
                  color: widget.disable ? Colors.black26 : color,
                ),
              )
          );
          // total = total + ((widget.times[i + 1].stTime! - widget.times[i].stTime!)/ 1440) * Dimension.getScreenHeight() * .7;
        }
        // else if (widget.times[i].stTime == widget.times[widget.times.length - 1].stTime ) {
        //   children.add(
        //       Container(
        //         height:Dimension.getScreenHeight() * .7 - total,
        //         width:Dimension.getScreenWidth(),
        //         decoration: BoxDecoration(
        //           borderRadius: const BorderRadius.only(bottomRight: Radius.circular(6.0),bottomLeft: Radius.circular(6.0)),
        //           color:color,
        //         ),
        //       )
        //   );
        // }
        else {
          children.add(
              Container(
                height:
                Dimension.getScreenHeight() * .72
                    - (((widget.times[i].stTime!)/ 1440) * Dimension.getScreenHeight() * .7),
                width:Dimension.getScreenWidth(),
                color:color,
              )
          );
          // total = total + ((widget.times[i + 1].stTime! - widget.times[i].stTime!)/ 1440) * Dimension.getScreenHeight() * .7;

        }

      }
    }
    else{
      children.add(
          Container(
        height:  Dimension.getScreenHeight() * .7,
        width: Dimension.getScreenWidth(),
        decoration: BoxDecoration(
          borderRadius:  widget.oldTime == null ?
          BorderRadius.circular(6.0) :
          const BorderRadius.only(topRight: Radius.circular(0.0),topLeft: Radius.circular(0.0)),
          color: Constants.appColors['Off'],
        ),
      )
      );
    }


    return  Container(
      margin: EdgeInsets.symmetric(horizontal: Dimension.getScreenWidth() * 3/100),
      height:Dimension.getScreenHeight()*.7,
      width: Dimension.getScreenWidth() * 50/100,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
          color: Constants.appColors['Off'],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ...children,
        ],
      ),
    );
  }
}
