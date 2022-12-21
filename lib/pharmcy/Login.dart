import 'package:barcode_widget/barcode_widget.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pharmcy_project/concents/BLOC/cubit.dart';
import 'package:pharmcy_project/concents/BLOC/states.dart';
import 'package:pharmcy_project/concents/compents.dart';
import 'package:pharmcy_project/pharmcy/Register.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController controllerphone=TextEditingController();
  bool x=true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit,states>(
      builder: (context, state) {

        cubit c = cubit.getcubit(context);
        return Scaffold(
          appBar: AppBar(
              titleSpacing: 0,
              leading: Icon(Icons.login),
              title: Text('Login',
                style: TextStyle(color: Colors.white, fontSize: 16),)

          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: x?Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textformfiled(
                    name: 'Phone Number',
                    type: TextInputType.phone,
                    prefix: (Icons.phone_android),
                    suffix: null,controler:controllerphone,
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width*1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.lightBlue,
                    ),

                    child: MaterialButton(onPressed: (){

                      x= false;
                      c.rebuild();
                      c.Login('${controllerphone.text}', context,);
                    },
                      child: const Text('Login',
                        style: TextStyle(color: Colors.black87, fontSize: 22),),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                    ),
                  ),
                  SizedBox(height: 8,),
                  ListTile(
                    title:  Text('Register',style: TextStyle(color: Colors.blue,fontSize: 15)),
                    leading:Text('Don\'t You Have An Acount?',style: TextStyle(fontSize: 15),),
                    onTap: (){
                      verified=true;
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScrenn()));
                    },
                  )

                ],
              ): CircularProgressIndicator(),
          ),
        )
        );
      },
      listener: (context,state){},
    );
  }
}