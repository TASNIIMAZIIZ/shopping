import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoping/models/Product.dart';

import '../../constants.dart';

// class AddToCart extends StatelessWidget {
//
//   final _auth = FirebaseAuth.instance;
//   late String userEmail;
//
//   void getCurrentUserEmail() async {
//     userEmail = (await _auth.currentUser!.email)!;
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: SizedBox(
//               height: 50,
//               child: ElevatedButton.icon(
//                 style:ElevatedButton.styleFrom(
//                     backgroundColor: product.color
//                 ),
//
//                 onPressed: () async {
//                   getCurrentUserEmail();
//                   print(userEmail);
//                     try{
//                       var response= await FirebaseFirestore.instance.collection("cart").add({
//                         "id":product.id ,
//                         "title": product.title ,
//                         "price": product.price,
//                         "size": product.size,
//                         "shortdesc":product.shortdesc,
//                         "image": product.image,
//                         "type":product.type,
//                         "quantity":numOfItems,
//                         "user":userEmail,
//                       });
//
//                       print("SUCCESS");
//
//                     }catch(e){
//                       log(e.toString());
//
//                     }
//                 },
//                 icon: SvgPicture.asset(
//                         "assets/icons/add_to_cart.svg",
//                         color: Colors.white,
//                       ),
//                 label:  Text(
//                   "Add to Cart".toUpperCase(),
//                   style: TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


class AddToCart extends StatefulWidget {
  const AddToCart({
    required Key? key,
    required this.product,
    required this.numOfItems
  }) : super(key: key);
  final int numOfItems;
  final Product product;

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  get product => widget.product;
  get numOfItems => widget.numOfItems;
  final _auth = FirebaseAuth.instance;
  static String userEmail="";
  void getCurrentUserEmail() async {
    final user = await _auth.currentUser!.email;
    print(user);
    userEmail=user!;
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                style:ElevatedButton.styleFrom(
                    backgroundColor: product.color
                ),

                onPressed: () async {
                  getCurrentUserEmail();
                  try{
                    var response= await FirebaseFirestore.instance.collection("cart").add({
                      "id":product.id ,
                      "title": product.title ,
                      "price": product.price,
                      "size": product.size,
                      "shortdesc":product.shortdesc,
                      "image": product.image,
                      "type":product.type,
                      "quantity":numOfItems,
                      "user":userEmail,
                    });

                    print("SUCCESS");

                  }catch(e){
                    log(e.toString());

                  }
                },
                icon: SvgPicture.asset(
                  "assets/icons/add_to_cart.svg",
                  color: Colors.white,
                ),
                label:  Text(
                  "Add to Cart".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

