import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (text.length > 12) {
      return oldValue;
    }

    String formattedText = _formatPhoneNumber(text);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  static String _formatPhoneNumber(String text) {
    String formattedText = text;
    if (text.length > 3 && text.length <= 7) {
      formattedText = '${text.substring(0, 3)}-${text.substring(3)}';
    } else if (text.length > 7) {
      formattedText =
          '${text.substring(0, 3)}-${text.substring(3, 7)}-${text.substring(7)}';
    }
    return formattedText;
  }

  static String formatPhoneNumber(String phoneNumber) {
    final text = phoneNumber.replaceAll(RegExp(r'\D'), '');
    return _formatPhoneNumber(text);
  }
}
