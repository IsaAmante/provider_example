import 'package:exemplo_belo/src/consts/palette.dart';
import 'package:flutter/material.dart';

class BeloAppBar extends AppBar {
  BeloAppBar(
      {required String title,
      bool showDrawer = false,
      Function()? leadingAction})
      : super(
            title: Text(title),
            backgroundColor: Palette.primaryColor,
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: showDrawer
                ? GestureDetector(
                    onTap: leadingAction ?? () {},
                    child: Icon(Icons.menu_outlined),
                  )
                : null,
            actions: [
              GestureDetector(
                onTap: () {},
                child: Icon(Icons.search_outlined),
              ),
            ]);
}
