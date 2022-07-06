// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gifs_api/pages/gif_Page.dart';
import 'package:gifs_api/repo/urls.dart';
import 'package:gifs_api/widgets/homePage_appBar.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //VARIABLES------------------------------------------------------------
  String? _search;
  int of = 0;
  //You can change this value
  int columnsNumberGrid = 3;
  //Set preview quality
  String pref = Quality().small();

  //OVERRIDES----------------------------------------------------------------
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getGifs().then((map) => print(map));
  }

  //BUILD------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HomePageAppBar(),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Search a GIF",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  // focusColor: Colors.white,
                  // fillColor: Colors.white,
                ),
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
                onSubmitted: (text) {
                  setState(() {
                    _search = text;
                  });
                },
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: FutureBuilder(
                  future: _getGifs(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Container(
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        );
                      default:
                        if (snapshot.hasError)
                          return Container(color: Colors.red);
                        else
                          return gifTable(context, snapshot);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //WIDGETS-----------------------------------------------------------------
  Widget gifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnsNumberGrid,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: _getCount(snapshot.data["data"]),
      itemBuilder: (context, index) {
        if (_search == null ||
            _search!.isEmpty ||
            index < snapshot.data['data'].length) {
          return GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage.memoryNetwork(
                image: snapshot.data['data'][index]["images"][pref]["url"],
                height: 300.0,
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
              ),
            ),
            //Open the GIF page view
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GifPage(snapshot.data["data"][index]),
                ),
              );
            },
            //Hold image to share function
            onLongPress: () {
              Share.share(snapshot.data['data'][index]["images"][pref]["url"]);
            },
          );
        } else {
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 50,
                  ),
                  Text(
                    "Load more GIFs ...",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  incrementOff();
                });
              },
            ),
          );
        }
      },
    );
  }

  //METHODS------------------------------------------------------------------
  Future<Map> _getGifs() async {
    http.Response response;

    if (_search == null || _search!.isEmpty) {
      response = await http.get(Uri.parse(UrlsApi.trends));
    } else {
      print("off atual ${of}");
      response = await http.get(Uri.parse(UrlsApi.searchUrl(_search!, of)));
    }

    ////VERIFICATION
    // print(jsonDecode(response.body));

    return jsonDecode(response.body);
  }

  int _getCount(List data) {
    if (_search == null || _search!.isEmpty) {
      return data.length;
    } else {
      return data.length + 1;
    }
  }

  void incrementOff() {
    of += 25;
  }
}
