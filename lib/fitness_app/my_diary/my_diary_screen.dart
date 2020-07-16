
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:scanbot_sdk_example_flutter/pages_repository.dart';

import '../ui_view/glass_view.dart';
import '../ui_view/mediterranesn_diet_view.dart';
import '../ui_view/title_view.dart';
import '../fintness_app_theme.dart';
import 'meals_list_view.dart';
import 'package:flutter/material.dart';
import 'package:scanbot_sdk_example_flutter/pdfviewcurved/detailsPage.dart';
import 'package:scanbot_sdk_example_flutter/fitness_app/fintness_app_theme.dart';
import 'package:scanbot_sdk_example_flutter/fitness_app/my_diary/meals_list_view.dart';


class MyDiaryScreen extends StatefulWidget {
  final PageRepository pR;

  const MyDiaryScreen({Key key,this.pR, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState(pR);
}

class _MyDiaryScreenState extends State<MyDiaryScreen>
    with TickerProviderStateMixin {
  final PageRepository pR;


  _MyDiaryScreenState(this.pR);
  AnimationController animationController;
  Animation<double> topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
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
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void addAllListData() {
    const int count = 9;

    listViews.add(
      TitleView(
        titleTxt: 'DocScan Board',

        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
    listViews.add(
      MediterranesnDietView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
    listViews.add(
      TitleView(
        titleTxt: 'Featured',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      MealsListView(
        pR:pR,
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(

                parent: widget.animationController,
                curve: Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );



    listViews.add(
      GlassView(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController,
                  curve: Interval((1 / count) * 8, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FintnessAppTheme.background,
      child: Scaffold(
//        bottomNavigationBar: CurvedNavigationBar(
//          key: _bottomNavigationKey,
//          index: 2,
//          height: 50.0,
//          items: <Widget>[
//            Icon(Icons.home, size: 30),
//            Icon(Icons.list, size: 30),
//            Icon(Icons.book, size: 30),
//            Icon(Icons.call_split, size: 30),
//            Icon(Icons.perm_identity, size: 30),
//          ],
//          color: Colors.white,
//          buttonBackgroundColor: Colors.white,
//          backgroundColor: Colors.blueAccent,
//          animationCurve: Curves.easeInOut,
//          animationDuration: Duration(milliseconds: 600),
//          onTap: (index) {
//            if (index==2)
//              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return
//                PdfPreview(animationController: animationController
//                );})
//              );
//            if (index==0)
//              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return
//                MyDiaryScreen(animationController: animationController
//                );})
//              );
//            setState(() {
//              _page = index;
//            });
//          },
//        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
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
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
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
                                  'DScanOCR',
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
//                            SizedBox(
//                              height: 38,
//                              width: 38,
//                              child: InkWell(
//                                highlightColor: Colors.transparent,
//                                borderRadius: const BorderRadius.all(
//                                    Radius.circular(32.0)),
//                                onTap: () {},
//                                child: Center(
//                                  child: Icon(
//                                    Icons.keyboard_arrow_left,
//                                    color: FintnessAppTheme.grey,
//                                  ),
//                                ),
//                              ),
//                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),

                                  ),

                                ],
                              ),
                            ),
//                            SizedBox(
//                              height: 38,
//                              width: 38,
//                              child: InkWell(
//                                highlightColor: Colors.transparent,
//                                borderRadius: const BorderRadius.all(
//                                    Radius.circular(32.0)),
//                                onTap: () {},
//                                child: Center(
//                                  child: Icon(
//                                    Icons.keyboard_arrow_right,
//                                    color: FintnessAppTheme.grey,
//                                  ),
//                                ),
//                              ),
//                            ),
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
}
