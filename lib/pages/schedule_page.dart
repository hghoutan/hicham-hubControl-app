import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hub_control/Widgets/day_column.dart';
import 'package:hub_control/Widgets/used_text.dart';
import 'package:hub_control/model/time.dart';
import 'package:hub_control/utils/Constants.dart';
import 'package:hub_control/utils/dimension.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late var _controller;
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _controller = ValueNotifier<bool>(_checked);
    _controller.addListener(() {
      setState(() {
        if (_controller.value) {
          _checked = true;
        } else {
          _checked = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AdvancedSwitch(
      controller: _controller,
    );
    List<Widget> hours() => [
          const Expanded(child: UsedText(text: "12 AM")),
          const Expanded(
            child: UsedText(text: "1 AM"),
          ),
          const Expanded(
            child: UsedText(text: "1 AM"),
          ),
          const Expanded(
            child: UsedText(text: "2 AM"),
          ),
          const Expanded(
            child: UsedText(text: "3 AM"),
          ),
          const Expanded(
            child: UsedText(text: "4 AM"),
          ),
          const Expanded(
            child: UsedText(text: "5 AM"),
          ),
          const Expanded(
            child: UsedText(text: "6 AM"),
          ),
          const Expanded(
            child: UsedText(text: "7 AM"),
          ),
          const Expanded(
            child: UsedText(text: "8 AM"),
          ),
          const Expanded(
            child: UsedText(text: "9 AM"),
          ),
          const Expanded(
            child: UsedText(text: "10 AM"),
          ),
          const Expanded(
            child: UsedText(text: "11 AM"),
          ),
          const Expanded(
            child: UsedText(text: "12 AM"),
          ),
          const Expanded(
            child: UsedText(text: "1 PM"),
          ),
          const Expanded(
            child: UsedText(text: "2 PM"),
          ),
          const Expanded(
            child: UsedText(text: "3 PM"),
          ),
          const Expanded(
            child: UsedText(text: "3 PM"),
          ),
          const Expanded(
            child: UsedText(text: "4 PM"),
          ),
          const Expanded(
            child: UsedText(text: "5 PM"),
          ),
          const Expanded(
            child: UsedText(text: "6 PM"),
          ),
          const Expanded(
            child: UsedText(text: "7 PM"),
          ),
          const Expanded(
            child: UsedText(text: "8 PM"),
          ),
          const Expanded(
            child: UsedText(text: "9 PM"),
          ),
          const Expanded(
            child: UsedText(text: "10 PM"),
          ),
          const Expanded(
            child: UsedText(text: "11 PM"),
          ),
          const Expanded(
            child: UsedText(text: "12 AM"),
          ),
        ];

    String json = """
    [
 {"StTime":5,"ComfortSetting":"Off"},
 {"StTime":1080,"ComfortSetting":"Sleep"},
 {"StTime":1460,"ComfortSetting":"Home"},
 {"StTime":2000,"ComfortSetting":"Away"},
 {"StTime":2560,"ComfortSetting":"Home"},
 {"StTime":2800,"ComfortSetting":"Sleep"},
 {"StTime":3400,"ComfortSetting":"Away"},
 {"StTime":3460,"ComfortSetting":"Home"},
 {"StTime":3800,"ComfortSetting":"Sleep"},
 {"StTime":4200,"ComfortSetting":"Off"},
 {"StTime":4330,"ComfortSetting":"Sleep"},
 {"StTime":4700,"ComfortSetting":"Away"},
 {"StTime":5785,"ComfortSetting":"Off"},
 {"StTime":5894,"ComfortSetting":"Home"},
 {"StTime":6798,"ComfortSetting":"Sleep"}
   ]
""";

    List<Time> mondayTimes = [];

    List<Time> tuesdayTimes = [];

    List<Time> wednesdayTimes =[];
    List<Time> thursdayTimes = [];
    List<Time> fridayTimes = [];
    List<Time> sundayTimes = [];
    List<Time> saturdayTimes =[];

    List<dynamic>  data = jsonDecode(json);
    for(var i=0;i<=data.length-1;i++){
      if (int.parse(data[i]['StTime'].toString())>=0 && int.parse(data[i]['StTime'].toString())<= 1440) {
        mondayTimes.add(Time(stTime: int.parse(data[i]['StTime'].toString()),comfortSetting: data[i]["ComfortSetting"]));
      }
      else if (int.parse(data[i]['StTime'].toString())<= 2880){
        tuesdayTimes.add(Time(stTime: int.parse((data[i]['StTime'] - 1440).toString()),comfortSetting: data[i]["ComfortSetting"]));
      }else if (int.parse(data[i]['StTime'].toString())<= 4320){
        wednesdayTimes.add(Time(stTime: int.parse((data[i]['StTime'] - (1440 * 2)).toString()),comfortSetting: data[i]["ComfortSetting"]));
      }else if (int.parse(data[i]['StTime'].toString())<= 5760) {
        thursdayTimes.add(Time(stTime: int.parse((data[i]['StTime'] - (1440 * 3)).toString()),comfortSetting: data[i]["ComfortSetting"]));
      }else if (int.parse(data[i]['StTime'].toString())<= 7200) {
        fridayTimes.add(Time(stTime: int.parse((data[i]['StTime'] - (1440 * 4)).toString()),comfortSetting: data[i]["ComfortSetting"]));
      }else if(int.parse(data[i]['StTime'].toString())<= 8640){
        sundayTimes.add(Time(stTime: int.parse((data[i]['StTime'] - (1440 * 5)).toString()),comfortSetting: data[i]["ComfortSetting"]));
      }else{
        saturdayTimes.add(Time(stTime: int.parse((data[i]['StTime'] - (1440 * 6)).toString()),comfortSetting: data[i]["ComfortSetting"]));

      }
    }
    print(thursdayTimes[0].stTime);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HubControl",
        ),
        backgroundColor: const Color(0xffF94892),
        leading: const Icon(
          Icons.menu,
          size: 26,
        ),
        actions:  [
          const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.delete,
                size: 26,
              )),
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: (){
                },
                child: const Icon(
                  Icons.settings,
                  size: 26,
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: Dimension.getHeight(26)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: Dimension.getWidth(16)),
                    width: Dimension.getScreenWidth() * .15,
                  ),
                  Container(
                    width: Dimension.getScreenWidth() * .85,
                    padding: EdgeInsets.only(
                        left: Dimension.getWidth(16),
                        right: Dimension.getWidth(26)),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: UsedText(text: "Mon"),
                        ),
                        Expanded(
                          child: UsedText(text: "Tue"),
                        ),
                        Expanded(
                          child: UsedText(text: "Wed"),
                        ),
                        Expanded(
                          child: UsedText(text: "Thu"),
                        ),
                        Expanded(
                          child: UsedText(text: "Fri"),
                        ),
                        Expanded(
                          child: UsedText(text: "Sat"),
                        ),
                        Expanded(
                          child: UsedText(text: "Sun"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimension.getScreenHeight() * .7,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: Dimension.getWidth(8)),
                    width: Dimension.getScreenWidth() * .15,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...hours(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Dimension.getScreenHeight() * .7,
                    width: Dimension.getScreenWidth() * .85,
                    padding: EdgeInsets.only(
                        left: Dimension.getWidth(16),
                        right: Dimension.getWidth(26)),
                    child:   Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DayColumn(times: mondayTimes),
                        ),
                        Expanded(
                          child: DayColumn(
                              times: tuesdayTimes,
                              oldTime: mondayTimes[mondayTimes.length - 1]),
                        ),
                        Expanded(
                          child: DayColumn(
                            times: wednesdayTimes,
                            oldTime:  tuesdayTimes[tuesdayTimes.length - 1] ,
                          ),
                        ),
                        Expanded(
                          child: DayColumn(
                            times: thursdayTimes,
                            oldTime: wednesdayTimes[wednesdayTimes.length - 1] ,
                          ),
                        ),
                        Expanded(
                          child: DayColumn(
                            times : fridayTimes,
                            // oldTime: thursdayTimes[wednesdayTimes.length - 1],
                          ),
                        ),
                        Expanded(
                          child: DayColumn(
                            times: sundayTimes,
                            // oldTime: fridayTimes[mondayTimes.length - 1],
                          ),
                        ),
                        Expanded(
                          child: DayColumn(
                            times: saturdayTimes,
                            // oldTime: sundayTimes[mondayTimes.length - 1],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimension.getWidth(26),
                  vertical: Dimension.getHeight(32)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Center(
                        child: Text(
                          "Disable schedule",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      AdvancedSwitch(
                        controller: _controller,
                        activeColor: Colors.pinkAccent,
                        inactiveColor: Colors.black87,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        width: 50.0,
                        height: 30.0,
                        enabled: true,
                        disabledOpacity: 0.5,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      Constants.Disable_Schedule_Message,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
