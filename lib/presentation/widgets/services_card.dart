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
  final int saldo;
  final int idTransaksi;

  const ServicesCard({
    super.key,
    required this.icon,
    required this.saldo,
    required this.label,
    required this.memberId,
    required this.idTransaksi,
  });

  @override
  State<ServicesCard> createState() => _ServicesCardState();
}

class _ServicesCardState extends State<ServicesCard> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nominalController = TextEditingController();
    bool invalidInput = false;
    String formLabel = getTransactionLabel(widget.idTransaksi);

    void saveTransaction() {
      int nominal = int.parse(nominalController.text.replaceAll('.', ''));
      BlocProvider.of<TabunganBloc>(context).add(TransaksiTabungan(
        memberId: widget.memberId,
        idTransaksi: widget.idTransaksi,
        nominal: nominal,
      ));
      Navigator.pop(context);
      Navigator.pop(context);
    }

    void showConfirmationDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 0),
            child: Container(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 30, left: 20, right: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 300,
              width: 350,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.blue[100],
                    ),
                    child: const Icon(
                      Icons.warning_amber,
                      color: Color.fromRGBO(31, 65, 187, 1),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Are you sure?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "This action cannot be undone. All values associated with this member will be lost.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        saveTransaction();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(31, 65, 187, 1),
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(40),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      child: const Text(
                        "Save Transaction",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: const Size.fromHeight(40),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(color: Colors.grey)),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    void onSaveTap(StateSetter setState) {
      String cleanedText = nominalController.text.replaceAll('.', '');

      if (nominalController.text.isEmpty || !_isNumeric(cleanedText)) {
        setState(() {
          invalidInput = true;
          Timer(const Duration(seconds: 3), () {
            setState(() {
              invalidInput = false;
            });
          });
        });
      } else {
        showConfirmationDialog();
      }
    }

    return GestureDetector(
      onTap: () {
        // servicesDialog(context);
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 20, right: 20, bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            formLabel,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xFF1F41BB),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              const Text(
                                "Current Balance : ",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                formatCurrency(widget.saldo),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: TextField(
                              controller: nominalController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                isDense: true,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 15, right: 8),
                                  child: Text(
                                    "Rp.",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
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
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.warning_amber_rounded),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      "Make sure your transaction amount is correct. Every transaction is recorded instantly!",
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
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
                          padding: const EdgeInsets.only(top: 20),
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
                              "Save Transaction",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
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
          },
        );
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

  String formatCurrency(dynamic number) {
    NumberFormat currencyFormat = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );

    return currencyFormat.format(number);
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter =
      NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    int value = int.parse(newValue.text.replaceAll('.', ''));
    String newText = _formatter.format(value);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
