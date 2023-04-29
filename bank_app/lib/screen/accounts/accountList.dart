import 'package:flutter/cupertino.dart';

import '../../model/accountTileModel.dart';
import 'accountTile.dart';

class AccountList extends StatefulWidget {
  final List<AccountTileModel> accounts;
  const AccountList(this.accounts, {super.key});
  @override
  State<StatefulWidget> createState() => _AccountListState(accounts);
}

class _AccountListState extends State<AccountList> {
  final List<AccountTileModel> accounts;
  _AccountListState(this.accounts);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 3,
      child: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) => AccountTile(accounts[index]),
      ),
    );
  }
}
