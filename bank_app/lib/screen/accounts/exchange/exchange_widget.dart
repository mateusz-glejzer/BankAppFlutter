import 'dart:convert';

import 'package:bank_app/screen/accounts/exchange/exchange_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../model/account_tile_model.dart';
import '../../../providers/accounts_provider.dart';
import '../../../providers/transaction_provider.dart';

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
  late int buyValue;

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Selected value is too small to exchange'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  void _showExchangeConfirmationDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content:
            Text('Do you want to buy amount of: $buyValue of chosen currency?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              exchangeMoney(
                _itemSelectedToSell.currencyCode,
                _itemSelectedToBuy.currencyCode,
                int.parse(_sellTextController.text),
                buyValue,
              );
            },
            child: const Text('Yes'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    accounts = getAllAccounts();
    _itemSelectedToSell = accounts[0];
    _itemSelectedToBuy = accounts[1];
    _sellTextController = TextEditingController(text: '0');
    buyValue = 0;
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
              child: Text(buyValue.toString()),
            ),
          ],
        ),
        Column(
          children: [
            CupertinoButton(
              onPressed: () => {
                //TODO validate request if an user has correct amount of money
                print(_itemSelectedToSell.currencyCode.toString()),
                previewExchange(ExchangePreview(
                        _itemSelectedToSell.currencyCode.toString(),
                        _itemSelectedToBuy.currencyCode.toString(),
                        int.parse(_sellTextController.text)))
                    .then((response) {
                  var json = jsonDecode(response.body);
                  var value = json['Message'];
                  if (value > 0) {
                    setState(() {
                      buyValue = value;
                    });
                    _showExchangeConfirmationDialog(context);
                  } else {
                    setState(() {
                      buyValue = 0;
                    });
                    _showAlertDialog(context);
                  }
                }),
              },
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
