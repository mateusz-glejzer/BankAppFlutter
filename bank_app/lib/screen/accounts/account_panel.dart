import 'package:bank_app/model/country_flag_map.dart';
import 'package:bank_app/screen/accounts/exchange/exchange_widget.dart';
import 'package:flutter/cupertino.dart';
import '../../model/account_tile_model.dart';

class AccountPanel extends StatefulWidget {
  final AccountTileModel currentAccount;
  final void Function() onGectureDetectorClicked;
  const AccountPanel(this.currentAccount, this.onGectureDetectorClicked,
      {super.key});
  @override
  State<StatefulWidget> createState() => _AccountPanelState();
}

class _AccountPanelState extends State<AccountPanel>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
  }

  bool isAccountListOpen = false;

  @override
  Widget build(BuildContext context) {
    AccountTileModel currentAccount = widget.currentAccount;
    void Function() onGectureDetectorClicked = widget.onGectureDetectorClicked;

    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(currentAccount.amount),
                  Text(currentAccount.currencyName),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (isAccountListOpen) {
                    _controller.reverse();
                  } else {
                    _controller.forward();
                  }
                  onGectureDetectorClicked();
                  setState(() {
                    isAccountListOpen = !isAccountListOpen;
                  });
                },
                child: RotationTransition(
                  turns: Tween(begin: 0.0, end: isAccountListOpen ? 0.5 : 0.0)
                      .animate(_controller),
                  child: const Icon(
                    CupertinoIcons.arrow_down,
                    color: CupertinoColors.black,
                  ),
                ),
              ),
            ],
          ),
          Image(
            width: 60.0,
            height: 60.0,
            image: AssetImage(
                CountryFlagMap.countryFlag[currentAccount.currencyCode]!),
          ),
        ],
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CupertinoButton(
          onPressed: () {},
          color: CupertinoColors.black,
          child: const Text("Add Money",
              style: TextStyle(color: CupertinoColors.white)),
        ),
        CupertinoButton(
          onPressed: () => Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) => const ExchangeWidget())),
          color: CupertinoColors.black,
          child: const Hero(
            tag: 'exchange',
            child: Text("Exchange",
                style: TextStyle(color: CupertinoColors.white)),
          ),
        ),
      ]),
    ]);
  }
}
