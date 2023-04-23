import 'package:bank_app/model/accountPanelViewModel.dart';
import 'package:bank_app/model/currencyCode.dart';
import 'package:bank_app/Transactions/transactionViewModel.dart';
import 'package:flutter/material.dart';
import '../../Transactions/transactionWidget.dart';
import '../../Transactions/transactionProvider.dart';
import 'accountPanel.dart';

class Accounts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  late AccountPanelViewModel _accountPanelViewModel;

//TODO move from mock data to backend
  getAccountData(AccountPanelViewModel accountPanelViewModel) {
    _accountPanelViewModel = accountPanelViewModel;
  }

  List<TransactionViewModel> transactions = [];
  @override
  void initState() {
    getAccountData(
        new AccountPanelViewModel(CurrencyCode.PL, "Polski zloty", "269"));
    getTransactions();
    super.initState();
  }
  Future<void> getTransactions() async {
    final transactionList = await getTransations();
    setState(() {
      transactions = transactionList;
    });
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
                children: [
                  AccountPanel(_accountPanelViewModel),
                  Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 3,
                      child: ListView.builder(
                          itemCount: transactions.length,
                          itemBuilder: (context, index) =>
                              TransactionWidget(transactions[index]))),
                ],
              ),
            ]),
      ),
    );
  }
}
