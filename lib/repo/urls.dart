import 'package:flutter/cupertino.dart';

class UrlsApi {
  static const String trends =
      "https://api.giphy.com/v1/gifs/trending?api_key=OA8hjFxeteQtrr9PGoRU1Q6QxU19n57i&limit=25&rating=g";

  static String searchUrl(String a, int n) {
    return "https://api.giphy.com/v1/gifs/search?api_key=OA8hjFxeteQtrr9PGoRU1Q6QxU19n57i&q=${a}&limit=${25}&offset=${n}&rating=g&lang=en";
  }
}

enum Prev {
  original,
  fixedWidth,
  fixedHeight,
  looping,
  preview,
}

class Quality {
  String original() {
    return "original";
  }

  String fixedWidth() {
    return "fixed-width";
  }

  String fixedHeight() {
    return "fixed-height";
  }

  String looping() {
    return "looping";
  }

  String preview() {
    return "preview";
  }

  String small() {
    return "fixed_width_small";
  }
}
