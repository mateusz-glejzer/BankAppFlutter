import 'package:bank_app/screen/accounts/account_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../model/account_tile_model.dart';
import '../../../providers/accounts_provider.dart';

class ExchangeWidget extends StatefulWidget {
  const ExchangeWidget({super.key});
  @override
  State<StatefulWidget> createState() => _ExchangeWidgetState();
}

class _ExchangeWidgetState extends State<ExchangeWidget> {
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  late List<AccountTileModel> accounts;

  late AccountTileModel _itemSelectedToSell;
  late AccountTileModel _itemSelectedToBuy;
  late TextEditingController _sellTextController;
  late TextEditingController _buyTextController;

  @override
  void initState() {
    super.initState();
    accounts = getAllAccounts();
    _itemSelectedToSell = accounts[0];
    _itemSelectedToBuy = accounts[1];
    _sellTextController = TextEditingController(text: '0');
    _buyTextController = TextEditingController(text: '0');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //TODO: extract to a reusable widget
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select currency to sell:',
              style: TextStyle(color: CupertinoColors.white),
            ),
            CupertinoButton(
              onPressed: () => _showDialog(
                CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  onSelectedItemChanged: (int selectedItem) {
                    setState(() {
                      _itemSelectedToSell = accounts[selectedItem];
                    });
                  },
                  children: List<Widget>.generate(accounts.length, (int index) {
                    return Center(
                      child: Text(
                        accounts[index].currencyName,
                      ),
                    );
                  }),
                ),
              ),
              child: Text(
                _itemSelectedToSell.currencyName,
                style: const TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
            Text(
              "Amount:",
              style: TextStyle(color: CupertinoColors.white),
            ),
            SizedBox(
              width: 200,
              child: CupertinoTextField(
                controller: _sellTextController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select currency to sell:',
              style: TextStyle(color: CupertinoColors.white),
            ),
            CupertinoButton(
              onPressed: () => _showDialog(
                CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  onSelectedItemChanged: (int selectedItem) {
                    setState(() {
                      _itemSelectedToBuy = accounts[selectedItem];
                    });
                  },
                  children: List<Widget>.generate(accounts.length, (int index) {
                    return Center(
                      child: Text(
                        accounts[index].currencyName,
                      ),
                    );
                  }),
                ),
              ),
              child: Text(
                _itemSelectedToBuy.currencyName,
                style: const TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
            Text(
              "Amount:",
              style: TextStyle(color: CupertinoColors.white),
            ),
            SizedBox(
              width: 200,
              child: CupertinoTextField(
                controller: _buyTextController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            CupertinoButton(
              onPressed: () => {},
              child: const Text(
                'Exchange',
                style: TextStyle(color: CupertinoColors.white),
              ),
            ),
            CupertinoButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Go back',
                style: TextStyle(color: CupertinoColors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
