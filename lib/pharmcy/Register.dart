

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmcy_project/concents/BLOC/cubit.dart';
import 'package:pharmcy_project/concents/BLOC/states.dart';
import 'package:pharmcy_project/concents/cash/cashHealper.dart';
import 'package:pharmcy_project/pharmcy/Login.dart';
import 'package:pharmcy_project/pharmcy/pharmcy_Home.dart';
import 'package:pharmcy_project/pharmcy/phone.dart';

import '../concents/compents.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScrenn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var formkey=GlobalKey<FormState>();
    return BlocConsumer<cubit,states>(
           builder: (context, state){
             cubit cubit1=cubit.getcubit(context);
             return Scaffold(
                 appBar: AppBar(title: Text('Pharmcy'),leading: Icon(Icons.login_rounded),),
                 body: Padding(
                   padding: const EdgeInsets.only(
                       top:60,
                       left: 20,
                       right: 20),
                   child: SingleChildScrollView(
                     child: Form(
                       key: formkey,
                       child: Column(
                           children: [
                             if(verified)textformfiled(
                               name: 'User Name',
                               type: TextInputType.name,
                               prefix: (Icons.person),
                               controler:controllername,
                             ),
                             SizedBox(height: 20,),
                             if(verified)textformfiled(
                               name: 'Email',
                               type: TextInputType.emailAddress,
                               prefix: (Icons.email),
                               controler:controlleremail,
                             ),
                             SizedBox(height: 20,),
                             textformfiled(
                               name: 'Phone Number',
                               type: TextInputType.phone,
                               prefix: (Icons.phone_android),
                               suffix: null,controler:controllerphone,
                             ),
                             SizedBox(height: 20,),
                             if(verified) textformfiled(
                               name: 'Password',
                               type: TextInputType.text,
                               prefix: (Icons.lock),
                               scure:cubit1.scur ,
                               suffix:IconButton(icon:cubit1.iconpassword,onPressed:(){cubit1.changepasswordrdicon();}),
                               controler:controllerpassword ,
                             ),
                             SizedBox(height: 30,),
                             loding?CircularProgressIndicator():Container(
                               width: MediaQuery.of(context).size.width*1,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 color: Colors.lightBlue,
                               ),
                               child: MaterialButton(onPressed: () {
                                 if(formkey.currentState!.validate()){
                                 print('kkkkkkkkk$verified');
                                 if(verified) cubit1.Register(
                                     controlleremail.text,
                                     controllerpassword.text,
                                     controllerphone.text,
                                     controllername.text, context);
                                 else{
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>(Phone(controllerphone.text))));
                                 }
                                 }
                                   },
                                 child: Text('${(verified)?'Register':'New Phone'}',style: TextStyle(color: Colors.black87,fontSize: 22),),
                                 elevation: 0,
                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                               ),
                             ),
                             SizedBox(height: 10,),
                             ListTile(
                               title:  Text('Login',style: TextStyle(color: Colors.blue,fontSize: 15)),
                               leading:Text('Do You Have An Acount?',style: TextStyle(fontSize: 15),),
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                               },
                             )


                           ]),
                     ),
                   ),
                 )
             );
           },
         listener: (context,state){},

         );

  }
}
