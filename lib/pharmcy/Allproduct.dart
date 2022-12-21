import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmcy_project/concents/BLOC/cubit.dart';
import 'package:pharmcy_project/concents/BLOC/states.dart';
import 'package:pharmcy_project/concents/compents.dart';

import '../concents/compents.dart';

class AllProductScreen extends StatelessWidget {
String  ?Day;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit,states>
      (builder: (context,state){
        return Scaffold(
          appBar: AppBar(),
          body:(Name.length==0)?Center(child: CircularProgressIndicator()) :ListView.separated(
              itemBuilder: (context, index){
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(

                      children: [
                        Row(children: [
                          CircleAvatar(child:   Text('${index+1}',
                style: TextStyle(color: Colors.white,fontSize: 15),textAlign:TextAlign.center,),
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
                                    child: Text('${Name[index]}',maxLines:2,overflow: TextOverflow.ellipsis,
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
                                    child: Text('${Count[index]}',
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
                                    child: Text('${Price[index]}',
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
                                    child: Text('Product_Code :',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  SizedBox(width: 7,),
                                  Container(
                                    width: MediaQuery.of(context).size.width*.3,
                                    child: Text('${Code[index]}',
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
              itemCount: Name.length,
          ),
        );
    },
        listener: (context,state){},
    );
  }
}
