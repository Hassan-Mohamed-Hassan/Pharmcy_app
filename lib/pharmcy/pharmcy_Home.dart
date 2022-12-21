import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmcy_project/concents/BLOC/cubit.dart';
import 'package:pharmcy_project/concents/BLOC/states.dart';
import 'package:pharmcy_project/concents/cash/cashHealper.dart';
import 'package:pharmcy_project/pharmcy/Allproduct.dart';
import 'package:pharmcy_project/pharmcy/History.dart';
import 'package:pharmcy_project/pharmcy/Register.dart';

import '../concents/compents.dart';
import '../concents/compents.dart';
import 'Day_of_history.dart';
import 'Login.dart';

class HomPharmcy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return BlocConsumer<cubit,states>(
        builder: (context, state) {
          cubit c=cubit.getcubit(context);
          String Sales=lang? 'Sales':'المشتريات';
          String add=lang? 'add':'الاضاقة';
          String Search=lang? 'Search':'البحث';
          String Update=lang? 'Update':'التعديل';
          List<String> titles=[Sales,add,Search,Update];
          return  Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Directionality(
              textDirection:lang?TextDirection.ltr:TextDirection.rtl,
              child: Scaffold(
                key: _scaffoldKey,
                endDrawer: drawer(c),
                 drawer: drawer(c),
               drawerScrimColor: Colors.white.withOpacity(.0),
              appBar: AppBar(
                actions: [
              Builder(builder: (context){
                return IconButton(onPressed: (){
                  _scaffoldKey.currentState!.openEndDrawer();
                },
                    icon: Icon(Icons.menu));
              })

        ],
        title: Text('${titles[c.index]}',style:TextStyle(fontSize: 20,color: Colors.black),),
              leading: c.icon[c.index],leadingWidth: 20,
        ),
        body: c.screnn[c.index],
        bottomNavigationBar: BottomNavigationBar(
              type:BottomNavigationBarType.fixed ,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: '${lang? 'Home':'الرئسية '}',),
                BottomNavigationBarItem(icon: Icon(Icons.add,),label: '${lang? 'Add':'اضافة '} '),
                BottomNavigationBarItem(icon: Icon(Icons.search),label: '${lang? 'Search':'البحث '} '),
                BottomNavigationBarItem(icon: Icon(Icons.update),label:  '${lang? 'Update':'تعديل '} '),

              ],
              currentIndex: c.index,
              onTap:(index){
                c.changeNav(index);

              },


        ),
      ),
            ),
          );
    }, listener: (context,state){}
    );
  }
}
class drawer extends StatelessWidget {
  cubit cc;

  drawer(this.cc){
   cc =cc;
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:lang?TextDirection.ltr:TextDirection.rtl,
      child: Container(
        width: 250,
        child: Drawer(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.close)),
            ),
            body: ListView(
              children: [
            ListTile(
              leading: Icon(Icons.history),
              title: Text('${lang? 'History':'السجل '}',style: TextStyle(color: Colors.blue,fontSize: 16),),
              onTap: (){
                cc.getdayhistory();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DayHistoryScreen()));
              },
            ),
            SizedBox(height: 10,),
            ListTile(
              leading: Icon(Icons.language_outlined),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('${lang? 'language':'اللغة '}',style: TextStyle(color: Colors.blue,fontSize: 16),),
                  SizedBox(width: 5,),
                  Text('${lang? 'EN to AR':'العربية الي انجليزية '}',textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black45,fontSize: 10),),
                ],
              ),
              onTap: (){

                cc.changelang();
              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryScreen()));
              },
          ),
            SizedBox(height: 10,),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('${lang? 'logout':' الغاء التسجيل'}',style: TextStyle(color: Colors.blue,fontSize: 16),),
              onTap: (){
                cc.logout(context);
                 },
            ),
            SizedBox(height: 10,),
            ListTile(
                  leading: Icon(Icons.production_quantity_limits_sharp),
                  title: Text('${lang? 'All Product':' كل المنتجات'}',style: TextStyle(color: Colors.blue,fontSize: 16),),
                  onTap: (){
                    cc.getAllProduct(context,AllProductScreen());
                      },
                ),
            SizedBox(height: 10,),
            ListTile(
                  leading: Icon(Icons.price_check_rounded),
                  title: Text('${lang? 'Sumation of operation Sales ':'مجموع اسعار المبيعات'}',
                    style: TextStyle(color: Colors.blue,fontSize: 16),),
                  onTap: (){
                    confirm(
                      context,
                      title: Text('Sumation of operation Sales'),
                      content: Text('${CacheHelper.getData(key: 'sum')??0}'),
                      textOK: const Text('OK'),
                      textCancel: const Text('Cancel'),
                    ).then((value){});

                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

}

