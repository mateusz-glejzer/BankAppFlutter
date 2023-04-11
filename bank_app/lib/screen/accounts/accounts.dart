import 'package:bank_app/model/transactionViewModel.dart';
import 'package:bank_app/screen/Accounts/Transaction.dart';
import 'package:flutter/material.dart';

import 'accountPanel.dart';

class Accounts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountsState();
}

//Implement later transaction fetching
getTransations() {}

List<Transaction> transactions = [
  Transaction(new TransactionViewModel("John", "10.09.09", "2137")),
  Transaction(new TransactionViewModel("Paul", "11.10.22", "1234")),
];

class _AccountsState extends State<Accounts> {
  @override
  void initState() {
    getTransations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Center(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [AccountPanel(), Column(children: transactions)],
              ),
            ]),
      ),
    );
  }
}
