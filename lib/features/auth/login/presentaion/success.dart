import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partsrunner/core/widget/customButton.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/icons/success.png", height: 200, width: 200),
          Text(
            "Success",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          Text(
            "Nice to see you again. Get your parts delivered with tracking parts in real-time!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 20),
          CustomButton(
            text: "Get Started",
            submit: () {},
            backgroundColor: Color(0xffFF4000),
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
