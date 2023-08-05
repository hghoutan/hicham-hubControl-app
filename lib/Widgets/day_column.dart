import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/time.dart';
import '../utils/Constants.dart';
import '../utils/dimension.dart';
import 'package:collection/collection.dart';

class DayColumn extends StatefulWidget {
  final List<Time> times;
  final int day;
  final bool disable;
  final bool isMonday;
  const DayColumn({required this.times,required this.day, this.disable = false, this.isMonday = false,super.key});

  @override
  State<DayColumn> createState() => _DayColumnState();
}

class _DayColumnState extends State<DayColumn> {
  late List<Widget> children ;
   List<Time> dayTimes = [];
  Time? oldTime;

  @override
  void initState() {
  super.initState();
  widget.times.forEachIndexed((index, element) {
    int stTime = element.stTime!;
    String setting = element.comfortSetting!;
    switch(widget.day){
      case 0 :
        if (stTime >= 0 && stTime <= 1440) {
          dayTimes.add(Time(stTime: stTime, comfortSetting: setting));
        }
        break;
      case 1 :
        if (stTime >= 0 && stTime <= 1440) {
          oldTime = Time(stTime: stTime, comfortSetting: setting);
        }
        if (stTime > 1440 && stTime <= 2880) {
          if (oldTime == null){
            oldTime = widget.times[index - 1];
          }
          dayTimes.add(Time(stTime: stTime - 1440,comfortSetting: setting));
        }
        break;
      case 2 :
        if (stTime >= 0 && stTime <= 2880) {
          oldTime = Time(stTime: stTime, comfortSetting: setting);
        }
        if (stTime > 2880 && stTime <= 4320) {
          if (oldTime == null){
            oldTime = widget.times[index - 1];
          }
          dayTimes.add(Time(stTime: stTime - (1440 * 2),comfortSetting: setting));
        }
        break;
      case 3 :
        if (stTime >= 0 && stTime <= 4320) {
          oldTime = Time(stTime: stTime, comfortSetting: setting);
        }
        if (stTime > 4320 && stTime <= 5760) {
          if (oldTime == null){
            oldTime = widget.times[index - 1];
          }
          dayTimes.add(Time(stTime: stTime - (1440 * 3),comfortSetting: setting));
        }
        break;
      case 4 :
        if (stTime >= 0 && stTime <= 5760) {
          oldTime = Time(stTime: stTime, comfortSetting: setting);
        }
        if (stTime > 5760 && stTime <= 7200) {
          if (oldTime == null){
            oldTime = widget.times[index - 1];
          }
          dayTimes.add(Time(stTime: stTime - (1440 * 4),comfortSetting: setting));
        }
        break;
      case 5 :
        if (stTime >= 0 && stTime <= 7200) {
          oldTime = Time(stTime: stTime, comfortSetting: setting);
        }
        if (stTime > 7200 && stTime <= 8640) {
          if (oldTime == null){
            oldTime = widget.times[index - 1];
          }
          dayTimes.add(Time(stTime: stTime - (1440 * 5),comfortSetting: setting));
        }
        break;
      case 6:
        if (stTime >= 0 && stTime <= 8640) {
          oldTime = Time(stTime: stTime, comfortSetting: setting);
        }
        if (stTime > 8640 && stTime <= 10080) {
          if (oldTime == null){
            oldTime = widget.times[index - 1];
          }
          dayTimes.add(Time(stTime: stTime - (1440 * 6),comfortSetting: setting));
        }
        break;

    }


  });
  }

  @override
  Widget build(BuildContext context) {
    late Color color;
    children = [];
    var total = 0.0;
    if (dayTimes.isEmpty) {
      print("yes it's empty");
    }else{
      print("no it's empty");
    }
    if (oldTime != null) {
        Color? oldColor;
        switch(oldTime!.comfortSetting) {
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
        if (dayTimes.isEmpty) {
          print("yes it's empty");
          children.add(
              Container(
                height:  Dimension.getScreenHeight() * 72/100,
                width: Dimension.getScreenWidth(),
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(6.0),
                  color: oldColor!,
                ),
              )
          );
        }else{
          // print("no it's empty");
          int startTime = 0;
          int endTime =   dayTimes[0].stTime!;;
          total = total + ((endTime - startTime)/1440);
          children.add(
              Container(
                height: ((endTime - startTime)/1440) * Dimension.getScreenHeight() * 72/100,
                width: Dimension.getScreenWidth(),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(6.0),topLeft: Radius.circular(6.0)),
                  color: oldColor!,
                ),
              )
          );
        }  

    }


    if (dayTimes.isNotEmpty ) {
      for (var i=0;i<dayTimes.length;i++){
        switch(dayTimes[i].comfortSetting) {
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
        if (dayTimes[i].stTime == dayTimes[dayTimes.length - 1].stTime ) {
          // check if day has one time then add the lost one
          if (dayTimes.length == 1) {
            if (dayTimes[i].stTime != 0) {
              if (widget.isMonday) {
                int startTime = 0;
                int endTime =  dayTimes[i].stTime!;
                total = total + ((endTime - startTime)/1440);
                children.add(
                    Container(
                      height : ((endTime - startTime)/1440) * Dimension.getScreenHeight() * 72/100,
                      width: Dimension.getScreenWidth(),
                      decoration: BoxDecoration(
                        borderRadius:  oldTime == null ?
                        const BorderRadius.only(topRight: Radius.circular(6.0),topLeft: Radius.circular(6.0)) :
                        const BorderRadius.only(topRight: Radius.circular(0.0),topLeft: Radius.circular(0.0)),
                        color: widget.disable ? Colors.black26 : Constants.appColors['Off'],
                        //widget.isMond ? Constants.appColors['Off'] : Constants.appColors['Sleep'],
                      ),
                    )
                );
              }


            }
          }
          children.add(
              Container(
                height: (1 - total ) * Dimension.getScreenHeight() * 72/100,
                width:Dimension.getScreenWidth(),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(6.0),bottomLeft: Radius.circular(6.0)),
                  color:color,
                ),
              )
          );
        }
        else if (dayTimes[i].stTime == dayTimes[0].stTime) {
          if (dayTimes[i].stTime != 0) {
            if (widget.isMonday) {
              int startTime = 0;
              int endTime =  dayTimes[i].stTime!;
              total = total + ((endTime - startTime)/1440);
              children.add(
                  Container(
                    height : ((endTime - startTime)/1440) * Dimension.getScreenHeight() * 72/100,
                    width: Dimension.getScreenWidth(),
                    decoration: BoxDecoration(
                      borderRadius:  oldTime == null ?
                      const BorderRadius.only(topRight: Radius.circular(6.0),topLeft: Radius.circular(6.0)) :
                      const BorderRadius.only(topRight: Radius.circular(0.0),topLeft: Radius.circular(0.0)),
                      color: widget.disable ? Colors.black26 : Constants.appColors['Off'],
                    ),
                  )
              );
            }


          }

          int startTime = dayTimes[i].stTime!;
          int endTime =  dayTimes[i+1].stTime!;
          total = total + ((endTime - startTime)/1440);
          children.add(
              Container(
                height : ((endTime - startTime)/1440) * Dimension.getScreenHeight() * 72/100,
                width: Dimension.getScreenWidth(),
                decoration: BoxDecoration(
                  borderRadius:  oldTime == null ?
                  const BorderRadius.only(topRight: Radius.circular(6.0),topLeft: Radius.circular(6.0)) :
                  const BorderRadius.only(topRight: Radius.circular(0.0),topLeft: Radius.circular(0.0)),
                  color: widget.disable ? Colors.black26 : color,
                ),
              )
          );
          continue;
        }

        else {
          int startTime = dayTimes[i].stTime!;
          int endTime =  dayTimes[i+1].stTime!;
          total = total + ((endTime - startTime)/1440);
          children.add(
              Container(
                height: ((endTime - startTime) /1440) * Dimension.getScreenHeight() * 72/100,
                width:Dimension.getScreenWidth(),
                color:color,
              )
          );

        }

      }
    }
    // else{
    //   children.add(
    //       Container(
    //     height:  Dimension.getScreenHeight() *72/100,
    //     width: Dimension.getScreenWidth(),
    //     decoration: BoxDecoration(
    //       borderRadius:  oldTime == null ?
    //       BorderRadius.circular(6.0) :
    //       const BorderRadius.only(topRight: Radius.circular(0.0),topLeft: Radius.circular(0.0)),
    //       color: Constants.appColors['Off'],
    //     ),
    //   )
    //   );
    // }


    return  Container(
      margin: EdgeInsets.symmetric(horizontal: Dimension.getScreenWidth() * 3/100),
      height:Dimension.getScreenHeight()* 72/100,
      width: Dimension.getScreenWidth() * 50/100,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
          color: Constants.appColors['Off'],
      ),
      child: Column(
        children: [
          ...children,
        ],
      ),
    );
  }
}
