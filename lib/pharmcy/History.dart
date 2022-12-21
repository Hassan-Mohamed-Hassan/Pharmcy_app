import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmcy_project/concents/BLOC/cubit.dart';
import 'package:pharmcy_project/concents/BLOC/states.dart';
import 'package:pharmcy_project/concents/compents.dart';

import '../concents/compents.dart';

class HistoryScreen extends StatelessWidget {
String  ?Day;

HistoryScreen(this.Day);

  @override
  Widget build(BuildContext context) {
    print(Name);
    return BlocConsumer<cubit,states>
      (builder: (context,state){
        return Scaffold(
          appBar: AppBar(),
          body:(Time.length==0)?Center(child: CircularProgressIndicator()) :ListView.separated(
              itemBuilder: (context, index){
               int length=Time.length-1;
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(

                      children: [
                        Row(children: [
                          CircleAvatar(child:   Text('${Time[length-index]}',
                style: TextStyle(color: Colors.white,fontSize: 12),textAlign:TextAlign.center,),
                              radius: 40,backgroundColor: Colors.blueGrey),

                          SizedBox(width: 7,),
                          Column(
                            children: [
                              Row(

                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*.3,
                                    child: Text('Product_Name :',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  SizedBox(width: 7,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*.3,
                                    child: Text('${Name[length-index]}',maxLines:2,overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.blue,fontSize: 15),
                                      ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 7,),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*.3,
                                    child: Text('Product_Count :',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  SizedBox(width: 7,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*.3,
                                    child: Text('${Count[length-index]}',
                                      style: TextStyle(color: Colors.blue,fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 7,),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*.3,
                                    child: Text('Product_Price :',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  SizedBox(width: 7,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*.3,
                                    child: Text('${Price[length- index]}',
                                      style: TextStyle(color: Colors.blue,fontSize: 15),
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 7,),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width*.3,
                                    child: Text('Opertion Type :',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  SizedBox(width: 7,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*.3,
                                    child: Text('${Type[length-index]}',
                                      style: TextStyle(color: Colors.blue,fontSize: 15),
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),

                      ]
                        ),




                      ],
                    ),
                  );
              },
              separatorBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width*1,
                    height: 2,
                    color: Colors.blueGrey,
                  ),
                );
              },
              itemCount: Time.length,
          ),
        );
    },
        listener: (context,state){},
    );
  }
}
