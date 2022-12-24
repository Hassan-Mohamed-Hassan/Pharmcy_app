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
    var fromkay=GlobalKey<FormState>();
    return BlocConsumer<cubit,states>(
        builder: (context, state) {
          cubit c=cubit.getcubit(context);
          String Sales=lang? 'Sales':'المشتريات';
          String add=lang? 'add':'اضافة';
          String Search=lang? 'Search':'البحث';
          String Update=lang? 'Update':'التعديل';
          List<String> titles=[Sales,add,Search,Update];
          return  Directionality(
            textDirection:lang?TextDirection.ltr:TextDirection.rtl,
            child: Scaffold(
              key: _scaffoldKey,
              endDrawer: drawer(c),
               drawer: drawer(c),
             drawerScrimColor: Colors.white.withOpacity(.0),
            appBar:PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: AppBar(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                    bottomRight:Radius.elliptical(200, 50),
                    bottomLeft: Radius.elliptical(200, 50)
                )

                ),
                actions: [
              Builder(builder: (context){
                return IconButton(onPressed: (){
                  _scaffoldKey.currentState!.openEndDrawer();
                },
                    icon: Icon(Icons.menu,color: Colors.orangeAccent,));
              })

        ],
        toolbarHeight:70,
        title: Text('${titles[c.index]}',style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.orange),),
              centerTitle: true,
                leadingWidth: 55,
                leading: c.icon[c.index],
        ),
            ),
        body: c.screnn[c.index],
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (c.bottomsheetShow) {

                      c.updateProfile('${CacheHelper.getData(key: 'UID')}', controllername.text, controllerphone.text,controlleremail.text)
                          .then((value){
              if(fromkay.currentState!.validate()){
                        Navigator.pop(context);
                        print(c.thisphoneExist);
                        c.bottomsheetShow=false;
                        c.rebuild();
                        }
                      });


                  }
                  else {
                    c.getProfile('${CacheHelper.getData(key: 'UID')}').then((value){
                      _scaffoldKey.currentState!.showBottomSheet((context) => Form(
                        key: fromkay,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Column(
                            children:[
                              textformfiled(
                                name: 'User Name',
                                type: TextInputType.name,
                                prefix: (Icons.person),
                                suffix: null,
                                controler:controllername,
                                vald: (value) {
                                  if (value!.isEmpty) {
                                    return '${lang ? 'must be fill this field' : 'لا يمكن ان يكون الحقل فارغ '}';
                                  } else
                                    return null;
                                },
                              ),
                              SizedBox(height: 20,),
                              textformfiled(
                                name: 'Phone Number',
                                type: TextInputType.phone,
                                prefix: (Icons.phone),
                                suffix: null,
                                controler:controllerphone,
                                vald: (value) {
                                  if (value!.isEmpty || c.thisphoneExist) {
                                    return '${lang ? 'this field Empty or this number is Rigisterd ' : 'هذا الحقل فارغ او هذ الرقم مسجل '}';
                                  } else
                                    return null;
                                }
                              ),
                            ],
                          ),
                        ),
                      ),);
                    });
                    c.bottomsheetShow=true;
                    c.rebuild();
                  }
                },
                backgroundColor: Colors.black,
                child:Image.asset('image/person.png',width: 40,height: 40,),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar( //bottom navigation bar on scaffold
          color:Colors.black,
          shape: CircularNotchedRectangle(), //shape of notch
          notchMargin: 5, //notche margin between floating button and bottom appbar
          child: Row( //children inside bottom appbar
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: Image.asset('image/selling.png',width: 40,),onPressed: (){c.index=0;c.rebuild();}),
              IconButton(icon: Image.asset('image/add.png',width: 40,), onPressed: () {c.index=1;c.rebuild();},),
              IconButton(icon: Image.asset('image/search.png',width: 40,), onPressed: () {c.index=2;c.rebuild();},),
              IconButton(icon: Image.asset('image/update.png',width: 40,), onPressed: () {c.index=3;c.rebuild();},),
            ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 430,
            width: 230,
            child: Drawer(
              child: Container(
                height: 300,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.black87,
                    leading: IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.close,color: Colors.orangeAccent,)),
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
                          style: TextStyle(color: Colors.orange,fontSize: 10),),
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
          ),
        ],
      ),
    );
  }

}

