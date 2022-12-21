import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmcy_project/concents/BLOC/cubit.dart';
import 'package:pharmcy_project/concents/BLOC/states.dart';

import '../concents/compents.dart';

class Add_product extends StatelessWidget {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController codecontroller = TextEditingController();
  TextEditingController countcontroller = TextEditingController();
  TextEditingController E_datecontroller = TextEditingController();
  TextEditingController m_datecontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var scaffoldkey = GlobalKey<ScaffoldState>();
  bool x=true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit, states>(
        builder: (context, state) {
          cubit cub = cubit.getcubit(context);
          return Scaffold(
            key: scaffoldkey,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Myinputlist(namecontroller, TextInputType.text,
                                '${lang ? 'Product_Name' : 'اسم المنتج'}',context),
                            SizedBox(
                              height: 15,
                            ),
                            Myinputlist(pricecontroller, TextInputType.number,
                                '${lang ? 'Product_Price' : 'سعر المنتج'}',context),
                            SizedBox(
                              height: 15,
                            ),
                            Myinputlist(codecontroller, TextInputType.text,
                                '${lang ? 'Product_Code' : 'كود المنتج'}',context),
                            SizedBox(
                              height: 15,
                            ),
                            Myinputlist(countcontroller, TextInputType.number,
                                '${lang ? 'Product_Count' : 'الكمية المتاحة'}',context),
                            SizedBox(
                              height: 15,
                            ),
                            Myinputlist(
                                m_datecontroller,
                                TextInputType.datetime,
                                '${lang ? ' Product_M.Date' : 'تاريخ الانتاج'}',context),
                            SizedBox(
                              height: 15,
                            ),
                            Myinputlist(
                                E_datecontroller,
                                TextInputType.datetime,
                                '${lang ? ' Product_EXP.Date' : 'تاريخ الانتهاء'}',context),
                            SizedBox(
                              height: 15,
                            ),
                            Myinputlist(placecontroller, TextInputType.text,
                                '${lang ? 'Product_Place' : 'مكان المنتج'}',context),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    x? Container(
                      width: MediaQuery.of(context).size.width * .9,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          x=false;
                          cub.rebuild();
                          if (formkey.currentState!.validate()) {
                            cub.add_product(
                                namecontroller.text,
                                pricecontroller.text,
                                codecontroller.text,
                                m_datecontroller.text,
                                E_datecontroller.text,
                                countcontroller.text,
                                placecontroller.text);
                          }
                          if(evailbel){
                            namecontroller.text='';
                            pricecontroller.text='';
                            codecontroller.text='';
                            m_datecontroller.text='';
                            E_datecontroller.text='';
                            countcontroller.text='';
                            placecontroller.text='';
                          }
                          x=true;
                        },
                        child: Text(
                          '${lang ? 'Add_product' : ' اضاف المنتج'}',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),

                      ),
                    ):CircularProgressIndicator(),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }

  Widget myychildtext(text) => Text(
        '$text',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      );

  Widget myinput(controller, TextInputType type, label,context) => Container(
        height: 90,
        child: TextFormField(
          decoration: InputDecoration(
            label: Text(
              '$label',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
            ),
            suffixIcon: Icon(Icons.text_fields),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),



          validator: (value) {
            if (value!.isEmpty) {
              return '${lang ? 'must be fill this field' : 'لا يمكن ان يكون الحقل فارغ '}';
            } else
              return null;
          },
          controller: controller,
          maxLines: 2,
          keyboardType: type,
          textAlign: TextAlign.left,
        ),
      );

  Widget Myinputlist(
    controller,
    TextInputType type,
    label,
      context
  ) =>
      Row(
        children: [
          Expanded(child: myinput(controller, type, '$label',context)),
        ],
      );

}
