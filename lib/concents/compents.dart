import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pharmcy_project/concents/MODELS/Add_drags_model.dart';


Widget textformfiled({suffix,scure,type,controler,vald,name,prefix,ontap}){
  return TextFormField(
    decoration: InputDecoration(
        label: Text(name),
        suffixIcon:suffix,
        prefixIcon:Icon(prefix,color: Colors.blue,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        )
    ),
    obscureText: scure??false,
    validator: vald,
    controller: controler,
    keyboardType:type,
  );






}
var user;
bool finsh=true;

bool verfiyfromnumber=false;
TextEditingController controllername=TextEditingController();
TextEditingController controllerphone=TextEditingController();
TextEditingController controllerpassword=TextEditingController();
TextEditingController controlleremail=TextEditingController();

var token;
Widget? startWidget;
bool lang=false;
bool loding=false;
List<String>Time=[];
List<String>Day=[];
List<String>Name=[];
List<String>Count=[];
List<String>Price=[];
List<String>Type=[];
List<String>Phones=[];
List<String>DragsName=[];
List<String>Code=[];
var verified=true;
String? VerificationCode;
var UserName;
int Sum=0;
String? currentTime;
String? currentDay;
String? currentday;
var Uid='';
var name2,price,E_date,M_date,place,code;
TextEditingController namecontroller=TextEditingController();
TextEditingController pricecontroller=TextEditingController();
TextEditingController codecontroller=TextEditingController();
TextEditingController countcontroller=TextEditingController();
TextEditingController E_datecontroller=TextEditingController();
TextEditingController m_datecontroller=TextEditingController();
TextEditingController placecontroller=TextEditingController();
var count;
bool evailbel=false;
bool evailbelupdate=true;
bool ListFill=false;
 tost(msg,Color color,time)=>Fluttertoast.showToast(
msg: msg,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.TOP,
timeInSecForIosWeb: time,
backgroundColor: color,
textColor: Colors.white,
fontSize: 16.0

);
ThemeData themdate=ThemeData(
  scaffoldBackgroundColor: Colors.white,

   appBarTheme: AppBarTheme(
    color: Colors.white,
    iconTheme: IconThemeData(color: Colors.blue,size: 35),
    systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.dark,statusBarColor: Colors.white),
    elevation: 0,
      titleTextStyle: TextStyle(color: Colors.black)
  ),

    bottomNavigationBarTheme:BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
      elevation: 0
),
  listTileTheme: ListTileThemeData(
    iconColor: Colors.blue,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    height: 30
  )

 );



