import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildHeader(BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Color.fromRGBO(31, 65, 187, 1),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      ),
    ),
    padding: const EdgeInsets.only(top: 55, left: 30, right: 30, bottom: 30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(31, 65, 187, 1),
              size: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            "Create new member",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "Organizing your members allows you to generate quotes faster and track them more efficiently.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}
