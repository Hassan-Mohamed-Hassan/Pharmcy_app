import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmcy_project/concents/BLOC/cubit.dart';
import 'package:pharmcy_project/concents/BLOC/states.dart';
import 'package:pharmcy_project/concents/compents.dart';

import '../concents/compents.dart';
import 'History.dart';

class DayHistoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print(Day.length);
    return BlocConsumer<cubit,states>
      (builder: (context,state){
      cubit cub=cubit.getcubit(context);

      return Scaffold(
        appBar: AppBar(),
        body:(Day.length==0)?Center(child: CircularProgressIndicator()) :ListView.separated(
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child:InkWell(
                onTap: (){
                  cub.gethistory(Day[index]);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryScreen('${Day[index]}')));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width*.9,
                  height: 50,
                  color:Colors.black12 ,
                 child: Text('${Day[index]}',
                    style: TextStyle(color: Colors.blue,fontSize: 25),
                  ),

                ),
              ) ,
            );
          },
          separatorBuilder: (context,index){
            return SizedBox(height: 20,);
          },
          itemCount: Day.length,
        ),
      );
    },
      listener: (context,state){},
    );
  }
}
