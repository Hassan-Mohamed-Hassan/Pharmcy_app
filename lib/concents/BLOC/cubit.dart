

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pharmcy_project/concents/BLOC/states.dart';
import 'package:pharmcy_project/concents/MODELS/Add_drags_model.dart';
import 'package:pharmcy_project/concents/MODELS/userdatamodel.dart';
import 'package:pharmcy_project/concents/cash/cashHealper.dart';
import 'package:pharmcy_project/pharmcy/ProductSearch.dart';
import 'package:pharmcy_project/pharmcy/Login.dart';
import 'package:pharmcy_project/pharmcy/Register.dart';
import 'package:pharmcy_project/pharmcy/add_product.dart';
import 'package:pharmcy_project/pharmcy/Sales.dart';
import 'package:pharmcy_project/pharmcy/Verfiy_Phone.dart';
import 'package:pharmcy_project/pharmcy/pharmcy_Home.dart';
import 'package:pharmcy_project/pharmcy/phone.dart';
import 'package:pharmcy_project/pharmcy/update_product.dart';

import '../compents.dart';

class cubit extends Cubit<states> {
  cubit() : super(intailstates());
  var iconpassword = Icon(Icons.visibility_off);
  static cubit getcubit(context) {
    return BlocProvider.of(context);
  }
  bool scur = true;

  void rebuild(){
    loding=false;
    emit(scussfirestoretate());
  }

  void changepasswordrdicon() {
    scur = !scur;

    if (scur) {
      iconpassword = Icon(Icons.visibility_off);
    } else
      iconpassword = Icon(Icons.remove_red_eye);
      emit(changeiconstate());
    }
  Future Register(controlleremail, controllerpassword, phone, name, context)async {
    UserName=name;
    loding=true;
   await FirebaseAuth.instance.createUserWithEmailAndPassword(email: controlleremail, password: controllerpassword)
      .then((value){
      Uid = value.user!.uid;
      user= FirebaseAuth.instance.currentUser;
      verfiyfromnumber=true;
      loding =false;
     if(finsh) Navigator.push(context, MaterialPageRoute(builder: (context)=>(Phone(phone))));
      CacheHelper.saveData(key: 'UID', value: '${value.user!.uid}');
    }).catchError((e) {
     loding =false;
      Fluttertoast.showToast(
          msg: "${e.message}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      print(e.message);
      emit(errorRegisterstate());
    });

  }


  Future Login(phone,context,)async{

    List AllPhones=[];
    String?uidOfPhone;
    await FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot snapshot){
      snapshot.docs.forEach((element) {
        AllPhones.add('${element['phone']}');
        print(element['phone']);
        if(phone==element['phone']){
          uidOfPhone=element['uid'];
          print(uidOfPhone);
        }
      });
          print(AllPhones);
    });
    if(AllPhones.contains('$phone')){
      print(AllPhones);
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.verifyPhoneNumber(
        phoneNumber: '+20$phone',
        verificationCompleted: (PhoneAuthCredential credential) async {
          emit(scussfirestoredrags());
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
          VerificationCode = verificationId;
        },
        verificationFailed: (FirebaseAuthException e) {
          verified=false;
          Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
          emit(scussfirestoredrags());
          print(e);
          tost('The provided phone number is not valid.', Colors.red, 5);
        },
        codeSent: (String verificationId, int? resendToken) async {
          VerificationCode=verificationId;
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
              OTPScreen('$phone',uidOfPhone!)),(Route<dynamic> route) => false,);
        },
      );
    }
    else
    {
       Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      emit(scussfirestoredrags());
      Fluttertoast.showToast(
          msg: "This Number Not Found",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 6,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

  }

  Future<void> VerfiyPhoneNumbyer(phone,context,widget,uidOfPhone) async {
    List AllPhones=[];
    await FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot snapshot){
      snapshot.docs.forEach((element) {
        AllPhones.add('${element['phone']}');
        print(element['phone']);
      });
      print(AllPhones);
    });

      if( AllPhones.contains('$phone')==false){
        FirebaseAuth auth = FirebaseAuth.instance;
        await auth.verifyPhoneNumber(
          phoneNumber: '+20$phone',
          verificationCompleted: (PhoneAuthCredential credential) async {
            emit(scussfirestoredrags());
          },
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verificationId) {
            VerificationCode=verificationId;
          },
          verificationFailed: (FirebaseAuthException e) {
            DeletUser();
            verified=false;
            Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisterScrenn()));
            emit(scussfirestoredrags());
            Fluttertoast.showToast(
                msg: "'The provided phone number is not valid.'",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 6,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          },
          codeSent: (String verificationId, int? resendToken) async {
            VerificationCode=verificationId;
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OTPScreen('$phone',uidOfPhone!)),(Route<dynamic> route) => false,);
          },
        );
      }
      else
      {
        print(Phone);
        FirebaseAuth.instance.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScrenn()));
        verified=false;
        emit(scussfirestoredrags());
        Fluttertoast.showToast(
            msg: "This Number is Registered By Anther User Change Number Phone ",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 6,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

    emit(scussfirestoredrags());


  }

  void updatephone(phone,){
      FirebaseFirestore.instance.collection('users').doc('$UserName').update({'phone':'$phone'}).then((value){
      }).catchError((e){});
    }
  Future savedatainfirestor(name, phone, email, uid, context)async {
    usermodel model = usermodel(name, email, phone, uid);
    FirebaseFirestore.instance
        .collection('users')
        .doc('$name')
        .set(model.toJson())
        .then((value) {
          emit(scussfirestoredrags());

    }).catchError((er) {
      print(er.toString());
      emit(errorfirestorestate());
    });
  }

  void add_product(name, price, code, m_date, E_date, count, place) {
    Drags_Model model;
    model = Drags_Model(name, price, code, count, E_date, m_date, place);
    FirebaseFirestore.instance
        .collection('${CacheHelper.getData(key: 'UID')}-Drags')
        .get()
        .then((QuerySnapshot querySnapshot) {
          List<String> docses=[];
          querySnapshot.docs.forEach((doc) {
           docses.add(doc.id);
          });

      if (docses.contains('$name')) {
        tost(lang?'This Product Name Already Exists Search for in Search Screen Or Update Screen to Update':
            'اسم المنتج هذا موجود بالفعل ، ابحث عنه في شاشة البحث أو شاشة التحديث لتحديث هذا المنتج'
            , Colors.red,15);
        evailbel=true;

      }
      else {
        FirebaseFirestore.instance
            .collection('${CacheHelper.getData(key: 'UID')}-Drags')
            .doc('${model.name}')
            .set(model.toJson())
            .then((value) {
          currentTime = DateFormat.Hms().format(DateTime.now());
          currentDay = DateFormat.yMd().format(DateTime.now());
          setHiatory('Add','$name',currentTime,currentDay,price,count);
          tost('${lang ? 'Product added Successfully' : 'تم اضافة المنتج بنجاح'}',Colors.blue,4);
          evailbel=true;
          emit(scussfirestoredrags());
        }).catchError((er) {
          tost(
              '${lang ? 'Product No Can added,Try Agin!!' : 'لم  يضاف المنتج حول مرة اخري'}',Colors.red,6);
          evailbel=false;
          emit(errorfirestoredrags());
        });
      }

    });

emit(scussfirestoretate());

        }
  Drags_Model? model;
  Drags_Model? model2;

  Future get_product(name) async{
  await  FirebaseFirestore.instance
        .collection('${CacheHelper.getData(key: 'UID')}-Drags')
        .doc('$name')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        evailbel = true;
        model = Drags_Model.fromJson(documentSnapshot.data());
        evailbel = true;
        model = Drags_Model.fromJson(documentSnapshot.data());
        namecontroller.text = model!.name!;
        countcontroller.text = model!.count!;
        placecontroller.text = model!.place!;
        E_datecontroller.text = model!.E_date!;
        pricecontroller.text = model!.price!;
        m_datecontroller.text = model!.M_date!;
        codecontroller.text = model!.code!;
        /////////////////////////////////////////
        name2 = model!.name;
        count = model!.count!;
        place = model!.place;
        E_date = model!.E_date;
        price = model!.price;
        M_date = model!.M_date;
        code = model!.code!;
        emit(scussfirestoredrags());
      } else {
        evailbel = false;
        loding=false;
        emit(scussfirestoredrags());
        Fluttertoast.showToast(
            msg: "This Product Not Found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        emit(scussfirestoretate());
      }
    }).catchError((er) {
      print(er.toString());
      emit(errorfirestoredrags());
    });
  }

  void delete_product(newname, name) {
    FirebaseFirestore.instance
        .collection('${CacheHelper.getData(key: 'UID')}-Drags')
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<String> docses=[];
      querySnapshot.docs.forEach((doc) {
        docses.add(doc.id);
      });

      if (docses.contains('$newname')&&newname!=name) {
        tost(lang?'This Product Name Already Exists Search for in Search Screen Or Chanage This Name':
        'اسم المنتج هذا موجود بالفعل ، ابحث عنه في شاشة البحث أو غير اسم المنتج'
            , Colors.red,15);
        evailbel=true;

      }else{

    FirebaseFirestore.instance
        .collection('${CacheHelper.getData(key: 'UID')}-Drags')
        .get()
        .then((QuerySnapshot querySnapshot) {

            FirebaseFirestore.instance
                .collection('${CacheHelper.getData(key: 'UID')}-Drags')
                .doc('$name')
                .get()
                .then((DocumentSnapshot documentSnapshot) {
                 if (documentSnapshot.exists) {
                FirebaseFirestore.instance.collection('${CacheHelper.getData(key: 'UID')}-Drags').doc('$name').delete();
                FirebaseFirestore.instance.collection('${CacheHelper.getData(key: 'UID')}-Drags').doc('$newname').set(
                    {
                      'name': namecontroller.text,
                      'code': codecontroller.text,
                      'price': pricecontroller.text,
                      'M_date': m_datecontroller.text,
                      'E_date': E_datecontroller.text,
                      'count': countcontroller.text,
                      'place': placecontroller.text,
                    });
                currentTime = DateFormat.Hms().format(DateTime.now());
                currentDay = DateFormat.yMd().format(DateTime.now());
                setHiatory('Update','${name!=newname? name+'>>'+'$newname':name}',currentTime,currentDay,
                    pricecontroller.text
                    ,countcontroller.text);
                evailbel=false;
                emit(scussfirestoretate());
              }
            });
            tost('Product has been Updeted Successfully',Colors.blue,5);
            emit(scussfirestoretate());

        });}
        });

  }
  
  Future confrimSales(context, name) async {
   await get_product(name);
    var c = int.parse(count);
    c = c - 1;
    if (c >= 0) {
      currentTime = DateFormat.Hms().format(DateTime.now());
      currentDay = DateFormat.yMd().format(DateTime.now());
      setHiatory('Sales', '$name', '$currentTime',currentDay,price,count);
      Drags_Model m = Drags_Model(
          name,
          price,
          code,
          '$c',
          E_date,
          M_date,
          place);
     await FirebaseFirestore.instance.collection(
          '${CacheHelper.getData(key: 'UID')}-Drags').doc('${name}').
           update(m.toJson()).then((value){
        tost('Done Operation Successful', Colors.blue, 4);
        confirm(
            context,
            content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('Product_name  : $name'),
        SizedBox(
        height: 5,
        ),
        Text('Available Quantity  : $c'),
        SizedBox(
        height: 5,
        ),
        Text('Product price : $price'),
        ],
        ),
        textOK: const Text('OK'),
        textCancel: const Text('Cancel'),
        ).then((value){
         int x=int.parse(price);
         Sum+=x;
          CacheHelper.saveData(key: 'sum', value: Sum);
          loding=false;
          emit(scussfirestoredrags());
        });
      });
    }
    else {
      confirm(
        context,
        title: const Text('Confirm'),
        content: Text('Quantity is not available for this product'),
        textOK: const Text('OK'),
        textCancel: const Text('Cancel'),
      ).then((value){
        loding=false;
        emit(scussfirestoredrags());
      });

  }
  }

  int index = 0;
  List<Widget> screnn = [
    Sales_productt(),
    Add_product(),
    homescreen(),
    Update_product(),
  ];

  List<Icon> icon = [
    Icon(Icons.shopping_cart),
    Icon(Icons.add),
    Icon(Icons.search),
    Icon(Icons.update),
  ];

  void changeNav(index) {
    this.index = index;
    evailbel = false;
    emit(scussfirestoretate());
  }

  void changelang() {
    lang = !lang;
    emit(scussRegisterstate());
  }

  void gethistory(String day) {
    FirebaseFirestore.instance
        .collection( '${CacheHelper.getData(key: 'UID')}-merkting_history').where('Day', isEqualTo: '$day')
        .get()
        .then((QuerySnapshot querySnapshot) {
      Time = [];
      Price = [];
      Count = [];
      Type = [];
      Name = [];
      querySnapshot.docs.forEach((doc) {
        Time.add('${doc['Time']}');
        Name.add('${doc['Name']}');
        Count.add('${doc['Count']}');
        Price.add('${doc['Price']}');
        Type.add('${doc['Type']}');
        emit(scussfirestoredrags());
      });
    });
    print(Price);
  }

  void getdayhistory() {
    FirebaseFirestore.instance
        .collection('${CacheHelper.getData(key: 'UID')}-merkting_history').orderBy('Day',descending:true )
        .get()
        .then((QuerySnapshot querySnapshot) {
      Day = [];
      querySnapshot.docs.forEach((doc) {
        if (!Day.contains('${doc['Day']}')) {
          Day.add('${doc['Day']}');
        }
        emit(scussfirestoredrags());
      });
    });


  }
  void setHiatory(type,name,currentTime,currentDay,price,count){
  Map<String, dynamic> map = {
    'Time': currentTime,
    'Type': type,
    'Day': currentDay,
    'Name': name,
    'Price': price,
    'Count': count
  };

  FirebaseFirestore.instance.collection('${CacheHelper.getData(key: 'UID')}-merkting_history').doc('$currentTime')
      .set(map).then((value) {});
}
  Future SalesPycode(code,context)async {
   await FirebaseFirestore.instance
        .collection('${CacheHelper.getData(key: 'UID')}-Drags')
        .get()
        .then((QuerySnapshot querySnapshot) {
      Code = [];
      Name = [];
      querySnapshot.docs.forEach((doc) {
          Code.add('${doc['code']}');
          Name.add('${doc['name']}');
      });
   });
     if(Code.contains(code)){
       int indexCode= Code.indexOf(code);
       String NameSales=Name[indexCode];
       confrimSales(context, NameSales);
     }
     else
       tost('This Code Not Found', Colors.red, 5);
       loding =false;
        emit(scussfirestoretate());
  }

  Future getAllProduct(context,AllProductScreen)async {
   await FirebaseFirestore.instance
        .collection('${CacheHelper.getData(key: 'UID')}-Drags')
        .get()
        .then((QuerySnapshot querySnapshot) {
      Code = [];
      Name = [];
      Price=[];
      Count=[];
      querySnapshot.docs.forEach((doc) {
          Code.add('${doc['code']}');
          Name.add('${doc['name']}');
          Count.add('${doc['count']}');
          Price.add('${doc['price']}');
      });

   });

   Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProductScreen));
        emit(scussfirestoretate());
  }

  Future logout(context) async{
   await confirm(
      context,
      content: Text(lang?'Are You Sure Want To Logout':'هل انت متأكد انك تريد الخروج',style:
      TextStyle(fontSize: 20,color: Colors.blue)
        ,),
      textOK: const Text('OK'),
      textCancel: const Text('Cancel'),
    ).then((value){
     print('.........///////////');
      CacheHelper.saveData(key: "UID", value: '').then((value){
        print(CacheHelper.getData(key: "UID"));
        print('.........///////////');
      });
    emit(scussfirestoretate());
    });
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
    );
  }
 Future DeletUser() async{
   await user?.delete();
   emit(scussfirestoredrags());}

void verifiyfromNumberMessage(phone,uidofphone,context){
  savedatainfirestor(controllername.text, phone, controlleremail.text,uidofphone, context);
  finsh=false;
  verfiyfromnumber=false;
  Register(controlleremail.text, controllerpassword.text,
      controllerphone.text, controllername.text, context);
}

}
