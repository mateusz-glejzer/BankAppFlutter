import 'package:flutter/cupertino.dart';
import 'transaction_model.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionViewModel transationData;
  const TransactionWidget(this.transationData, {super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(transationData.name,
          style: const TextStyle(color: CupertinoColors.black)),
      subtitle: Text(
          '${transationData.date.day} / ${transationData.date.month} / ${transationData.date.year}',
          style: const TextStyle(color: CupertinoColors.black)),
      trailing: Text(transationData.sum,
          style: const TextStyle(color: CupertinoColors.black)),
    );
  }
}
