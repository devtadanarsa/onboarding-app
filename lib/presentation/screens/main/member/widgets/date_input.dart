import 'package:flutter/material.dart';
import 'package:onboarding_app/utils/date_utils.dart';

Widget buildDateInput(
  BuildContext context,
  TextEditingController controller,
  String label,
  ValueNotifier<bool> isValid,
  Function(String) onDateSelected,
) {
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
          child: ValueListenableBuilder<bool>(
            valueListenable: isValid,
            builder: (context, value, child) {
              return TextField(
                controller: controller,
                readOnly: true,
                onTap: () =>
                    _selectDate(context, controller, isValid, onDateSelected),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: "Select Date",
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
                      width: 2.5, // Set the border width here for enabled state
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2.5, // Set the border width here for focused state
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  suffixIcon: value
                      ? const Icon(Icons.check, color: Colors.green)
                      : const Icon(Icons.calendar_today),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

Future<void> _selectDate(BuildContext context, TextEditingController controller,
    ValueNotifier<bool> isValid, Function(String) onDateSelected) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );

  if (pickedDate != null) {
    controller.text = formatDate(pickedDate.toString());
    onDateSelected(pickedDate.toString());
    isValid.value = true;
  }
}
