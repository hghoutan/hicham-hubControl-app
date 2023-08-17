import 'package:flutter/material.dart';
import 'package:hub_control/Widgets/day_column.dart';
import 'package:hub_control/Widgets/used_text.dart';
import 'package:hub_control/model/time.dart';
import 'package:hub_control/utils/Constants.dart';
import 'package:hub_control/utils/dimension.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/hubControl_provider.dart';
import 'add_event.dart';
import 'auth.dart';

class SchedulePage extends StatefulWidget {
  final String userName;
  final BuildContext cntx;
  final bool? fromNavigator;
   const SchedulePage(this.userName, this.cntx, this.fromNavigator,{super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}
class _SchedulePageState extends State<SchedulePage> {

  late ValueNotifier<bool> _controller;
  bool _checked = false;
  late List<Time> times;

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
    times = [];
    initTimes();

  }
  initTimes()async{
    times = await HubControlDbProvider.db.getAllTimes();
    setState(() {
      times = times;
    });
  }
  addSchedule(Time time,) async{
    await HubControlDbProvider.db.insertTime(time);
    initTimes();

  }
  @override
  Widget build(BuildContext context) {

    times.sort((a, b) => a.stTime!.compareTo(b.stTime!),);
    AdvancedSwitch(
      controller: _controller,
    );
    for (var element in times) {
      print("${element.stTime} - ${element.comfortSetting} - UserCode: ${element.userPairCode}");
    }
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

    Future<void> clearData() async{
      await HubControlDbProvider.db.clearDb();
      times = [];
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userName.isNotEmpty ? widget.userName: "HubControl",
        ),
        backgroundColor: const Color(0xffF94892),
        leading: GestureDetector(
          onTap: () async{
            print("entered");
            SharedPreferences s = await SharedPreferences.getInstance();
            await s.remove("PairCode");
            if (widget.fromNavigator == true) {
              Navigator.pop(widget.cntx);
              return;
            }
            Navigator.pushReplacement(widget.cntx, MaterialPageRoute(
                        builder: (builder) =>  AuthenticationPage()));
          },
          child: const Icon(
            Icons.power_settings_new,
            size: 26,
          ),
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
                                            clearData();
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
                  // addSchedule(Time(stTime: 2300,comfortSetting: "Off"));
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddEvent(addSchedule)));
                },
                child: const Icon(
                  Icons.add,
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
                          SizedBox(height: Dimension.getScreenHeight() * 8/100,child: const UsedText(text: "")),
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
                              SizedBox(
                                height: Dimension.getScreenHeight() * 8/100,
                                child: const Center(child: UsedText(text: "Mon")),
                              ),
                              SizedBox(
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
                              SizedBox(
                                height: Dimension.getScreenHeight() * 8/100,
                                child: const Center(child: UsedText(text: "Tue")),
                              ),
                              SizedBox(
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
                              SizedBox(height: Dimension.getScreenHeight() * 8/100,child: const Center(child: UsedText(text: "Wed"))),
                              SizedBox(
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
                              SizedBox(height: Dimension.getScreenHeight() * 8/100,child: const Center(child: UsedText(text: "Thu"))),
                              SizedBox(
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
                              SizedBox(height: Dimension.getScreenHeight() * 8/100,child: const Center(child: UsedText(text: "Fri"))),
                              SizedBox(
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
                              SizedBox(height: Dimension.getScreenHeight() * 8/100,
                                  child: const Center(child: UsedText(text: "Sat"))),
                              SizedBox(
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
                              SizedBox(
                                  height: Dimension.getScreenHeight() * 8 / 100,
                                  child: const Center(
                                      child: UsedText(text: "Sun"))),
                              SizedBox(
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
