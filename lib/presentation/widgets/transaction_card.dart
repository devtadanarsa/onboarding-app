import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final int transactionId;
  final String date;
  final int amount;

  const TransactionCard({
    super.key,
    required this.transactionId,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    String transactionLabel = getTransactionLabel(transactionId);
    String formattedDate = formatDate(date);
    String formattedAmount = formatCurrency(amount);
    IconData transactionIcon = getTransactionIcon(transactionId);

    return Container(
      margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                transactionIcon,
                size: 40,
                color: const Color.fromRGBO(31, 65, 187, 1),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactionLabel,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "${(transactionId == 3 || transactionId == 6) ? "-" : "+"} $formattedAmount",
            style: TextStyle(
              fontSize: 14,
              color: (transactionId == 3 || transactionId == 6)
                  ? Colors.red
                  : Colors.green,
              // color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String getTransactionLabel(int transactionId) {
    const transactionLabels = {
      1: "Saldo Awal",
      2: "Trans. Simpanan",
      3: "Trans. Penarikan",
      4: "Bunga Simpanan",
      5: "Koreksi Tambah",
      6: "Koreksi Kurang",
    };

    return transactionLabels[transactionId] ?? "Transaksi";
  }

  String formatDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateFormat outputFormat = DateFormat('MMM dd, yyyy - HH:mm');
    return outputFormat.format(dateTime);
  }

  IconData getTransactionIcon(int transactionId) {
    switch (transactionId) {
      case 1:
        return Icons.account_balance_wallet_outlined;
      case 2:
        return Icons.auto_graph_sharp;
      case 3:
        return Icons.clean_hands_outlined;
      case 4:
        return Icons.interests;
      case 5:
        return Icons.add;
      case 6:
        return Icons.remove;
      default:
        return Icons.monetization_on;
    }
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
