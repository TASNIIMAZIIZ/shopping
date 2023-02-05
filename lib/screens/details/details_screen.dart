import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoping/constants.dart';
import 'package:shoping/models/Product.dart';
import 'package:shoping/screens/cart.dart';

import 'add_to_cart.dart';
import 'components/color_and_size.dart';
import 'components/description.dart';
import 'components/product_title_with_image.dart';


class DetailsScreen extends StatefulWidget {
  final Product product;
  const DetailsScreen({required Key? key, required this.product}) : super(key: key);
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  get product => widget.product;
  int numOfItems=1;
  final _auth = FirebaseAuth.instance;
  static String userEmail="";
  void getCurrentUserEmail() async {
    final user = await _auth.currentUser!.email;
    print(user);
    userEmail=user!;
    print(userEmail);
  }
  // var total;
  // var quan=0;
  // gettotal()async{
  //   try{
  //     total=0;
  //     QuerySnapshot querySnap = await FirebaseFirestore.instance.collection('cart')
  //         .where('user', isEqualTo: userEmail).get();
  //     var down=querySnap.docs.length;
  //     while(down>0){
  //       quan=querySnap.docs[down-1]["price"]*querySnap.docs[down-1]["quantity"];
  //       total=total+quan;
  //       print(down);
  //       print(total);
  //       down--;
  //     }
  //     setState(() {
  //     });
  //     print("SUCCESS");
  //   }catch(e){
  //     log(e.toString());
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // each product have a color
        backgroundColor: product.color,
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: size.height * 0.3),
                          padding: EdgeInsets.only(
                            top: size.height * 0.12,
                            left: kDefaultPaddin,
                            right: kDefaultPaddin,
                          ),
                          // height: 500,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              ColorAndSize(product: product, key: null,),
                              SizedBox(height: kDefaultPaddin / 2),
                              Description(product: product, key: null,),
                              SizedBox(height: kDefaultPaddin / 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[

                                      Container(
                                          child: TextButton(
                                            onPressed:(){
                                              setState(() {
                                                if(numOfItems!=0){
                                                  numOfItems--;
                                                  print(numOfItems);
                                                }
                                              });
                                            } ,
                                            child: Text("-",style: TextStyle(fontSize: 50),),
                                          )
                                      ),

                                      Container(width: 60,height: 40,
                                          child: Text(numOfItems.toString(),style: TextStyle(fontSize: 30),)
                                      ),


                                      Container(
                                          child: TextButton(
                                            onPressed:(){
                                              setState(() {
                                                numOfItems++;
                                                print(numOfItems);

                                              });
                                            } ,
                                            child: Text("+",style: TextStyle(fontSize: 50),),
                                          )
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF6464),
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset("assets/icons/heart.svg"),
                                  ),
                                ],),
                              SizedBox(height: kDefaultPaddin / 2),
                              AddToCart(product: product, key: null, numOfItems: numOfItems,),
                            ],
                          ),
                        ),
                        ProductTitleWithImage(product: product, key: null,),
                      ],
                    ),
                  ),
                ])));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: product.color,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset("assets/icons/cart.svg"),
          onPressed: () {
            getCurrentUserEmail();
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Cart(key: null, product: product, userEmail: userEmail,)));
          },
        ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}

