import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageWidget extends StatelessWidget {
  final Uri path;

  PageWidget(this.path);

  @override
  Widget build(BuildContext context) {
    // workaround - see https://github.com/flutter/flutter/issues/17419
    var file = File.fromUri(path);
    var bytes = file.readAsBytesSync();
    //
     var image = Image.file(
        file,
        height: 100,//double.infinity,
        width: 120,//double.infinity,
       fit: BoxFit.fill,
     );
    //Image image = Image.memory(bytes);
//    return Image(
//      image : NetworkImage(image.toString())
//    );
    return image;
//    return Container(
//      height: double.infinity,
//      width: double.infinity,
//      child: Center(child: image),
//    );
  return image;
  }
}
