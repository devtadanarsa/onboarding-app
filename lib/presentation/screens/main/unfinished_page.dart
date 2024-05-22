import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_app/presentation/widget/custom_snackbar.dart';

class UnfinishedPage extends StatelessWidget {
  const UnfinishedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "503",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          "Page Under Construction!",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Image(
            image: AssetImage("assets/site-under-construction.png"),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 50),
          child: Text(
            "We're sorry the page you requested is under construction. Please go back to the homepage!",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(const SnackBar(content: Text("Test")));
              CustomSnackBar.show(context, "error", "hello");
            },
            child: const Text("Test")),
      ],
    );
  }
}
