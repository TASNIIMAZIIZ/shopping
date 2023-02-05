import 'dart:developer';

import 'package:shoping/home.dart';
import 'package:shoping/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}


class _LoginState extends State<Login> {

  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();
  bool isLoading=false;
  var message="";
  login()async{
    try{
      isLoading=true;
      setState(() {});
      var response=await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      print("SUCCESS");
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => MyApp()));

    }catch(e){
      log(e.toString());
      message=e.toString();
    }
    isLoading=false;
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          title: Text("login"),

        ),
        body:SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child:TextField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "username",
                      hintText: "enter your email"),
                  style:TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child:TextField(
                  controller: password,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ("password"),
                      hintText: "enter your password"),
                  style:TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue// background
                  ),
                  onPressed: () => login(),
                  child: isLoading?CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ) :Text("login",style: TextStyle(fontSize: 25),),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 65,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Register()));
                  },
                  child:Text("register",style: TextStyle(fontSize: 25,color: Colors.black),),
                ),
              ),
              SizedBox(height: 20,),
              Text(message,style: TextStyle(color: Colors.red,fontSize: 20),)
            ],
          ),
        )

    );
  }
}
