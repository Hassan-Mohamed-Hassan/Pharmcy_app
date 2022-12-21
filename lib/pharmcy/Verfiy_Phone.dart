import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmcy_project/concents/BLOC/cubit.dart';
import 'package:pharmcy_project/concents/BLOC/states.dart';
import 'package:pharmcy_project/concents/cash/cashHealper.dart';
import 'package:pharmcy_project/pharmcy/Login.dart';
import 'package:pharmcy_project/pharmcy/Register.dart';
import 'package:pharmcy_project/pharmcy/pharmcy_Home.dart';
import 'package:pharmcy_project/pharmcy/phone.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../concents/compents.dart';

class OTPScreen extends StatelessWidget {
  final String phone;
  final String uidofphone;
  OTPScreen(this.phone,this.uidofphone);


  @override

  final TextEditingController _pinPutController = TextEditingController();
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit,states>
      (builder: (context, state) {
        cubit c=cubit.getcubit(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('OTP Verification'),
          ),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Center(
                  child: Text(
                    'Verify +20-${phone}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                ),
              ),
              loding? CircularProgressIndicator():Padding(
                padding: const EdgeInsets.all(30.0),
                child: Pinput(
                  length: 6,
                 defaultPinTheme: defaultPinTheme,
                  controller: _pinPutController,

                  pinAnimationType: PinAnimationType.fade,
                  onSubmitted: (pin) async {
                    try {
                      loding=true;
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: VerificationCode!, smsCode: pin))
                          .then((value) async {
                        if (value.user != null) {
                          token=CacheHelper.saveData(key: 'UID', value:'$uidofphone');
                           print('^^^^^^^^^^^^^');
                           print(CacheHelper.getData(key: 'UID'));
                           c.updatephone(phone);
                        if(verfiyfromnumber)c.verifiyfromNumberMessage(phone,CacheHelper.getData(key: 'UID') , context);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => HomPharmcy()),
                                  (route) => false);
                        }
                          });
                    }
                      catch (e) {
                        new Future.delayed(Duration(seconds: 60), () {
                          if(verfiyfromnumber){
                            c.DeletUser();
                            Navigator.push(context,MaterialPageRoute(builder: (context) =>RegisterScrenn()));
                            verified=false;
                            tost('This Number Not Correct', Colors.red, 5);
                            verfiyfromnumber=false;
                          }
                          else
                            Navigator.push(context,MaterialPageRoute(builder: (context) =>LoginScreen()));
                           tost('This Number Not Correct', Colors.red, 5);
                        });


                    }
                    loding=true;
                    c.rebuild();
                  },
                ),
              ),
      Countdown(
      seconds: 60,
      build: (BuildContext context, double time) => Text('${time.toInt()}',style: TextStyle(color: Colors.blue,fontSize: 25),),
      interval: Duration(seconds: 1),
      onFinished: () {
     tost('Check Your Mobile Number And Try Agin',Colors.red,4);
     if(verfiyfromnumber)Navigator.push(context,MaterialPageRoute(builder: (context) =>Phone(phone))) ;
     else Navigator.push(context,MaterialPageRoute(builder: (context) =>LoginScreen()));
      },
      )
            ],
          ),
        );
      }, listener: (context,states){}
    );
  }
}

