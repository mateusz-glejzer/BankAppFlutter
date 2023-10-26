import 'package:bank_app/model/currency_code.dart';
import 'package:bank_app/Transactions/transaction_model.dart';
import 'package:bank_app/screen/accounts/account_list.dart';
import '../../Transactions/transaction_widget.dart';
import '../../providers/accounts_provider.dart';
import '../../providers/transaction_provider.dart';
import '../../model/account_tile_model.dart';
import 'account_panel.dart';
import 'package:flutter/cupertino.dart';

class Accounts extends StatefulWidget {
  const Accounts(this.Token, {super.key});
  final String? Token;

  @override
  State<StatefulWidget> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  late List<AccountTileModel> _accounts = [
    //do smth with loading rather than showing this temporary solution
    AccountTileModel(CurrencyCode.pln, "Loading", "0")
  ];
  bool showAccountList = false;
  late AccountTileModel currentAccount;
  late ValueNotifier<AccountTileModel> currentAccountNotifier;

//TODO move from mock data to backend
  getAccountData(
      Future<List<AccountTileModel>> accountPanelViewModelFunc) async {
    _accounts = await accountPanelViewModelFunc;
    setState(() {
      currentAccount = _accounts[0];
    });
  }

  setCurrentAccount(AccountTileModel model) {
    setState(() {
      currentAccount = model;
      showAccountList = false;
      this.getTransactions(model.currencyCode);
    });
  }

  toogleAccountList() {
    setState(() {
      showAccountList = !showAccountList;
    });
  }

  List<TransactionViewModel> transactions = [];
  @override
  void initState() {
    getAccountData(getUserAccounts(widget.Token!));
    getTransactions(CurrencyCode.pln);
    currentAccount = _accounts[0];
    super.initState();
  }

  Future<void> getTransactions(CurrencyCode currencyCode) async {
    final transactionList = await getTransations(currencyCode, widget.Token!);
    setState(() {
      transactions = transactionList;
    });
  }

  @override
  Widget build(BuildContext context) {
    getTransactions(currentAccount.currencyCode);
    return Column(
      children: [
        Expanded(
          child: Container(
            color: CupertinoColors.lightBackgroundGray,
            child: Center(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: AccountPanel(currentAccount,
                                toogleAccountList, widget.Token!)),
                        SizedBox(
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
          ),
        ),
        Visibility(
          visible: showAccountList,
          maintainState: true,
          child: Expanded(
            child: AccountList(widget.Token!, _accounts, setCurrentAccount),
          ),
        ),
      ],
    );
  }
}
