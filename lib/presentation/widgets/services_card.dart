import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onboarding_app/bloc/tabungan_bloc/tabungan_bloc.dart';

class ServicesCard extends StatefulWidget {
  final String label;
  final IconData icon;

  final int memberId;
  final int idTransaksi;

  const ServicesCard({
    super.key,
    required this.icon,
    required this.label,
    required this.memberId,
    required this.idTransaksi,
  });

  @override
  State<ServicesCard> createState() => _ServicesCardState();
}

class _ServicesCardState extends State<ServicesCard> {
  void servicesDialog(BuildContext context) {
    final TextEditingController _nominalController = TextEditingController();
    bool invalidInput = false;
    String formLabel = getTransactionLabel(widget.idTransaksi);

    void onSaveTap(StateSetter setState) {
      String cleanedText = _nominalController.text.replaceAll(',', '');

      if (_nominalController.text.isEmpty || !_isNumeric(cleanedText)) {
        setState(() {
          invalidInput = true;
          Timer(const Duration(seconds: 3), () {
            setState(() {
              invalidInput = false;
            });
          });
        });
      } else {
        int nominal = int.parse(cleanedText);
        BlocProvider.of<TabunganBloc>(context).add(TransaksiTabungan(
            memberId: widget.memberId,
            idTransaksi: widget.idTransaksi,
            nominal: nominal));
        Navigator.pop(context);
      }
    }

    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                insetPadding: EdgeInsets.zero,
                child: Container(
                  height: 250,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          formLabel,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFF1F41BB),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextField(
                            controller: _nominalController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Nominal Transaksi",
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(31, 65, 187, 1),
                                    width: 2),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter(),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: invalidInput,
                          child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: const Center(
                              child: Text(
                                "Input is invalid!",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                onSaveTap(setState);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1F41BB),
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(50),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            child: const Text(
                              "Simpan Transaksi",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        servicesDialog(context);
      },
      child: Container(
        width: 95,
        height: 95,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                widget.icon,
                size: 35,
                color: const Color.fromRGBO(31, 65, 187, 1),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTransactionLabel(int transactionId) {
    const transactionLabels = {
      1: "Saldo Awal",
      2: "Transaksi Simpanan",
      3: "Transaksi Penarikan",
      4: "Bunga Simpanan",
      5: "Koreksi Penambahan",
      6: "Koreksi Pengurangan",
    };

    return transactionLabels[transactionId] ?? "Transaksi";
  }

  bool _isNumeric(String str) {
    final numericRegex = RegExp(r'^-?[0-9]+$');
    return numericRegex.hasMatch(str);
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter =
      NumberFormat.currency(locale: 'en_US', symbol: '', decimalDigits: 0);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    int value = int.parse(newValue.text.replaceAll(',', ''));
    String newText = _formatter.format(value);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
