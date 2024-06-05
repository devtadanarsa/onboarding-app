import 'package:flutter/material.dart';

Widget buildTextInput(TextEditingController inputController, String label,
    String hintText, ValueNotifier<bool> isValid) {
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: isValid,
                builder: (context, value, child) {
                  return TextField(
                    controller: inputController,
                    onChanged: (text) {
                      isValid.value = inputController.text.isNotEmpty;
                    },
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2.5,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2.5,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2.5,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      suffixIcon: value
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
