import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Enter OTP",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "To verify your email address,\nplease enter the OTP sent to your email:\n kristin***i.com",
          ),
          PinInput(
            length: 5,
            builder: (context, cells) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: cells.map((cell) {
                  return Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(12),
                      color: cell.isFocused ? Color(0xffFFF4EE) : Colors.grey[200],
                    ),
                    child: Center(
                      child: Text(
                        cell.character ?? '',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            onCompleted: (pin) => print('PIN: $pin'),
          )


        ],
      ),
    );
  }
}
