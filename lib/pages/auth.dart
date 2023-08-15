import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hub_control/model/hub_user.dart';
import 'package:hub_control/pages/home.dart';
import 'package:hub_control/provider/hubControl_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/dimension.dart';
import '../utils/formatter.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  late TextEditingController pairCodeController;
  late TextEditingController nameController;
  late bool _enable;
  late List<HubUser> users;
  late int n;
  @override
  void initState() {
    pairCodeController= TextEditingController();
    nameController = TextEditingController();
    _enable = false;
    n = 0;
    users = Get.find<List<HubUser>>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Future<bool> authentication(String pc)async {
      for (var element in users) {
        if (pc == element.pairCode) {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          await sharedPreferences.setString("PairCode", element.pairCode);

          HubControlDbProvider.db.updateUserName(pc,nameController.text.isNotEmpty ? nameController.text : "");
          return true;
        }
      }
      return false;
    }



    return Scaffold(
      appBar:AppBar(
        backgroundColor: const Color(0xffF94892),
        title: const Center(child: Text("Paired Hubs", style: TextStyle(fontSize: 24))),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              children: [
                Text("Enter a ",style: TextStyle(
                  fontSize: 36,
                  color: Colors.black,
                  fontFamily: "Poppins"
                )),
                Text("Pairing Code",style: TextStyle(
                    fontSize: 36,
                    color: Color(0xffF94892),
                    fontFamily: "Poppins"
                ),)
              ],
            ),
            const Text("from your Hub controller ",style: TextStyle(
                fontSize: 36,
                color: Colors.black,
                fontFamily: "Poppins"
            )),
            SizedBox(height: Dimension.getScreenHeight()* .06,),
            TextFormField(
              cursorWidth: 3,
              cursorColor: const Color(0xffF94892),
              controller: pairCodeController,
              inputFormatters: [
                UpperCaseTextFormatter(),
              ],
              onChanged: (s){
                setState(() {
                  if (s.isNotEmpty) {
                    _enable = true;
                  }
                  else{
                    _enable = false;
                  }
                });

              },
              style:const TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontFamily: "Poppins"
              ),
              decoration:  const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color:  Color(0xffF94892)),
                ),
                border: OutlineInputBorder(
                ),
                labelText: 'Enter Pairing code',
                labelStyle: TextStyle(
                 fontFamily: "Poppins",
                  color: Colors.black87
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                _enable ?  "" :  "required"
                ,style: const TextStyle(
                  fontSize: 20,
                  color:  Colors.black87,
                  fontFamily: "Poppins"
              ),
              ),
            ),
            SizedBox(height: Dimension.getScreenHeight()* .03,),
            TextFormField(
              controller: nameController,
              cursorWidth: 3,
              cursorColor: const Color(0xffF94892),
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
              ],
              onChanged: (s){
                setState(() {
                  n = s.length;
                });
              },
              style:const TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontFamily: "Poppins"
              ),
              decoration:  const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color:  Color(0xffF94892)),
                ),
                border: OutlineInputBorder(
                ),
                labelText: 'Hub Controller name',
                labelStyle: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.black87
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("$n/20"
                    ,style: const TextStyle(
                        fontSize: 20,
                        color:  Colors.black87,
                        fontFamily: "Poppins"
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimension.getScreenHeight()* .06,),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async{
                if (await authentication(pairCodeController.text)) {
                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage(nameController.text)));
                }else{
                  showDialog(context: context, barrierDismissible: false,builder: (BuildContext context){
                    return  AlertDialog(
                      backgroundColor: Colors.white,
                      title: Icon(Icons.error,color: Colors.red.shade900,size: 32),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                      actions:  [
                        Column(
                          children: [
                            const Text("Pairing failed",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                                fontSize: 32
                            )),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                              child: Text(
                                'An error has occurred while trying to pair.please check if the pairing code is correct.',
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "TRY AGAIN",
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
                }
              },
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                  decoration: BoxDecoration(
                    color: _enable ? Colors.yellow.shade600 : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(Dimension.getScreenWidth() * .5)
                  ),
                  child:  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children:[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.add,size: 24,color: _enable ? Colors.black: Colors.grey.shade400),
                      ),

                       Text("Pair Now",style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      color: _enable ? Colors.black: Colors.grey.shade400,
                    )),]
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
