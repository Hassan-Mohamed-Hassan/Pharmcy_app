import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmcy_project/concents/BLOC/cubit.dart';
import 'package:pharmcy_project/concents/BLOC/states.dart';
import 'package:pharmcy_project/concents/MODELS/Add_drags_model.dart';
import 'package:pharmcy_project/concents/compents.dart';

class homescreen extends StatelessWidget {
  TextEditingController searchcontrooler=TextEditingController();

  Drags_Model ?model;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit,states>(builder: (context, state) {
      cubit cubit2=cubit.getcubit(context);
      return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration(
                label: Text('${lang?'Product Search ':'البحث عن منتج'}'),
                suffixIcon: Icon(Icons.search),
                border:OutlineInputBorder(borderRadius: BorderRadius.circular(20)) ,
              ),
              controller: searchcontrooler,

              onFieldSubmitted: (v){
                cubit2.get_product(v.toString());
                //cubit2.getData();

              },

              maxLines: 1,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20,),
           if(evailbel)Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    mylinewidth(context),
                    Row(children: [
                      mylinehieght(),
                      Container(width: MediaQuery.of(context).size.width*.45,height: 100,

                        alignment: Alignment.center,
                        child: myychildtext('${lang?'Product_Name':'اسم المنتج'}')),
                      mylinehieght(),
                      Container(width: MediaQuery.of(context).size.width*.45,height: 100,

                        alignment: Alignment.center,
                        child: mychildtextans('${name2}'),),
                      mylinehieght(),
                    ],),
                    mylinewidth(context),
                    Row(children: [
                      mylinehieght(),
                      Container(width: MediaQuery.of(context).size.width*.45,height: 100,

                        alignment: Alignment.center,
                        child: myychildtext('${lang?'Product_Price':'سعر المنتج'}'),),
                      mylinehieght(),
                      Container(width: MediaQuery.of(context).size.width*.45,height: 100,

                        alignment: Alignment.center,
                        child: mychildtextans('${price} LE',),),
                      mylinehieght(),
                    ],),
                    mylinewidth(context),
                    Row(children: [
                      mylinehieght(),
                      Container(width: MediaQuery.of(context).size.width*.45,height: 100,

                        alignment: Alignment.center,
                        child: myychildtext('${lang?'Product_Count':'الكمية المتاحة'}'),),
                      mylinehieght(),
                      Container(width: MediaQuery.of(context).size.width*.45,height: 100,

                        alignment: Alignment.center,
                        child: mychildtextans('${count}',),),
                      mylinehieght(),
                    ],),
                    mylinewidth(context),
                    Row(children: [
                      mylinehieght(),
                      Container(width: MediaQuery.of(context).size.width*.45,height: 100,

                        alignment: Alignment.center,
                        child: myychildtext('${lang?' Product_M.Date':'تاريخ الانتاج'}'),),
                      mylinehieght(),
                      Container(width: MediaQuery.of(context).size.width*.45,height: 100,

                        alignment: Alignment.center,
                        child: mychildtextans('${M_date}',),),
                      mylinehieght(),
                    ],),
                    mylinewidth(context),
                    Row(children: [
                      mylinehieght(),
                      Container(width: MediaQuery.of(context).size.width*.45,height: 100,

                        alignment: Alignment.center,
                        child: myychildtext('${lang?' Product_EXP.Date':'تاريخ الانتهاء'}'),),
                      mylinehieght(),
                      Container(width: MediaQuery.of(context).size.width*.45,height: 100,

                        alignment: Alignment.center,
                        child: mychildtextans('${E_date}',),),
                      mylinehieght(),
                    ],),
                    mylinewidth(context),
                    Row(children: [
                      mylinehieght(),
                      Container(width: MediaQuery.of(context).size.width*.45,height: 100,

                        alignment: Alignment.center,
                        child: myychildtext('${lang?'Product_Code':'كود المنتج'}'),),
                      mylinehieght(),
                      Container(width: MediaQuery.of(context).size.width*.45,height: 100,

                        alignment: Alignment.center,
                        child: mychildtextans('${code}',),),
                      mylinehieght(),
                    ],),
                    mylinewidth(context),
                    Row(children: [
                      mylinehieght(),
                      Container(width: MediaQuery.of(context).size.width*.45,height: 100,

                        alignment: Alignment.center,
                        child: myychildtext('${lang?'Product_Place':'مكان المنتج'}'),),
                      mylinehieght(),
                      Container(width: MediaQuery.of(context).size.width*.45,height: 100,

                        alignment: Alignment.center,
                        child: mychildtextans('${place}',),),
                      mylinehieght(),
                    ],),
                    mylinewidth(context),
                  ],
                ),
              ),
            )
          ],),
      );
    },
        listener: (context,state){});
  }
  Widget mylinewidth(context)=> SizedBox(width: MediaQuery.of(context).size.width*.9,height: 2,
    child: Container(color:Colors.black,),);
  Widget mylinehieght()=> SizedBox(width: 2,height: 100,
    child: Container(color:Colors.black,),);
  Widget myychildtext(text)=>Text('$text',style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold),);
  Widget mychildtextans(text)=>Text('$text',style:TextStyle(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.w500),);
}
