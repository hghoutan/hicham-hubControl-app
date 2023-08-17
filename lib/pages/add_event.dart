
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hub_control/Widgets/circular_day.dart';
import 'package:hub_control/model/add_event_radio.dart';
import 'package:hub_control/model/time.dart';
import 'package:hub_control/utils/dimension.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEvent extends StatefulWidget {
  final void Function(Time) addSchedule;
  const AddEvent( this.addSchedule, {super.key,});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _minuteController = TextEditingController();
  late String _state;
  late bool clicked;
  int day = 0;
  List<int> selectedDays = [];

  late DateTime date;
  late var hour ;
  late var minute ;
  late String clock;
  late SharedPreferences s ;

  void addRemoveFromList(int i){
    bool exist = false;
    for(int e in selectedDays){
      if (e == i) {
        exist = true;
      }
    }
    exist ? selectedDays.remove(i) : selectedDays.add(i);
  }
  late String _hourOrException ;
  late String  _minuteOrException;

  Future<void> initSharedPreferences()async {
    s = await SharedPreferences.getInstance();
  }
  @override
  void initState() {
    super.initState();
    date = DateTime.now();
    hour = DateFormat("h").format(date);
    minute = DateFormat("mm").format(date);
    var hour2 = DateFormat("hh").format(date);
    clock = DateFormat("a").format(date);

    _hoursController.text = hour2;
    _minuteController.text = minute;
    _state = "Home";
    clicked = false;
    _hourOrException = "Hour";
    _minuteOrException = "Minute";
    initSharedPreferences();
  }
  @override
  Widget build(BuildContext context) {

      List<AddEventRadio> radio_list = [
      AddEventRadio(state: "Off", leftColor: Colors.black12, rightColor: Colors.black12),
      AddEventRadio(state: "Home", leftColor: Colors.blueAccent, rightColor: Colors.lightBlueAccent),
      AddEventRadio(state: "Sleep", leftColor: Colors.yellow, rightColor: Colors.green),
      AddEventRadio(state: "Away", leftColor: Colors.orangeAccent, rightColor: Colors.redAccent),
      AddEventRadio(state: "Other", leftColor: Colors.black12, rightColor: Colors.black12),

    ];
    //todo: fix text go down after clicking on it

    AlertDialog  timeDialog(BuildContext context, void Function(void Function() p1) setState) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      actionsAlignment: MainAxisAlignment.start,
      actions: [
        Padding(
          padding: EdgeInsets.all(Dimension.getScreenWidth() * 2/100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("ENTER TIME",style: TextStyle(
                color: Colors.black54,
              )),
              SizedBox(height: Dimension.getScreenWidth() * .03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: Dimension.getScreenHeight() * 7.5/100,
                        width: Dimension.getScreenHeight() * 10/100,
                        decoration: BoxDecoration(
                          color:  Colors.black12,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          controller: _hoursController,
                          cursorColor: const Color(0xffF94892),
                          cursorHeight: Dimension.getScreenHeight() * .06,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged:(s) {
                            try{
                              if (int.parse(s) < 00 || int.parse(s) > 23 ) {
                                setState(() {
                                  _hourOrException = "Enter a valid time";
                                });
                              }else {
                                setState(() {
                                  _hourOrException = "Hour";
                                });
                              }
                            }catch(e){

                            }

                          },
                          onTap: (){

                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder:OutlineInputBorder(
                                borderSide: BorderSide(width: 2,color: Color(0xffF94892),
                                )
                            ),
                          ),
                          style: TextStyle(
                            fontSize:Dimension.getScreenHeight() * 5/100,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          _hourOrException,
                          style:  TextStyle(
                            color: _hourOrException == "Hour" ? Colors.black54 : Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimension.getScreenWidth() * .04,),
                      const Icon(Icons.access_time, size: 28,)
                    ],
                  ),
                   Padding(
                    padding: EdgeInsets.only(bottom: Dimension.getScreenHeight() * .06 , right: 12,left: 12),
                    child: const Text(":",style: TextStyle(fontSize: 80),),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Dimension.getScreenHeight() * 7.5/100,
                        width: Dimension.getScreenHeight() * 10/100,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8.0),

                        ),
                        child: TextField(
                          controller: _minuteController,
                          cursorColor: const Color(0xffF94892),
                          cursorHeight: Dimension.getScreenHeight() * .06,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged:(s) {
                            try{
                              if (int.parse(s) < 00 || int.parse(s) > 59 ) {
                                setState(() {
                                  _minuteOrException = "Enter a valid time";
                                });
                              }else {
                                setState(() {
                                  _minuteOrException = "Minute";
                                });
                              }
                            }catch(e){

                            }

                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder:OutlineInputBorder(
                                borderSide: BorderSide(width: 2,color: Color(0xffF94892),
                                )
                            ),
                          ),
                          style: TextStyle(
                            fontSize:Dimension.getScreenHeight() * 5/100,
                          ),
                        ),
                      ),
                       Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 8.0),
                        child: Text(
                          _minuteOrException,
                          style: TextStyle(
                            color: _minuteOrException == "Minute" ? Colors.black54 : Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimension.getScreenWidth() * .04,),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                                "CANCEL",
                                style: TextStyle(
                              color: Color(0xffF94892),
                              fontSize: 18

                            )),
                          ),
                          const SizedBox(width: 20,),
                          InkWell(
                            onTap: (){

                              if (
                              (int.parse(_hoursController.text) >= 00 && int.parse(_hoursController.text) < 24)
                              && (int.parse(_minuteController.text) >= 00 && int.parse(_minuteController.text) < 60)

                              ) {
                                setState(() {
                                  hour = _hoursController.text;
                                  minute = _minuteController.text.length ==1 ? "0${_minuteController.text}" :_minuteController.text  ;
                                  clock = int.parse(_hoursController.text) > 11 && int.parse(_minuteController.text) <= 23 ? "PM": "AM";
                                });
                                Navigator.of(context).pop();
                              }


                            },
                            child: const Text(
                                "OK",
                                style: TextStyle(
                                  color: Color(0xffF94892),
                                  fontSize: 18,
                                )
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                ],
              ),

            ],
          ),
        )
      ],
    );
    return  Scaffold(
      appBar: AppBar(
        //todo: fix Add Event position
        backgroundColor: const Color(0xffF94892),
        title: const Center(child: Text("Add Event", style: TextStyle(fontSize: 24))),
      ),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding:EdgeInsets.symmetric(vertical: 24,horizontal: 16),
            child: Text(
              "copy to",
                style: TextStyle(fontFamily: 'Poppins', color: Colors.black54,fontSize: 24)

            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28,),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                  onTap: () {
                    setState((){
                    addRemoveFromList(0) ;
                    });
                  },
                  child:  CircularDay(day: "Mon", active: selectedDays.contains(0) ? true : false),
                ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        addRemoveFromList(1) ;
                      });
                    },
                    child:  CircularDay(day: "Tue", active: selectedDays.contains(1)  ? true : false),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        addRemoveFromList(2) ;
                      });
                    },
                    child:  CircularDay(day: "Wed", active: selectedDays.contains(2)  ? true : false),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        addRemoveFromList(3) ;
                      });
                    },
                    child:  CircularDay(day: "Thu", active: selectedDays.contains(3)  ? true : false),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        addRemoveFromList(4) ;
                      });
                    },
                    child: CircularDay(day: "Fri", active: selectedDays.contains(4)  ? true : false),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        addRemoveFromList(5) ;
                      });
                    },
                    child: CircularDay(day: "Sat", active: selectedDays.contains(5)  ? true : false),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        addRemoveFromList(6) ;

                      });
                    },
                    child: CircularDay(day: "Sun",active: selectedDays.contains(6)  ? true : false),
                  ),
                ],
          ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                    "start time:",
                    style: TextStyle(fontFamily: 'Poppins', color: Colors.black54,fontSize: 24),

                ),
                InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (buildContext){
                      return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                        return timeDialog(buildContext,setState);
                      },
                      );
                    });
                    },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding:  const EdgeInsets.symmetric(horizontal: 24,vertical: 0),
                    width: hour == "00" ? Dimension.getScreenWidth() * .46 : Dimension.getScreenWidth() * .43,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          offset: Offset.zero
                        )
                      ],
                      borderRadius: BorderRadius.circular(12.0)
                    ) ,
                    child: Row(
                      children: [
                        Text("$hour:$minute",style: TextStyle(
                          color: Colors.black87,
                          fontSize: Dimension.getScreenWidth() * 10/100
                        ),),
                        //todo: set PM in same baseline of his brother
                         Padding(
                           padding:  EdgeInsets.symmetric(horizontal: Dimension.getScreenHeight() * .01),
                           child: Text(clock,style: TextStyle(
                              color: Colors.black87,
                              fontSize: Dimension.getScreenWidth() * 6/100
                        ),),
                         ),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
          SizedBox(height: Dimension.getScreenHeight() * .04,),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 12,horizontal: 16),
            child:  Text(
              "select the event type:",
              style: TextStyle(fontFamily: 'Poppins', color: Colors.black54,fontSize: 24),

            ),
          ),
          Container(
            height: Dimension.getScreenHeight() * .4,
            child: ListView.builder(
                itemCount: radio_list.length,
                itemBuilder:(_,index){
                  return InkWell(
                    onTap: (){
                      setState(() {
                        _state = radio_list[index].state;
                      });
                    },
                    child: ListTile(
                        title:  Text(radio_list[index].state,style: const TextStyle(fontSize: 24)),
                        contentPadding: EdgeInsets.symmetric(horizontal: Dimension.getScreenHeight() * .02),
                        shape: _state == radio_list[index].state ? RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          side: const BorderSide(width: 1,color: Colors.black12,style: BorderStyle.solid)
                        ):Border(
                          top: const BorderSide(width: 1,color: Colors.black12),
                          bottom: const BorderSide(width: 1,color: Colors.black12),
                          left: BorderSide(width: Dimension.getScreenHeight() * .02,color: radio_list[index].leftColor),
                          right: BorderSide(width: Dimension.getScreenHeight() * .02,color: radio_list[index].rightColor),
                        ),

                        leading: Radio(
                          activeColor: Colors.black,
                          value: radio_list[index].state,
                          groupValue: _state,
                          onChanged: (state){
                            setState(() {
                              _state = state!;
                            });
                            },
                        ),
                        trailing: Container(
                          width: Dimension.getScreenWidth() *.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.ac_unit_outlined,size: Dimension.getScreenHeight() * .03,color: Colors.black87,),
                              Text("50°",style: TextStyle(
                                  fontSize: Dimension.getScreenHeight()* .02
                              )),

                              SizedBox(width: Dimension.getScreenWidth() * .02,),

                              Icon(Icons.local_fire_department_outlined,size: Dimension.getScreenHeight() * .03,color: Colors.black87,),
                              Text("90°",style: TextStyle(
                                  fontSize: Dimension.getScreenHeight()* .02
                              )),
                            ],
                          ),
                        )


                    ),
                  );
                }
                ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: (){
                  for(int i =0; i<selectedDays.length;i++ ){
                    switch(selectedDays[i]){
                      case 0:
                        widget.addSchedule(Time(stTime: (int.parse(hour) * 60) + int.parse(minute),comfortSetting: _state, userPairCode: s.getString("PairCode")));
                        break;
                      case 1:
                        widget.addSchedule(Time(stTime: (int.parse(hour) *60) + int.parse(minute) + 1440,comfortSetting: _state , userPairCode: s.getString("PairCode")));
                        break;
                      case 2:
                        widget.addSchedule(Time(stTime: (int.parse(hour) *60) + int.parse(minute)+ (1440 * 2),comfortSetting: _state , userPairCode: s.getString("PairCode")));
                        break;
                      case 3:
                        widget.addSchedule(Time(stTime: (int.parse(hour) *60) + int.parse(minute)+ (1440 * 3),comfortSetting: _state, userPairCode: s.getString("PairCode")));
                        break;
                      case 4:
                        widget.addSchedule(Time(stTime: (int.parse(hour) *60) + int.parse(minute) + (1440 * 4),comfortSetting: _state, userPairCode: s.getString("PairCode")));
                        break;
                      case 5:
                        widget.addSchedule(Time(stTime: (int.parse(hour) *60) + int.parse(minute)+ (1440 * 5),comfortSetting: _state, userPairCode: s.getString("PairCode")));
                        break;
                      case 6:
                        widget.addSchedule(Time(stTime: (int.parse(hour) *60) + int.parse(minute) + (1440 * 6),comfortSetting: _state, userPairCode: s.getString("PairCode")));
                        break;
                    }
                  }

                  Navigator.pop(context);
                },
                child: Container(
                  height: Dimension.getScreenHeight() * .05,
                  width: Dimension.getScreenHeight() * .1,
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Color(0xffF94892),
                      borderRadius: BorderRadius.circular(Dimension.getScreenHeight() * .03)
                  ),
                  child: Text("save",style: TextStyle(
                    color: Colors.white,
                    fontSize: Dimension.getScreenHeight() * .02
                  ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          )

        ],
      ),
    );
  }
}
