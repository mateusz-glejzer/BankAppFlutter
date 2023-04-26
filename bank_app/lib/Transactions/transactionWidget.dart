import 'package:flutter/cupertino.dart';
import 'transactionViewModel.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionViewModel transationData;
  const TransactionWidget(this.transationData, {super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(transationData.name,
          style: TextStyle(color: CupertinoColors.black)),
      subtitle: Text(
          '${transationData.date.day} / ${transationData.date.month} / ${transationData.date.year}'),
      trailing: Text(transationData.sum),
    );
  }
}
