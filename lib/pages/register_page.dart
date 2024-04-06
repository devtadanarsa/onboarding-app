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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: TextField(
                  decoration: InputDecoration(
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
                  onPressed: () {},
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
