import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gifs_api/widgets/homePage_appBar.dart';
import 'package:share/share.dart';

class GifPage extends StatelessWidget {
  GifPage(this._gifData);
  final Map _gifData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePageAppBar(),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(_gifData["images"]["original"]['url']),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _gifData["title"],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            IconButton(
                icon: Icon(Icons.share),
                color: Colors.white,
                onPressed: () {
                  Share.share(_gifData['images']['original']['url']);
                }),
          ],
        ),
      ),
    );
  }
}
