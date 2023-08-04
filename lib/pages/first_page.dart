import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hub_control/Widgets/home_button.dart';
import 'package:hub_control/utils/dimension.dart';

import '../Widgets/home_thermometer.dart';


class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<String> stateMode = ["Off","Boost","Cool"];
  List<String> keywords = ["Touch to","set temp","set temp"];
  List<String> keywords2 = ["turn ON","reached","reached"];
  List<Color> colors = [Colors.black45,Colors.blue,Colors.blue.shade700];
  late int _i ;
  int i = 0;
  @override
  void initState() {
    super.initState();
    _i = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HubControl"),
        backgroundColor: const Color(0xffF94892),
        leading: const Icon(
          Icons.menu,
          size: 26,
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
            SizedBox(height: Dimension.getScreenHeight() * 6/100),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    if (_i < 2) {
                      setState(() {
                        _i++;
                      });
                    }else{
                      setState(() {
                        _i=0 ;
                      });
                    }
                  },
                  child: HomeButton(color: colors[_i],state: stateMode[_i],keyword: keywords[_i],keyword2: keywords2[_i]),),
                SizedBox(width: Dimension.getScreenWidth() * 6/100 ),

              ],
            ),
            SizedBox(height: Dimension.getScreenHeight() * 5/100),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                  const HomeThermometer(),
                  SizedBox(width: Dimension.getScreenWidth() * 10/100,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("SET TO" ,style: TextStyle(fontSize: Dimension.getScreenHeight() * 4/100,fontWeight: FontWeight.w300,)),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("86",style: TextStyle(color: colors[_i],fontFamily: 'Poppins',fontSize: Dimension.getScreenHeight() * 8/100,fontWeight: FontWeight.w500)),
                          Column(
                            children: [
                              Text("°",style: TextStyle(color: colors[_i],fontFamily: 'Poppins',fontSize: Dimension.getScreenHeight() * 8/100,fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Text(".",style: TextStyle(color: colors[_i],fontFamily: 'Poppins',fontSize: Dimension.getScreenHeight() * 5/100,fontWeight: FontWeight.w500)),
                          Text("8",style: TextStyle(color: colors[_i],fontFamily: 'Poppins',fontSize: Dimension.getScreenHeight() * 5/100,fontWeight: FontWeight.w500)),
                        ]
                    ),
                    Text("INSIDE TEMP" ,style: TextStyle(fontSize: Dimension.getScreenHeight() * 4/100,fontWeight: FontWeight.w300,)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("68",style: TextStyle(color: Colors.black87,fontFamily: 'Poppins',fontSize: Dimension.getScreenHeight() * 9.5/100,fontWeight: FontWeight.w500)),
                        Column(
                          children: [
                            Text("°",style: TextStyle(color: Colors.black87,fontFamily: 'Poppins',fontSize: Dimension.getScreenHeight() * 9.5/100,fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Text(".",style: TextStyle(color: Colors.black87,fontFamily: 'Poppins',fontSize: Dimension.getScreenHeight() * 6/100,fontWeight: FontWeight.w500)),
                        Text("0",style: TextStyle(color: Colors.black87,fontFamily: 'Poppins',fontSize: Dimension.getScreenHeight() * 9.5/100,fontWeight: FontWeight.w500)),
                        ]
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
      )

    );
  }
}


