import 'package:bank_app/screen/Accounts/Transaction.dart';
import 'package:flutter/material.dart';

class Accounts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [Column(
        children: [
          Transaction(),
          Transaction(),
          Transaction(),
          Transaction(),
        ],
      ),
    ])),;
  }
}
