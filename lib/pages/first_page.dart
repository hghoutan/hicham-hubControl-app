import 'package:flutter/material.dart';
import 'package:hub_control/Widgets/home_button.dart';
import 'package:hub_control/model/mode.dart';
import 'package:hub_control/pages/auth.dart';
import 'package:hub_control/utils/dimension.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/home_thermometer.dart';

class FirstPage extends StatefulWidget {
  final String userName;
  final BuildContext cntx;
  final bool? fromNavigator;
  const FirstPage(this.userName, this.cntx, this.fromNavigator,{super.key});

  @override
  State<FirstPage> createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {

  List<Mode> mode = [
    Mode(state: "Off", description: "Touch to turn ON",color:Colors.black45 ),
    Mode(state: "Boost", description: "set temp reached",color: Colors.blue),
    Mode(state: "Cool", description: "set temp reached",color: Colors.blue.shade700),
  ];

  int _i = 0;

  int temp = 41;

  setTemp(int t) {
    setState(() {
      temp = t;
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.userName.isNotEmpty ? widget.userName: "HubControl"),
            backgroundColor: const Color(0xffF94892),
            leading:GestureDetector(
              onTap: () async{
                print("entred");
                SharedPreferences s = await SharedPreferences.getInstance();
                await s.remove("PairCode");
                if (widget.fromNavigator == true) {
                  Navigator.pop(widget.cntx);
                  return;
                }
                Navigator.pushReplacement(widget.cntx, MaterialPageRoute(
                    builder: (builder) =>  AuthenticationPage()) );
              },
              child: const Icon(
                Icons.power_settings_new,
                size: 26,
              ),
            ),
            actions: const [
              Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.settings,
                    size: 26,
                  ))
            ],
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: Dimension.getScreenHeight() * 6 / 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_i < 2) {
                          setState(() {
                            _i++;
                          });
                        } else {
                          setState(() {
                            _i = 0;
                          });
                        }
                      },
                      child: HomeButton(
                          color: mode[_i].color!,
                          state: mode[_i].state,
                          keyword: mode[_i].description,
                      ),
                    ),
                    SizedBox(width: Dimension.getScreenWidth() * 6 / 100),
                  ],
                ),
                SizedBox(height: Dimension.getScreenHeight() * 5 / 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    HomeThermometer(
                      setTemp: setTemp,
                    ),
                    SizedBox(
                      width: Dimension.getScreenWidth() * 10 / 100,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("SET TO",
                            style: TextStyle(
                              fontSize: Dimension.getScreenHeight() * 4 / 100,
                              fontWeight: FontWeight.w300,
                            )),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(temp.toString(),
                                  style: TextStyle(
                                      color: mode[_i].color,
                                      fontFamily: 'Poppins',
                                      fontSize:
                                          Dimension.getScreenHeight() * 8 / 100,
                                      fontWeight: FontWeight.w500)),
                              Column(
                                children: [
                                  Text("°",
                                      style: TextStyle(
                                          color: mode[_i].color,
                                          fontFamily: 'Poppins',
                                          fontSize: Dimension.getScreenHeight() *
                                              8 /
                                              100,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              Text(".",
                                  style: TextStyle(
                                      color: mode[_i].color,
                                      fontFamily: 'Poppins',
                                      fontSize:
                                          Dimension.getScreenHeight() * 5 / 100,
                                      fontWeight: FontWeight.w500)),
                              Text("0",
                                  style: TextStyle(
                                      color: mode[_i].color,
                                      fontFamily: 'Poppins',
                                      fontSize:
                                          Dimension.getScreenHeight() * 5 / 100,
                                      fontWeight: FontWeight.w500)),
                            ]),
                        Text("INSIDE TEMP",
                            style: TextStyle(
                              fontSize: Dimension.getScreenHeight() * 4 / 100,
                              fontWeight: FontWeight.w300,
                            )),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("68",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'Poppins',
                                      fontSize:
                                          Dimension.getScreenHeight() * 9.5 / 100,
                                      fontWeight: FontWeight.w500)),
                              Column(
                                children: [
                                  Text("°",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'Poppins',
                                          fontSize: Dimension.getScreenHeight() *
                                              9.5 /
                                              100,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              Text(".",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'Poppins',
                                      fontSize:
                                          Dimension.getScreenHeight() * 6 / 100,
                                      fontWeight: FontWeight.w500)),
                              Text("0",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'Poppins',
                                      fontSize:
                                          Dimension.getScreenHeight() * 9.5 / 100,
                                      fontWeight: FontWeight.w500)),
                            ]),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
