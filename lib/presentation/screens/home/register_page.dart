import 'dart:async';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _passwordHidden = true;
  bool _confirmPasswordHidden = true;
  bool _invalidInput = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _warningText = "";

  void onInvalidInput(String message) {
    setState(() {
      _invalidInput = true;
      Timer(const Duration(seconds: 3), () {
        setState(() {
          _invalidInput = false;
        });
      });
      _warningText = message;
    });
  }

  void onPasswordOpenTap() {
    setState(() {
      _passwordHidden = !_passwordHidden;
    });
  }

  void onConfirmPasswordOpenTap() {
    setState(() {
      _confirmPasswordHidden = !_confirmPasswordHidden;
    });
  }

  void onRegisterTap() {
    if (_nameController.text.isEmpty) {
      onInvalidInput("Name can't be empty!");
    } else if (!EmailValidator.validate(_emailController.text)) {
      onInvalidInput("Please enter a valid email");
    } else if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      onInvalidInput("Password can't be empty!");
    } else if (_passwordController.text != _confirmPasswordController.text) {
      onInvalidInput("Password doesn't match!");
    } else {
      signUp();
    }
  }

  void signUp() async {
    const String apiUrl = "https://mobileapis.manpits.xyz/api";

    final dio = Dio();
    try {
      final response = await dio.post("$apiUrl/register", data: {
        "name": _nameController.text,
        "email": _emailController.text,
        "password": _passwordController.text
      });

      if (response.statusCode != 200) {
        throw DioException.connectionTimeout;
      }

      if (mounted) {
        Navigator.pushNamed(context, "/login");
      }
    } on DioException catch (e) {
      print("Error ${e.response?.statusCode} - ${e.response?.data}");
      onInvalidInput("Some error occurred, please try again!");
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
                "Create Account",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(31, 65, 187, 1),
                    fontSize: 30,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "Create an account so you can explore all \nthe existing jobs",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    contentPadding: EdgeInsets.all(20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF1F41BB), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF1F4FF),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    contentPadding: EdgeInsets.all(20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF1F41BB), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF1F4FF),
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
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF1F41BB), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF1F4FF),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: _confirmPasswordHidden,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: IconButton(
                        icon: (_confirmPasswordHidden
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                        onPressed: () {
                          onConfirmPasswordOpenTap();
                        },
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF1F41BB), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF1F4FF),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  onPressed: () {
                    onRegisterTap();
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
                      "Sign Up",
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
                    Navigator.pushNamed(context, "/login");
                  },
                  child: const Text(
                    "Already have an account",
                    style: TextStyle(
                      color: Color(0xFF494949),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
