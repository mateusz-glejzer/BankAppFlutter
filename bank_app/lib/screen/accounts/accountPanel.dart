import 'package:flutter/material.dart';

class AccountPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountPanelState();
}

class _AccountPanelState extends State<AccountPanel> {
  //fake data just to style component- later to fetch data
  final int currentAmmount = 0;
  final String currencyName = "Polish Zloty";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(currentAmmount.toString()),
                    Text(currencyName)
                  ],
                ),
                CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage("./web/icons/pl-flag.png"))
              ],
            ),
            Row(children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("Add Money"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Exchange"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.menu),
              )
            ]),
          ]),
        ],
      ),
    );
  }
}
