import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onboarding_app/utils/format_utils.dart';

Widget buildPhoneInput(TextEditingController inputController, String label,
    String hintText, bool numberInput, ValueNotifier<bool> isValid) {
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
                    textAlignVertical: TextAlignVertical.center,
                    controller: inputController,
                    onChanged: (text) {
                      isValid.value = inputController.text.isNotEmpty &&
                          (numberInput
                              ? isNumeric(inputController.text) ||
                                  inputController.text.contains('-')
                              : true);
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
                          : const Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 15, right: 8, bottom: 2),
                        child: Text(
                          "+62",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 0, minHeight: 0),
                    ),
                    inputFormatters: [PhoneNumberFormatter()],
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

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-digit characters
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');

    // If the text is too long, keep the old value
    if (text.length > 12) {
      return oldValue;
    }

    // Format the text as 821-2345-6789
    String formattedText = text;
    if (text.length > 3 && text.length <= 7) {
      formattedText = '${text.substring(0, 3)}-${text.substring(3)}';
    } else if (text.length > 7) {
      formattedText =
          '${text.substring(0, 3)}-${text.substring(3, 7)}-${text.substring(7)}';
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
