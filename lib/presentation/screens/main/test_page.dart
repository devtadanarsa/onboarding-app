import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TestPage extends StatelessWidget {
  TestPage({super.key});

  final nameController = TextEditingController();
  final nomorIndukController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();

  final ValueNotifier<bool> isNameValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isNomorIndukValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isAddressValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isPhoneValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isDobValid = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Column(
              children: [
                _buildTextInput(
                    nameController, "Full Name", "John Marston", isNameValid),
                _buildTextInput(nomorIndukController, "Nomor Induk", "100",
                    isNomorIndukValid),
                _buildTextInput(
                    addressController, "Address", "Denpasar", isAddressValid),
                _buildTextInput(phoneController, "Phone Number", "08123456789",
                    isPhoneValid),
                _buildDateInput(
                    context, dobController, "Date of Birth", isDobValid),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F41BB),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(10),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(13.0),
                      child: Text(
                        "Save Member",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
            padding: const EdgeInsets.only(top: 30),
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
              "Organizing your customers help you create quicker quotes and keep track of them easier",
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

  Widget _buildTextInput(TextEditingController inputController, String label,
      String hintText, ValueNotifier<bool> isValid) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
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
                        isValid.value = text.isNotEmpty;
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
                            width:
                                2.5, // Set the border width here for enabled state
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width:
                                2.5, // Set the border width here for focused state
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

  Widget _buildDateInput(BuildContext context, TextEditingController controller,
      String label, ValueNotifier<bool> isValid) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
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
                  onTap: () => _selectDate(context, controller, isValid),
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
                        width:
                            2.5, // Set the border width here for enabled state
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width:
                            2.5, // Set the border width here for focused state
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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

  Future<void> _selectDate(BuildContext context,
      TextEditingController controller, ValueNotifier<bool> isValid) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      controller.text = formatDate(pickedDate.toString());
      isValid.value = true;
    }
  }

  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateFormat outputFormat = DateFormat('MMM dd, yyyy');
    return outputFormat.format(dateTime);
  }
}
