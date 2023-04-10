import 'dart:io';
import 'dart:ui';

import 'package:bank_app/screen/accounts/accounts.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: Image.file(
          File("./web/icons/blank_profile_picture.jpg"),
          width: 50,
        ),
      ),
    ]);
  }
}
