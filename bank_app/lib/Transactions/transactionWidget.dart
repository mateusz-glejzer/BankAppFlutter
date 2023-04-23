import 'package:flutter/material.dart';
import 'transactionViewModel.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionViewModel transationData;
  const TransactionWidget(this.transationData, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(transationData.name),
      subtitle: Text(
          '${transationData.date.day} / ${transationData.date.month} / ${transationData.date.year}'),
      trailing: Text(transationData.sum),
    );
  }
}
