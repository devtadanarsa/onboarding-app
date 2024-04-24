import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final CountdownController _controller = CountdownController(autoStart: true);
  bool _countdownVisibility = true;

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
              const Image(image: AssetImage("assets/otp-image.png")),
              Text(
                "Enter OTP",
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
                  "Last 4 digit of this student NIM number : ",
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "I Nengah Danarsa Suniadevta",
                  style: TextStyle(color: Color.fromRGBO(31, 65, 187, 1)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: OtpTextField(
                  numberOfFields: 4,
                  onSubmit: (String verificationCode) {
                    if (verificationCode == "1060") {
                      // Navigator.pushNamed(context, "/home");
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("/home", (route) => false);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            title: Text(
                              "OTP Authentication Failed",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF1F41BB),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Text(
                                "Hint : \nI Nengah Danarsa Suniadevta's NIM Number is 2205551060"),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
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
                      "Verify",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _controller.restart();
                      },
                      child: GestureDetector(
                        onTap: () {
                          if (_countdownVisibility == false) {
                            setState(() {
                              _countdownVisibility = true;
                            });
                          }
                        },
                        child: const Text(
                          "Resend OTP",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _countdownVisibility,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Countdown(
                          controller: _controller,
                          seconds: 15,
                          onFinished: () {
                            setState(() {
                              _countdownVisibility = false;
                            });
                          },
                          build: (BuildContext context, double time) => Text(
                            "(00:${time.toStringAsFixed(0).padLeft(2, '0')})",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
