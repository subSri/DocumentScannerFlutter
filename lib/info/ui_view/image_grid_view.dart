import 'package:flutter/material.dart';
import 'package:scanbot_sdk_example_flutter/info/image_view/image_view_screen.dart';

import 'package:scanbot_sdk_example_flutter/pages_repository.dart';
import 'package:scanbot_sdk_example_flutter/ui/page_operations_filter.dart';
import 'package:scanbot_sdk_example_flutter/ui/pages_widget.dart';
import 'package:scanbot_sdk/common_data.dart' as c;
import '../generic_app_theme.dart';


class AreaListView extends StatefulWidget {
  final PageRepository pR;

  const AreaListView(
      {Key key,this.pR, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  @override
  _AreaListViewState createState() => _AreaListViewState(pR);
}

class _AreaListViewState extends State<AreaListView>
    with TickerProviderStateMixin {
  List<c.Page> areaListData;
  _AreaListViewState(this.pR){
    if (pR!=null){
      this.areaListData = this.pR.pages;
      print("AreaList");
      print(areaListData.length);
    }}
  PageRepository pR;

var disposev = true;
  AnimationController animationController;


  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  void _updatePagesList() {
    imageCache.clear();
    Future.delayed(Duration(microseconds: 500)).then((val) {
      setState(() {
        this.areaListData = this.pR.pages;
        print("SetAreaLsit");
        print(areaListData.length);
      });
    });
  }

  @override
  void dispose() {
    disposev = false;
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    setState(() {
//      this.context = context;
//    });
    if (pR != null && pR.pages.length!=0) {
      return AnimatedBuilder(
        animation: widget.mainScreenAnimationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
            opacity: widget.mainScreenAnimation,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
              child: AspectRatio(
                aspectRatio: 0.8,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: GridView(

                    padding: const EdgeInsets.only(
                        left: 6, right: 6, top: 6, bottom: 6),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: List<Widget>.generate(
                      areaListData.length,
                          (int index) {
                        final int count = areaListData.length;
//                      print('Count is : $count');
                        final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animationController,
                            curve: Interval((1 / count) * index, 1.0,
                                curve: Curves.fastOutSlowIn),
                          ),
                        );
                        if (disposev==true) {
                          animationController.forward();
                        }
                        return AreaView(
                          context: context,
                          pR: pR,
                          index: index,
                          alist: areaListData,
                          uri: areaListData[index].documentPreviewImageFileUri,
                          animation: animation,
                          animationController: animationController,
                        );
                      },
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 18.0,
                      crossAxisSpacing: 18.0,
                      childAspectRatio: 0.75,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    else{
      return AnimatedBuilder(
        animation: widget.mainScreenAnimationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
            opacity: widget.mainScreenAnimation,
            child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
              child: AspectRatio(
                aspectRatio: 0.8,
                child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child:Center(
                        child:Text("You havent Scanned/Imported any Images yet")
                    )
//                  child: GridView(
//
//                    padding: const EdgeInsets.only(
//                        left: 6, right: 6, top: 6, bottom: 6),
//                    physics: const BouncingScrollPhysics(),
//                    scrollDirection: Axis.vertical,
//                    children: List<Widget>.generate(
//                      areaListData.length,
//                          (int index) {
//                        final int count = areaListData.length;
////                      print('Count is : $count');
//                        final Animation<double> animation =
//                        Tween<double>(begin: 0.0, end: 1.0).animate(
//                          CurvedAnimation(
//                            parent: animationController,
//                            curve: Interval((1 / count) * index, 1.0,
//                                curve: Curves.fastOutSlowIn),
//                          ),
//                        );
//                        animationController.forward();
//                        return AreaView(
//                          context: context,
//                          pR: pR,
//                          index: index,
//                          alist: areaListData,
//                          uri: areaListData[index].documentPreviewImageFileUri,
//                          animation: animation,
//                          animationController: animationController,
//                        );
//                      },
//                    ),
//                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                      crossAxisCount: 2,
//                      mainAxisSpacing: 18.0,
//                      crossAxisSpacing: 18.0,
//                      childAspectRatio: 0.75,
//                    ),
//                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }



}



// ignore: must_be_immutable
class AreaView extends StatelessWidget {
  final int index;

  List<c.Page> alist;

  PageRepository pR;

  final BuildContext context;

//  BuildContext context;


  AreaView( {
    Key key,
    this.context,
    this.pR,
    this.index,
    this.alist,
    this.uri,
    this.animationController,
    this.animation,
  }){

    this.image = PageWidget(uri);
//    if (this.image == null){
//      Navigator.pop(context);
//    }
  }




  final Uri uri;
//   static Uri path = uri;
//  static Uri path = this.uri;
  final AnimationController animationController;
  final Animation<dynamic> animation;
//  final file = File.fromUri(uri);
//  final bytes = file.readAsBytesSync();
//  Image image = Image.memory(bytes);
//  final Widget image = PageWidget(uri);

  Widget image ;


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(


      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(

          opacity: animation,
          child: Transform(

            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),

            child: Container(
              //height: MediaQuery.of(context).size.height / 2,
              height: 100.0,


              decoration: BoxDecoration(

                color: AppTheme.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: AppTheme.grey.withOpacity(0.4),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  splashColor: AppTheme.nearlyDarkBlue.withOpacity(0.2),
                  onTap: () {
//                    print(context);
                    showOperationsPage(alist[index]);
                  },

                  child: Column(

                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 5, left: 5, right: 5,bottom:5),

                        child:  image,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
//          ),
        );
      },
    );

  }

  showOperationsPage(c.Page  page) async {
////    if(!mounted) {print(mounted) ;
////    return;}
    print(pR.pages.length);
//    return;

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PageOperations(page, pR)),
    );
//    this.pR = await Navigator.of(this.context).push(
//      MaterialPageRoute(
//          builder: (context) => ),
//    );
    // ignore: invalid_use_of_protected_member
    print("Dance");
    print(pR.pages.length);
//     _AreaListViewState(pR)._updatePagesList();
    Navigator.pop(context);
    gotoImagesView();
//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => TrainingScreen(pR:pR)),
//    );


  }
  gotoImagesView() async {
    imageCache.clear();
    return await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => TrainingScreen(
        pR: pR,
        animationController:animationController ,
      )),
    );
  }

}
