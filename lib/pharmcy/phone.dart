import 'package:barcode_widget/barcode_widget.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pharmcy_project/concents/BLOC/cubit.dart';
import 'package:pharmcy_project/concents/BLOC/states.dart';
import 'package:pharmcy_project/concents/cash/cashHealper.dart';
import 'package:pharmcy_project/concents/compents.dart';

class Phone extends StatelessWidget {

  var phone;

  Phone(phone1){
    this.phone=phone1;
  }
bool x=true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit,states>(
        builder: (context, state) {
          cubit c = cubit.getcubit(context);
          return Scaffold(
            appBar: AppBar(
                titleSpacing: 0,
                title: Text('Verified phone',
                  style: TextStyle(color: Colors.white, fontSize: 16),)

            ),
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: x ? Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.lightBlue,
                  ),

                  child: MaterialButton(onPressed: () {
                    x = false;
                   print(CacheHelper.getData(key: 'UID'));
                    c.VerfiyPhoneNumbyer(phone, context,Phone(phone),CacheHelper.getData(key: 'UID'));
                  },
                    child: const Text('Verified Phone',
                      style: TextStyle(color: Colors.black87, fontSize: 22),),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                  ),
                ) : CircularProgressIndicator(),
              ),
            ),
          );
        },
    listener: (context,state){},
    );
}
}