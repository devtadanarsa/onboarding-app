import 'package:flutter/material.dart';

class CustomSnackBar {
  static show(BuildContext context, String status, String message) {
    Color backgroundColor;
    Color borderColor;
    Color iconColor;
    IconData icon;
    String title;

    switch (status) {
      case "success":
        backgroundColor = Colors.green[100]!;
        borderColor = Colors.green.withAlpha(90);
        iconColor = Colors.greenAccent;
        icon = Icons.check_circle;
        title = "Success";
        break;
      case "error":
        backgroundColor = Colors.red.withAlpha(80);
        borderColor = Colors.red.withAlpha(90);
        iconColor = Colors.redAccent;
        icon = Icons.error;
        title = "Error";
        break;
      default:
        backgroundColor = Colors.orange.withAlpha(80);
        borderColor = Colors.orange.withAlpha(90);
        iconColor = Colors.orangeAccent;
        icon = Icons.error;
        title = "Warning";
    }

    SnackBar snackBar = SnackBar(
      margin: const EdgeInsets.symmetric(vertical: 0),
      duration: const Duration(seconds: 5),
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      content: Container(
        width: double.infinity,
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor, width: 2),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        color: Colors.black.withOpacity(.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.close,
                  color: Colors.black.withOpacity(.8),
                ),
              ),
            )
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
