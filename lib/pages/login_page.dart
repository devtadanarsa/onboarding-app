import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordHidden = true;
  bool _invalidInput = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _warningText = "";

  void onPasswordOpenTap() {
    setState(() {
      _passwordHidden = !_passwordHidden;
    });
  }

  void onSignInTap() {
    if (!EmailValidator.validate(_emailController.text)) {
      setState(() {
        _invalidInput = true;
        Timer(const Duration(seconds: 3), () {
          setState(() {
            _invalidInput = false;
          });
        });
        _warningText = "Please enter a valid email";
      });
    } else if (_passwordController.text.isEmpty) {
      setState(() {
        _invalidInput = true;
        Timer(const Duration(seconds: 3), () {
          setState(() {
            _invalidInput = false;
          });
        });
        _warningText = "Password can't be empty!";
      });
    } else {
      Navigator.pushNamed(context, "/otp");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background-img.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login Here",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(31, 65, 187, 1),
                    fontSize: 30,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  "Welcome back you've\n been missed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    contentPadding: const EdgeInsets.all(20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: (_invalidInput ? Colors.red : Colors.white),
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: (_invalidInput
                            ? Colors.red
                            : const Color(0xFF1F41BB)),
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF1F4FF),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: _passwordController,
                  obscureText: _passwordHidden,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: (_passwordHidden
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                        onPressed: () {
                          onPasswordOpenTap();
                        },
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: (_invalidInput ? Colors.red : Colors.white),
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: (_invalidInput
                            ? Colors.red
                            : const Color(0xFF1F41BB)),
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF1F4FF),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 20),
                child: const Text(
                  "Forgot your password?",
                  style: TextStyle(
                    color: Color(0xFF1F41BB),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: () {
                    onSignInTap();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F41BB),
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _invalidInput,
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      _warningText,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/register");
                  },
                  child: const Text(
                    "Create new account",
                    style: TextStyle(
                      color: Color(0xFF494949),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 70),
                child: const Text(
                  "Or continue with",
                  style: TextStyle(
                    color: Color(0xFF1F41BB),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color(0xFFECECEC),
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: const Icon(Icons.apple),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color(0xFFECECEC),
                      ),
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(Icons.facebook),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color(0xFFECECEC),
                      ),
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(Icons.android),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
