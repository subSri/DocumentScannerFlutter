import 'dart:async';
import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scanbot_sdk_example_flutter/info/generic_app_theme.dart';
import 'package:scanbot_sdk_example_flutter/info/image_view/image_view_screen.dart';
import 'package:scanbot_sdk_example_flutter/info/ui_view/title_view.dart';

import 'package:scanbot_sdk_example_flutter/pages_repository.dart';

import 'package:flutter/material.dart';

import '../home.dart';
import 'main.dart';
import 'package:permission_handler/permission_handler.dart';


class PdfPreview extends StatefulWidget {
  final PageRepository pR;




  const PdfPreview({Key key,this.pR, this.animationController}) : super(key: key);
//  final PageRepository pR;
  final AnimationController animationController;
  @override
  _PdfPreviewState createState() => _PdfPreviewState(pR);
}

class _PdfPreviewState extends State<PdfPreview>
    with TickerProviderStateMixin {
  int _page = 0;

  PageRepository pR;
  _PdfPreviewState(this.pR);
  GlobalKey _bottomNavigationKey = GlobalKey();


  Future<Directory> getDemoStorageBaseDirectory() async {
    Directory storageDirectory;
    if (Platform.isAndroid) {
      Future<Directory> storageDirectory1 = DownloadsPathProvider.downloadsDirectory;
      return storageDirectory1;
    }
    else if (Platform.isIOS) {
      storageDirectory = await getApplicationDocumentsDirectory();
    }
    else {
      throw("Unsupported platform");
    }

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
   dir = Directory(path+"/DocScan") ;
  print(dir.path.toString());
  if (_status == PermissionStatus.granted){
    print("Granted");
    setState(() {
      this.allfiles = dir.listSync(recursive: true, followLinks: false);


        if (_files!=null){
          this._files.clear();
        }
        for (int i = 0; i < allfiles.length; i++) {
          print(allfiles[i].path);
          if (allfiles[i].path.endsWith('.pdf')) {
            this._files.add(allfiles[i]);
          }
        }

      print("test status");
      print(_files);
    });
  }
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
    const int count = 0;
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
        allfiles: allfiles,
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
      color: AppTheme.background,
      child: Scaffold(
        bottomNavigationBar:CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 2,
            height: 50.0,
            items: <Widget>[
              Icon(Icons.home, size: 30),
              Icon(Icons.list, size: 30),
              Icon(Icons.book, size: 30),
              Icon(Icons.call_split, size: 30),
              Icon(Icons.perm_identity, size: 30),
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.blueAccent,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              if (index==0){
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return
                  AppHomeScreen(pR);})
                );
              }
//              if (index==2) {
//                Navigator.pop(context);
//
//                Navigator.of(context).push(
//                    MaterialPageRoute(builder: (BuildContext context) {
//                      return
//                        PdfPreview(
//                            animationController: widget.animationController
//                        );
//                    })
//                );
//              }
              if (index==1) {

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return
                        TrainingScreen(
                            pR: pR, animationController: widget.animationController,
                        );
                    })
                );
              }
              setState(() {
                _page = index;
              });
            },
          ),
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

//              widget.animationController.forward();
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
                    color: AppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey
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
                                    fontFamily: AppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22 + 6 - 6 * topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: AppTheme.darkerText,
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

//
//  void _updatePdflist() {
//
//    Future.delayed(Duration(microseconds: 500)).then((val) {
//      setState(() {
//        this._files = dir.listSync(recursive: false, followLinks: false);
//      });
//    });
//  }
//
//





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
