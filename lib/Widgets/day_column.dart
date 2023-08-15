
import 'package:flutter/material.dart';
import '../model/time.dart';
import '../utils/Constants.dart';
import '../utils/dimension.dart';
import 'package:collection/collection.dart';

class DayColumn extends StatelessWidget {
  final List<Time> times;
  final int day;
  final bool disable;
  final bool isMonday;
  const DayColumn({required this.times,required this.day, this.disable = false, this.isMonday = false,super.key});



  @override
  Widget build(BuildContext context) {

    late List<Widget> children;
    late List<Time> dayTimes;
    Time? oldTime;
    dayTimes = [];

    late Color? color;
    children = [];
    var total = 0.0;

    //region Func
    void fillData(){
      times.forEachIndexed((index, element) {
        int stTime = element.stTime!;
        String setting = element.comfortSetting!;
        switch(day){
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
                oldTime = times[index - 1];
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
                oldTime = times[index - 1];
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
                oldTime = times[index - 1];
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
                oldTime = times[index - 1];
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
                oldTime = times[index - 1];
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
                oldTime = times[index - 1];
              }
              dayTimes.add(Time(stTime: stTime - (1440 * 6),comfortSetting: setting));
            }
            break;

        }


      });
    }
    void handleOldTime(){
      if (oldTime == null) {
        return;
      }
      Color? oldColor = Constants.appColors[oldTime!.comfortSetting];
      if (dayTimes.isEmpty) {
        children.add(
            Container(
              height:  Dimension.getScreenHeight() * 72/100,
              width: Dimension.getScreenWidth(),
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(6.0),
                color: disable ? Constants.disableColors[oldTime!.comfortSetting] : oldColor!,
              ),
            )
        );
      }else{
        int startTime = 0;
        int endTime =   dayTimes[0].stTime!;
        total = total + ((endTime - startTime)/1440);
        children.add(
            Container(
              height: ((endTime - startTime)/1440) * Dimension.getScreenHeight() * 72/100,
              width: Dimension.getScreenWidth(),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(6.0),topLeft: Radius.circular(6.0)),
                color: disable ? Constants.disableColors[oldTime!.comfortSetting] : oldColor!,
              ),
            )
        );
      }
    }
    void isFirstAndLastTime(int i){
      if (dayTimes.length != 1) return;
      if (dayTimes[i].stTime == 0) return;
      if (!isMonday) return;
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
              color:Constants.appColors['Off'],
            ),
          )
      );
    }
    void isFirstTime(int i){
      if (dayTimes[i].stTime == 0) return;
      if (!isMonday) return;
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
              color:Constants.appColors['Off'],
            ),
          )
      );
    }
    void handleDayColumn(){
      if (dayTimes.isEmpty) {
        return;
      }
      for (var i=0;i<dayTimes.length;i++){
        color = Constants.appColors[dayTimes[i].comfortSetting];
        if (dayTimes[i].stTime == dayTimes[dayTimes.length - 1].stTime ){
          isFirstAndLastTime(i);
          children.add(
              Container(
                height: (1 - total ) * Dimension.getScreenHeight() * 72/100,
                width:Dimension.getScreenWidth(),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(6.0),bottomLeft: Radius.circular(6.0)),
                  color:disable ? Constants.disableColors[dayTimes[i].comfortSetting] : color!,
                ),
              )
          );
        }
        else if (dayTimes[i].stTime == dayTimes[0].stTime) {
          isFirstTime(i);

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
                  color: disable ? Constants.disableColors[dayTimes[i].comfortSetting] : color!,
                ),
              )
          );
        }
        else{
          int startTime = dayTimes[i].stTime!;
          int endTime =  dayTimes[i+1].stTime!;
          total = total + ((endTime - startTime)/1440);
          children.add(
              Container(
                height: ((endTime - startTime) /1440) * Dimension.getScreenHeight() * 72/100,
                width:Dimension.getScreenWidth(),
                color:disable ? Constants.disableColors[dayTimes[i].comfortSetting] : color!,
              )
          );

        }
      }
    }
    //endregion

    fillData();
    handleOldTime();
    handleDayColumn();

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

