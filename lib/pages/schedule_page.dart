import 'package:flutter/material.dart';
import 'package:hub_control/Widgets/day_column.dart';
import 'package:hub_control/Widgets/used_text.dart';
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
      const UsedText(text: "12 AM"),
      const UsedText(text: "1 AM"),
      const UsedText(text: "2 AM"),
      const UsedText(text: "3 AM"),
      const UsedText(text: "4 AM"),
      const UsedText(text: "5 AM"),
      const UsedText(text: "6 AM"),
      const UsedText(text: "7 AM"),
      const UsedText(text: "8 AM"),
      const UsedText(text: "9 AM"),
      const UsedText(text: "10 AM"),
      const UsedText(text: "11 AM"),
      const UsedText(text: "12 AM"),
      const UsedText(text: "1 PM"),
      const UsedText(text: "2 PM"),
      const UsedText(text: "3 PM"),
      const UsedText(text: "4 PM"),
      const UsedText(text: "5 PM"),
      const UsedText(text: "6 PM"),
      const UsedText(text: "7 PM"),
      const UsedText(text: "8 PM"),
      const UsedText(text: "9 PM"),
      const UsedText(text: "10 PM"),
      const UsedText(text: "11 PM"),
      const UsedText(text: "12 AM"),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("HubControle",),
        backgroundColor: const Color(0xffF94892),
        leading: const Icon(
          Icons.menu,
          size: 26,
        ),
        actions: const [
          Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.delete,
                size: 26,
              )),
          Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.settings,
                size: 26,
              ))
        ],
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: Dimension.getHeight(26)),
              child:  Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only( left: Dimension.getWidth(16)),
                    width: Dimension.getScreenWidth()*.15,
                  ),
                  Container(
                    width: Dimension.getScreenWidth()*.85,
                    padding: EdgeInsets.only( left: Dimension.getWidth(16) ,right:Dimension.getWidth(26)  ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UsedText(text: "Mon"),
                        UsedText(text: "Tue"),
                        UsedText(text: "Wed"),
                        UsedText(text: "Thu"),
                        UsedText(text: "Fri"),
                        UsedText(text: "Sat"),
                        UsedText(text: "Sun"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
             SizedBox(
               height: Dimension.getScreenHeight()*.7,
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Container(
                     padding: EdgeInsets.only( left: Dimension.getWidth(16)),
                     width: Dimension.getScreenWidth()*.15,
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
                     height: Dimension.getScreenHeight()*.7,
                     width: Dimension.getScreenWidth()*.85,
                     padding: EdgeInsets.only( left: Dimension.getWidth(16) ,right:Dimension.getWidth(26)  ),
                     child: const Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         DayColumn(),
                         DayColumn(),
                         DayColumn(),
                         DayColumn(),
                         DayColumn(),
                         DayColumn(),
                         DayColumn(),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimension.getWidth(26),
                  vertical: Dimension.getHeight(32)
              ),
              child:  Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Center(
                        child: Text("Disable schedule",style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                      AdvancedSwitch(
                        controller: _controller,
                        activeColor: Colors.pinkAccent,
                        inactiveColor: Colors.black87,
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        width: 50.0,
                        height: 30.0,
                        enabled: true,
                        disabledOpacity: 0.5,
                      ),

                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(Constants.Disable_Schedule_Message,style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,

                    ),),
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
