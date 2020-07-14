import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../fitness_app/ui_view/title_view.dart';
import 'package:flutter/material.dart';
import '../fitness_app/fintness_app_theme.dart';
import 'main.dart';
import 'package:permission_handler/permission_handler.dart';


class PdfPreview extends StatefulWidget {



  const PdfPreview({Key key, this.animationController}) : super(key: key);
//  final PageRepository pR;
  final AnimationController animationController;
  @override
  _PdfPreviewState createState() => _PdfPreviewState();
}

class _PdfPreviewState extends State<PdfPreview>
    with TickerProviderStateMixin {

  static Future<Directory> getDemoStorageBaseDirectory() async {

  Directory storageDirectory;
  if (Platform.isAndroid) {
    storageDirectory = await getExternalStorageDirectory();
  }
  else if (Platform.isIOS) {
    storageDirectory = await getApplicationDocumentsDirectory();
  }
  else {
    throw("Unsupported platform");
  }
  print("Path is");
  print(storageDirectory.path);
  return storageDirectory;
}
  static String path ;
  static Directory dir;
List<FileSystemEntity> allfiles;

  PermissionStatus _status;
   List<FileSystemEntity> _files = new List<FileSystemEntity>();

Future<void> testStatus() async{
  print(_status);
   path = (await getDemoStorageBaseDirectory()).path;
   dir = Directory(path+"/my-custom-storage") ;
  print(dir.path.toString());
  if (_status == PermissionStatus.granted){
    print("Granted");
    setState(() {
      this.allfiles = dir.listSync(recursive: false, followLinks: false);
      if (allfiles!=null) {

        this.allfiles = dir.listSync(recursive: false, followLinks: false);
        if (_files!=null){
          this._files.clear();
        }
        for (int i = 0; i < allfiles.length; i++) {
          print(allfiles[i].path);
          if (allfiles[i].path.endsWith('.pdf')) {
            this._files.add(allfiles[i]);
          }
        }
      }
      print("test status");
      print(_files);
    });
  }
}
  _PdfPreviewState(){
//    testStatus();

  }
//    this._files = dir.listSync(recursive: false, followLinks: false);


  Animation<double> topBarAnimation;
//  List<c.Page> page ;
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override

  void initState()  {
    PermissionHandler().requestPermissions([PermissionGroup.storage])
        .then(_onStatusRequested);

//    _checkPermissions()
//    requestPermission();
//    this._files = dir.listSync(recursive: true, followLinks: false);
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    super.initState();



  }



  Future<void> addAllListData() async {
    await testStatus();
    const int count = 2;
  print("In add list View");
  print(this._files);
    listViews.add(
      TitleView(
        titleTxt: 'Saved PDFs',

        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      PdfListView(
        dir:dir,

        files:this._files,
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController,
                curve: Interval((1 / count) * 5, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FintnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:

        Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),]

      ),
    ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
//            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
//            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FintnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FintnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'My Documents',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FintnessAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: FintnessAppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }


  void _updatePdflist() {

    Future.delayed(Duration(microseconds: 500)).then((val) {
      setState(() {
//        this._files = dir.listSync(recursive: true, followLinks: false);
      });
    });
  }







  FutureOr _updateStatus(PermissionStatus status) {
    if (status!=_status){
      setState(() {
        _status=status;

      });
    }
  }

  FutureOr _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses) {
    final status = statuses[PermissionGroup.storage];
    _updateStatus(status);
    testStatus();
  }
}
