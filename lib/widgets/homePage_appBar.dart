import 'package:flutter/material.dart';

AppBar HomePageAppBar() {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.black,
    title: Image.network(
        'https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif'),
  );
}
