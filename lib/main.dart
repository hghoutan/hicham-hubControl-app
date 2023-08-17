import 'package:flutter/material.dart';
import'package:get/get.dart';
import 'package:hub_control/pages/auth.dart';


import 'package:hub_control/pages/home.dart';
import 'package:hub_control/provider/hubControl_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'model/hub_user.dart';
import 'model/time.dart';
late List<Time>times;
late List<HubUser>hubs;

late SharedPreferences user;
bool isUser = false;
String userName = "";


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  var db = HubControlDbProvider.db;
   times = await db.getAllTimes();
   hubs = await db.getAllHubs();

    Get.lazyPut(() => times);
  Get.lazyPut(() => hubs);

  user = await SharedPreferences.getInstance();


  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    if (user.getString("PairCode")!= null ) {
      isUser = true;
      for (var element in hubs) {
        if (user.getString("PairCode") == element.pairCode) {
          userName = element.userName != null ? element.userName! : "";
        }
      }}
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      color: const Color(0xffF0E7D8),
      home: isUser ?  HomePage(userName,null) : const AuthenticationPage(),
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
    );
  }
}