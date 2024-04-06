import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleScreen extends StatefulWidget {
  const SingleScreen({super.key});

  @override
  State<SingleScreen> createState() => _SingleScreenState();
}

class _SingleScreenState extends State<SingleScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.amberAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Please Login to Continue", style:  TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w700)),
            SizedBox(height: 20,),
            decoration(context, TextField(controller: username,decoration: const InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.transparent,
              hintText: "Enter Username",
              contentPadding: EdgeInsets.only(left: 10),
              hintStyle: TextStyle(color: Colors.black)
            ),
            style:  TextStyle(color: Colors.black),
            )),
            SizedBox(height: 10,),
            decoration(context, TextField(controller: password,obscureText: true,decoration: const InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.transparent,
              hintText: "Enter Password",
              contentPadding: EdgeInsets.only(left: 10),
              hintStyle:    TextStyle(color: Colors.black),
            ),
              style:  TextStyle(color: Colors.black),
            )),
            SizedBox(height: 15,),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width/2.3,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12)
              ),
              alignment: Alignment.center,
              child: Text("Login",style:  TextStyle(color: Colors.white,fontSize: 22)),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not have account ?",style:  TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 18)),
                Text("SignIn",style:  TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold))
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget decoration(BuildContext context,Widget widget){
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width/1.3,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12)
      ),
      child: widget,
    );
  }
}
