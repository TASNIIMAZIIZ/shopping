import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoping/constants.dart';
import 'package:shoping/login.dart';
import 'package:shoping/screens/cart.dart';
import 'package:shoping/screens/home/components/bag.dart';
import 'package:shoping/screens/home/components/dress.dart';
import 'package:shoping/screens/home/components/foot.dart';
import 'package:shoping/screens/home/components/jewel.dart';
import 'package:flutter_svg/svg.dart';


class MyApp extends StatefulWidget {

  const MyApp({
    Key? key,
  }) : super(key: key);

  @override

  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _auth = FirebaseAuth.instance;
  static String userEmail="";
  void getCurrentUserEmail() async {
    final user = await _auth.currentUser!.email;
    print(user);
    userEmail=user!;
    print(userEmail);
  }

  var total;
  var quan=0;
  gettotal()async{
    try{
      total=0;
      QuerySnapshot querySnap = await FirebaseFirestore.instance.collection('cart')
          .where('user', isEqualTo: userEmail).get();
      var down=querySnap.docs.length;
      while(down>0){
        quan=querySnap.docs[down-1]["price"]*querySnap.docs[down-1]["quantity"];
        total=total+quan;
        print(down);
        print(total);
        down--;
      }
      setState(() {});
      print(total);
      print("SUCCESS");
    }catch(e){
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: SvgPicture.asset("assets/icons/back.svg"),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Login()));
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/search.svg",
                  // By default our  icon color is white
                  color: kTextColor,
                ),
                onPressed: () {
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/cart.svg",
                  color: kTextColor,
                ),
                onPressed: () {
                  getCurrentUserEmail();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Cart(key: null, product: null, userEmail: userEmail,)));
                  },
              ),
              SizedBox(width: kDefaultPaddin / 2)
            ],
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: Text(
                "women",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            bottom: const TabBar(
              indicatorColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.all(10),
              tabs: [
                Tab(child: Text("Hand bag",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:kTextColor,
                ),
                ),
                ),
                Tab(child: Text("Jewellery",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:kTextColor,
                ),),),
                Tab(child: Text("Shoes",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:kTextColor,
                ),),),
                Tab(child: Text("Dresses",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:kTextColor,
                ),),),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              bag(),
              Jewel(),
              // Icon(Icons.directions_transit),
              foot(),
              dress(),
            ],
          ),
        ),
      ),
    );
  }
}



