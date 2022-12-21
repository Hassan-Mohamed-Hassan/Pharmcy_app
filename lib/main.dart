

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pharmcy_project/concents/BLOC/cubit.dart';
import 'package:pharmcy_project/concents/compents.dart';
import 'package:pharmcy_project/pharmcy/pharmcy_Home.dart';
import 'concents/cash/cashHealper.dart';
import 'pharmcy/Register.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  print('main////////////////////////');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
/*
 await FirebaseFirestore.instance.collection('users').get()
     .then((QuerySnapshot querySnapshot){
    Phones=[];
    querySnapshot.docs.forEach((doc){
      Phones.add('${doc['phone']}');});});
*/
 token= CacheHelper.getData(key: 'UID');
 print('${token}kkkkkkkkkkkk');
  if(token==null)token='';
 if(token!=''){
   startWidget=HomPharmcy();
   print('$token' + 'iffffffffff');
 }
 else{
   startWidget=RegisterScrenn();
  print('elssssssssss');}
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, // navigation bar color
        systemNavigationBarIconBrightness: Brightness.dark, // avigation bar icon
        systemNavigationBarDividerColor: Colors.white,
    ));
    return BlocProvider(
      create: (context)=>cubit(),
      child: MaterialApp(
        title: 'Pharmacy App',
        debugShowCheckedModeBanner: false,
        theme:ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
                color: Colors.white,
                iconTheme: IconThemeData(color: Colors.blue,size: 35),
                systemOverlayStyle:SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.white),
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
        ),
        home:startWidget,

      ),
    );
  }
}

