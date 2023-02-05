import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoping/home.dart';
import '../constants.dart';
import '../models/Product.dart';


class Cart extends StatefulWidget {
  final String userEmail;
  // final int total;
  const Cart({
    required Key? key,
    required this.product,
    required this.userEmail,
    // required this.total,
  }) : super(key: key);
  final Product? product;

  @override
  State<Cart> createState() => _CartState();
}
class _CartState extends State<Cart> {
get userEmail=>widget.userEmail;
// get total=>widget.total;

  var total;
  var quan=0;
  var items;
  gettotal()async{
    try{
      total=0;
      QuerySnapshot querySnap = await FirebaseFirestore.instance.collection('cart')
          .where('user', isEqualTo: userEmail).get();
      items=querySnap.docs.length;
      var down=querySnap.docs.length;
      while(down>0){
        quan=querySnap.docs[down-1]["price"]*querySnap.docs[down-1]["quantity"];
        total=total+quan;
        down--;
      }
      setState(() {});
      print("SUCCESS");
    }catch(e){
      log(e.toString());
    }
  }
@override
void initState() {
    gettotal();
  super.initState();
}

  delete(String id)async{
    try{
        setState(() {
          FirebaseFirestore.instance.collection('cart').doc(id).delete();
          print("deleted");
          gettotal();
        });
    }catch(e){
      log(e.toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
          appBar: AppBar(
            toolbarHeight: 90,
            backgroundColor: Colors.white,
            elevation: 2,
            leading: IconButton(
              icon: SvgPicture.asset(width: 40,"assets/icons/back.svg",),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyApp()));
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: SvgPicture.asset(width: 40,
                  "assets/icons/search.svg",
                  // By default our  icon color is white
                  color: kTextColor,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset(width: 40,
                  "assets/icons/cart.svg",
                  // By default our  icon color is white
                  color: kTextColor,
                ),
                onPressed: () {},
              ),
              SizedBox(width: kDefaultPaddin / 2)
            ],
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: Text(
                "Cart List",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontWeight: FontWeight.bold,fontSize: 30),
              ),
            ),
          ),
        body:Column(
          children: [
            Container(child: Row(
              children: [
                Text("items = ",style: TextStyle(fontSize: 20),),
                Text(items.toString(),style: TextStyle(fontSize: 30),),
                SizedBox(width: 20,),
                Text("total cost = ",style: TextStyle(fontSize: 20),),
                Text(total.toString(),style: TextStyle(fontSize: 30),),
              ],
            )),
            Flexible(
              child:StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("cart").where("user",isEqualTo: userEmail).snapshots(),
                  builder:(context,snapshot){
                    if(snapshot.hasError){
                      return Center(child:Text("Error pccured"));
                    }
                    if(snapshot.hasData){
                      var count=snapshot.data!.docs.length;
                      if(count>0){
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount:snapshot.data!.docs.length,
                          itemBuilder:(context,index)=>

                              GestureDetector(
                                onLongPress: (){
                                  QueryDocumentSnapshot doc = snapshot.data!.docs[index];
                                  DocumentReference docRef = doc.reference;
                                  var id=docRef.id;
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context)=>
                                        builderActionSheet(BuildContext,context,id),
                                  );
                                } ,
                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                      Container(
                                        height: 120,
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0),),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 100,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                                child: Image.asset(snapshot.data!.docs[index]["image"]),
                                              ),
                                              SizedBox(width: 10,),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 8,),
                                                    Text(snapshot.data!.docs[index]["shortdesc"],style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15),),
                                                    SizedBox(height: 10,),
                                                    Container(
                                                        child: Row(
                                                          children: [
                                                            Text("item quantity ",style: TextStyle(fontSize: 15),),
                                                            SizedBox(width: 13,),
                                                            Text(snapshot.data!.docs[index]["quantity"].toString(),style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15),)
                                                          ],
                                                        )
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Container(
                                                        child: Row(
                                                          children: [
                                                            Text("price ",style: TextStyle(fontSize: 15),),
                                                            SizedBox(width: 13,),
                                                            Text((snapshot.data!.docs[index]["price"]).toString(),style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15),)
                                                          ],
                                                        )
                                                    ),


                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                              Container(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                        child: Row(
                                                          children: [
                                                            Text("\$ ${snapshot.data!.docs[index]["price"]*snapshot.data!.docs[index]["quantity"]}",style: TextStyle(fontSize: 23,color: Colors.red,fontWeight:FontWeight.bold,),)
                                                          ],
                                                        )
                                                    ),



                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                        );

                      }

                      else{
                        return const Center(child: Text("your cart is empty",style: TextStyle(fontSize: 20,)));

                      }


                    }

                    return Center(child:CircularProgressIndicator());
                  }

              ),
            ),
          ],
        ),


        ),

    );
  }
  Widget builderActionSheet(BuildContext,context, String id)=>CupertinoTheme(
    data: CupertinoThemeData(
      primaryColor: Colors.white,
      brightness: Brightness.dark,
    ),
    child: CupertinoActionSheet(
      cancelButton: CupertinoActionSheetAction(
        onPressed: ()async {
          delete(id);
          Navigator.pop(context);
        },
        child: Text('delete'),
      ),
    ),
  );

}

