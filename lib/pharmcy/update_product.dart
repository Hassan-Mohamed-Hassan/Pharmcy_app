import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pharmcy_project/concents/BLOC/cubit.dart';
import 'package:pharmcy_project/concents/BLOC/states.dart';
import 'package:pharmcy_project/concents/compents.dart';

class Update_product extends StatelessWidget {


  var formkey=GlobalKey<FormState>();
  TextEditingController name=TextEditingController();
  var scaffoldkey=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit,states>(
        builder: (context, state) {
          cubit c=cubit.getcubit(context);
      return  Scaffold(

        key:scaffoldkey ,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                myychildtext( '${lang?'Enter Ptoduct Name To update':'ادخل اسم المنتج لتعديل '}'),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('${lang?'Product_Name':'اسم المنتج'}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),

                    suffixIcon: Icon(Icons.text_fields),

                    border:OutlineInputBorder(borderRadius: BorderRadius.circular(20),) ,

                  ),
                  controller: name,

                  validator: (value){

                    if(value!.isEmpty){

                      return 'must be fill this field';

                    }

                    else

                      return null;

                  },

                    onFieldSubmitted: (value){

                    c.get_product(value.toString());
                    print(namecontroller.text);
               },
                  maxLines: 2,

                  keyboardType: TextInputType.text,

                  textAlign: TextAlign.left,

                ),
                SizedBox(height: 20,),
                if(evailbel)Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Myinputlist(namecontroller, TextInputType.text, '${lang?'Product_Name':'اسم المنتج'}'),
                        SizedBox(height: 10,),
                        Myinputlist(pricecontroller, TextInputType.number,'${lang?'Product_Price':'سعر المنتج'}'),
                        SizedBox(height: 10,),
                        Myinputlist(codecontroller, TextInputType.text, '${lang?'Product_Code':'كود المنتج'}'),
                        SizedBox(height: 10,),
                        Myinputlist(countcontroller, TextInputType.number, '${lang?'Product_Count':'الكمية المتاحة'}'),
                        SizedBox(height: 10,),
                        Myinputlist(m_datecontroller, TextInputType.datetime, '${lang?' Product_M.Date':'تاريخ الانتاج'}'),
                        SizedBox(height: 10,),
                        Myinputlist(E_datecontroller, TextInputType.datetime, '${lang?' Product_EXP.Date':'تاريخ الانتهاء'}'),
                        SizedBox(height: 10,),
                        Myinputlist(placecontroller, TextInputType.text, '${lang?'Product_Place':'مكان المنتج'}'),
                        SizedBox(height: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width*1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),

                          child: MaterialButton(onPressed: (){
                            if(formkey.currentState!.validate()){
                              c.delete_product(namecontroller.text,name.text);

                            }
                            else
                            tost('Product Not Updeted ',Colors.red,5);
                            },
                            child: const Text('Update_product',style: TextStyle(color: Colors.white,fontSize: 22),),
                          ),
                        ),
                        SizedBox(height: 20,)
                      ],
                    ),
                  ),
                ),


              ],),
          ),
        ),
      );
    },
        listener: (context,state){});

  }
  Widget myychildtext(text)=>Text('$text',style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold),);
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
    Expanded(child: myinput(controller, type,'$label')),
  ],);
}
