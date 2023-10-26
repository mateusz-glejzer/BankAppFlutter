import 'package:flutter/cupertino.dart';

import '../../model/account_tile_model.dart';
import 'account_tile.dart';

class AccountList extends StatefulWidget {
  final void Function(AccountTileModel) onAccountTileTap;
  final List<AccountTileModel> accounts;
  final String token;
  const AccountList(this.token, this.accounts, this.onAccountTileTap,
      {super.key});
  @override
  State<StatefulWidget> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  @override
  Widget build(BuildContext context) {
    final void Function(AccountTileModel) onAccountTileTap =
        widget.onAccountTileTap;
    final List<AccountTileModel> accounts = widget.accounts;
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 3,
      child: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () => {onAccountTileTap(accounts[index])},
            child: AccountTile(accounts[index], widget.token)),
      ),
    );
  }
}
