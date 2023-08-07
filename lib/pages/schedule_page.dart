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
  late String json;
  late List<dynamic>  data;
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
     json = """
   [
 {"StTime":0,"ComfortSetting":"Off"},
 {"StTime":1080,"ComfortSetting":"Sleep"},
 {"StTime":1460,"ComfortSetting":"Home"},
 {"StTime":2000,"ComfortSetting":"Away"},
 {"StTime":2560,"ComfortSetting":"Home"},
 {"StTime":2800,"ComfortSetting":"Sleep"},
 {"StTime":3400,"ComfortSetting":"Away"},
 {"StTime":3460,"ComfortSetting":"Home"},
 {"StTime":3800,"ComfortSetting":"Sleep"},
 {"StTime":4200,"ComfortSetting":"Off"},
 {"StTime":4320,"ComfortSetting":"Away"},
 {"StTime":5785,"ComfortSetting":"Off"},
 {"StTime":5894,"ComfortSetting":"Home"},
 {"StTime":6798,"ComfortSetting":"Sleep"}
 
]
""";

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

    List<Time> times = [];

    data = jsonDecode(json);

    for (var element in data) {
      times.add(Time.fromJson(element));
    }
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
           Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: (){
                  showDialog(context: context, barrierDismissible: false,builder: (BuildContext context){
                    return  AlertDialog(
                      backgroundColor: Colors.white,
                      title: Icon(Icons.error,color: Colors.red.shade900,size: 32),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),

                      actions:  [
                        Column(
                          children: [
                            const Text("Delete Schedule",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                fontSize: 32
                            )),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                              child: Text(
                                'all events from your schedule will be permanently deleted. Are you sure you want to delete your schedule?',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontFamily: 'Poppins'
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 24
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            json = """
                                             [
                                              {"StTime":0,"ComfortSetting":"Off"}
                                             ]
                                             """;
                                            data = jsonDecode(json);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "Delete",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 24,
                                            color: Color(0xffF94892),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],

                              ),
                            )
                          ],
                        )
                      ],

                    );
                  });
                },
                child: const Icon(
                  Icons.delete,
                  size: 26,
                ),
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
            SizedBox(
              height: Dimension.getScreenHeight() * .8,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: Dimension.getWidth(8)),
                    height: Dimension.getScreenHeight() *.8,
                    width: Dimension.getScreenWidth() * .15,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(height: Dimension.getScreenHeight() * 8/100,child: const UsedText(text: "")),
                          ...hours(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Dimension.getScreenHeight() *.8,
                    width: Dimension.getScreenWidth() * .85,
                    padding: EdgeInsets.only(
                        right: Dimension.getWidth(26)),
                    child:   Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: Dimension.getScreenHeight() * 8/100,
                                child: const Center(child: UsedText(text: "Mon")),
                              ),
                              Container(
                                  height:
                                      Dimension.getScreenHeight() * 72 / 100,
                                  child: DayColumn(
                                    times: times,
                                    day: 0,
                                    disable: _checked,
                                    isMonday: true,
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: Dimension.getScreenHeight() * 8/100,
                                child: const Center(child: UsedText(text: "Tue")),
                              ),
                              Container(
                                height: Dimension.getScreenHeight() * 72/100,
                                child: DayColumn(
                                    times: times,
                                    day: 1,
                                    disable: _checked
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(height: Dimension.getScreenHeight() * 8/100,child: const Center(child: UsedText(text: "Wed"))),
                              Container(
                                height: Dimension.getScreenHeight() * 72/100,
                                child: DayColumn(
                                  times: times,
                                    day: 2,
                                    disable: _checked
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(height: Dimension.getScreenHeight() * 8/100,child: const Center(child: UsedText(text: "Thu"))),
                              Container(
                                height: Dimension.getScreenHeight() * 72/100,
                                child: DayColumn(
                                  times: times,
                                    day: 3,
                                    disable: _checked
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(height: Dimension.getScreenHeight() * 8/100,child: const Center(child: UsedText(text: "Fri"))),
                              Container(
                                height: Dimension.getScreenHeight() * 72/100,
                                child: DayColumn(
                                  times : times,
                                    day: 4,
                                    disable: _checked
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(height: Dimension.getScreenHeight() * 8/100,
                                  child: const Center(child: UsedText(text: "Sat"))),
                              Container(
                                height: Dimension.getScreenHeight() * 72/100,
                                child: DayColumn(
                                  times: times,
                                    day: 5,
                                    disable: _checked
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                  height: Dimension.getScreenHeight() * 8 / 100,
                                  child: const Center(
                                      child: UsedText(text: "Sun"))),
                              Container(
                                height: Dimension.getScreenHeight() * 72 / 100,
                                child: DayColumn(
                                  times: times,
                                    day: 6,
                                    disable: _checked
                                ),
                              ),
                            ],
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
