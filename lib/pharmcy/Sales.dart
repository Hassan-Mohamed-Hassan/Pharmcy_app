import 'package:barcode_widget/barcode_widget.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pharmcy_project/concents/BLOC/cubit.dart';
import 'package:pharmcy_project/concents/BLOC/states.dart';
import 'package:pharmcy_project/concents/compents.dart';

class Sales_productt extends StatefulWidget {
  @override
  State<Sales_productt> createState() => _Sales_productState();
}

class _Sales_productState extends State<Sales_productt> {
  TextEditingController namecontroller=TextEditingController();
  TextEditingController codecontroller=TextEditingController();
  bool typeofenter=false;
  bool  desplayInputField=false;
  String ?barcodeScanRes;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit,states>(
        builder: (context, state) {
          cubit c=cubit.getcubit(context);
      return Scaffold(

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                SizedBox(height: 10,),
               TextButton(onPressed: (){scanQR(c);typeofenter=false;desplayInputField=true; c.rebuild();namecontroller.text='';}, child:Text('${lang?'Scan Qr Code':'فحص الكود'}') ),
               Text('OR'),
                TextButton(onPressed: (){typeofenter=true;desplayInputField=true; c.rebuild();}, child:Text('${lang?'Enter Product_Name ':'ادخل اسم المنتج '}')),
               SizedBox(height: 20,),
                  if(desplayInputField) myinput(typeofenter?namecontroller:codecontroller, TextInputType.text,
                      '${typeofenter?'${lang?'Enter Product_Name ':'ادخل اسم المنتج '}': '${lang?'Enter Product_Code':'ادخل الكود المنتج  '}'}'),

              SizedBox(height: 10,),
                  loding? CircularProgressIndicator():Container(
                width: MediaQuery.of(context).size.width*1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child :MaterialButton(onPressed:() {
                  if(namecontroller.text!=''){
                    c.confrimSales(context, namecontroller.text);
                    loding=true;

                  }
                  else{
                    c.SalesPycode(codecontroller.text, context);
                    loding=true;
                  }


                  },
                child: Text('${lang?'Selling_product':'شراء المنتج'}',style: TextStyle(color: Colors.white,fontSize: 22),),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
              ),
              ),
              SizedBox(height: 20,),

              ],
      ),
            ),
          ),
        )
      );
    }, listener: (context,state){}
      );

  }

  Future scanQR(cubit c) async {

    try {
      await FlutterBarcodeScanner.scanBarcode(
          '#cc6666', 'Cancel', true, ScanMode.BARCODE).then((value){
        setState(() {
          barcodeScanRes=value;
          codecontroller.text=value;
        });

      });
    } catch (e) {
      setState(() {
        barcodeScanRes='unable to reade barcode';

      });
    }
  }
  Widget myinput(controller,TextInputType type,label)=>Container(
    height: 70,
    child:   TextFormField(
      decoration: InputDecoration(

        label: Text('$label',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),



        suffixIcon: Icon(Icons.text_fields),

        border:OutlineInputBorder(borderRadius: BorderRadius.circular(20),) ,

      ),

      validator: (value){

        if(value!.isEmpty){

          return 'must be fill this field';

        }

        else

          return null;

      },

      controller: controller,

      maxLines: 2,

      keyboardType: type,

      textAlign: TextAlign.left,

    ),
  );
  Widget Myinputlist(controller,TextInputType type,label,)=> Row(children: [
    myinput(controller, type,'$label'),
  ],);
}