import 'package:bank_app/model/transactionViewModel.dart';
import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
 final TransactionViewModel transationData;
  const Transaction(this.transationData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [Text(transationData.name),Text(transationData.date)],
        ),
        Text(transationData.sum)
      ],
    );
  }
}
