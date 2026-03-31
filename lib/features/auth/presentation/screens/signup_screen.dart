import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:partsrunner/core/widget/customButton.dart';
import '../../../../core/routes/app_route_names.dart';
import '../../../../core/widget/CustomTextFIeld.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final _passwordController = TextEditingController();
    final _emailController = TextEditingController();
    final _nameController = TextEditingController();
    final _phoneController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Center(
                child: Column(
                  children: const [
                    Text(
                      "Create Your Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Sign up and enjoy your experience",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              Text(
                "Name",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              CustomTextField(
                hintText: "Enter your name",
                isPassword: false,
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "name can't be empty";
                  }

                  return null;
                },
              ),
              SizedBox(height: 15),

              Text(
                "Email",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              CustomTextField(
                hintText: "Email",
                isPassword: false,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email can't be empty";
                  }
                  if (!RegExp(
                    r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                  ).hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Text(
                "Mobile number",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IntlPhoneField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xffFAFAFB),

                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Color(0xff535353)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Color(0xff535353)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Color(0xff535353)),
                  ),
                ),
                initialCountryCode: 'BD',
                onChanged: (phone) {
                  _phoneController.text = phone.completeNumber;
                  print("Phone: ${_phoneController.text}");
                },
                onCountryChanged: (country) {
                  print('Country changed to: ${country.name}');
                },
                validator: (value) {
                  if (value == null || value.number.isEmpty) {
                    return 'Phone number is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Text(
                "Password",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              CustomTextField(
                hintText: "Password",
                isPassword: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password can't be empty";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              Text(
                "Confirm Password",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              CustomTextField(
                hintText: "Confirm Password",
                isPassword: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password can't be empty";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              Text(
                "Company Name",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              CustomTextField(
                hintText: "Enter Your Company Name",
                isPassword: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password can't be empty";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Text(
                "Business Address",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              CustomTextField(
                hintText: "Enter Your Company Name",
                isPassword: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password can't be empty";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),

              CustomButton(
                text: "Create Account",
                submit: () {

                  // Navigator.pushNamed(context, RouteNames.loginScreen);
                },
                backgroundColor: Color(0xffFF4000),
                textColor: Colors.white,
              ),
              SizedBox(height: 15),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "If Already have Account ?  ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: "Login  ",
                        style: TextStyle(color: Color(0xffFF4000)),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
