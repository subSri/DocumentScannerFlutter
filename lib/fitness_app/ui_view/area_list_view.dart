import 'dart:io';


import 'package:flutter/material.dart';
import 'package:scanbot_sdk_example_flutter/pages_repository.dart';
import 'package:scanbot_sdk_example_flutter/ui/pages_widget.dart';
import 'package:scanbot_sdk/common_data.dart' as c;
import '../fintness_app_theme.dart';
import '../../ui/preview_document_widget.dart';
import '../../ui/operations_page_widget.dart';

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
    this.areaListData = this.pR.pages;
  }
  PageRepository pR;

  AnimationController animationController;
//  List<String> areaListData = <String>[
//    'assets/fitness_app/area1.png',
//    'assets/fitness_app/area2.png',
//    'assets/fitness_app/area3.png',
//    'assets/fitness_app/area1.png',
//  ];


//  child: GestureDetector(
//  onTap: () {
//  showOperationsPage(pages[position]);
//  },
//  child: PageWidget(
//  pages[position].documentPreviewImageFileUri)),

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
        this.areaListData = pR.pages;
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    setState(() {
//      this.context = context;
//    });
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
                      left: 16, right: 16, top: 16, bottom: 16),
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
                      animationController.forward();
                      return AreaView(
                        context: context,
                        pR: pR,
                        index : index,
                        alist: areaListData,
                        uri: areaListData[index].documentPreviewImageFileUri,
                        animation: animation,
                        animationController: animationController,
                      );
                    },
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 24.0,
                    crossAxisSpacing: 24.0,
                    childAspectRatio: 1.0,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


}


// ignore: must_be_immutable
class AreaView extends StatelessWidget {
  final int index;

  final List<c.Page> alist;

  final PageRepository pR;

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
     this.image = PageWidget(this.uri);
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

//              height: MediaQuery.of(context).size.height / 2,
                height: 200.0,


              decoration: BoxDecoration(

                color: FintnessAppTheme.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: FintnessAppTheme.grey.withOpacity(0.4),
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
                  splashColor: FintnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
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


//    return;
    await Navigator.of(this.context).push(
      MaterialPageRoute(
          builder: (context) => PageOperations(page, pR)),
    );
    _AreaListViewState(pR)._updatePagesList();
  }

}





