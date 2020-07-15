



import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';

// ignore: must_be_immutable, camel_case_types
class Boom_Menu extends StatelessWidget{
  String currentPdf;
  List<FileSystemEntity> files;

  BuildContext context;



  Boom_Menu(this.files,this.currentPdf,this.context);


  void onDeletetPdf(files,path) {
    files.remove(path);
    Navigator.pop(context,files);
  }

  void onOpenPdf(path) {
  }

  void onSharePdf(path){

  }



//  void _updatePdflist() {
//
//    Future.delayed(Duration(microseconds: 500)).then((val) {
//      setState(() {
//        this._files = dir.listSync(recursive: false, followLinks: false);
//      });
//    });
//  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BoomMenu(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        //child: Icon(Icons.add),
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
//        scrollVisible: scrollVisible,
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        children: [
          MenuItem(
            child: Icon(Icons.accessibility, color: Colors.black),
            title: "Profiles",
            titleColor: Colors.white,
            subtitle: "You Can View the Noel Profile",
            subTitleColor: Colors.white,
            backgroundColor: Colors.deepOrange,
            onTap: () => print('FIRST CHILD'),
          ),
          MenuItem(
            child: Icon(Icons.brush, color: Colors.black),
            title: "Profiles",
            titleColor: Colors.white,
            subtitle: "You Can View the Noel Profile",
            subTitleColor: Colors.white,
            backgroundColor: Colors.green,
            onTap: () => print('SECOND CHILD'),
          ),
//          MenuItem(
//            child: Icon(Icons.keyboard_voice, color: Colors.black),
//            title: "Profile",
//            titleColor: Colors.white,
//            subtitle: "You Can View the Noel Profile",
//            subTitleColor: Colors.white,
//            backgroundColor: Colors.blue,
//            onTap: () => print('THIRD CHILD'),
//          ),
//          MenuItem(
//            child: Icon(Icons.ac_unit, color: Colors.black),
//            title: "Profiles",
//            titleColor: Colors.white,
//            subtitle: "You Can View the Noel Profile",
//            subTitleColor: Colors.white,
//            backgroundColor: Colors.blue,
//            onTap: () => print('FOURTH CHILD'),
//          )
        ],
      ),
    );
  }
  }


