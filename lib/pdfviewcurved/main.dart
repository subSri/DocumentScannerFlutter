import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scanbot_sdk_example_flutter/fitness_app/fintness_app_theme.dart';
import 'detailsPage.dart';



class PdfListView extends StatefulWidget {
  final List<FileSystemEntity> files;

  final Directory dir;


  const PdfListView(
      {Key key,this.dir, this.files,this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  @override
  _PdfListViewState createState() => _PdfListViewState(dir,files);
}



AnimationController animationController;
class _PdfListViewState extends State<PdfListView> with TickerProviderStateMixin{
  List<FileSystemEntity> files;
  _PdfListViewState(dir,files){
    this.dir = dir;
    this.files = files;
    print("Files are as follows");
    print(files);
  }

Directory dir;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  //call when a pdf is deleted
  void _updatePdflist() {

    Future.delayed(Duration(microseconds: 500)).then((val) {
      setState(() {
        this.files = dir.listSync(recursive: true, followLinks: false);
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
    if (files!=null && files.length>0) {
      return AnimatedBuilder(
          animation: widget.mainScreenAnimationController,
          builder: (BuildContext context, Widget child) {
            return FadeTransition(
              opacity: widget.mainScreenAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
//            child: AspectRatio(
//              aspectRatio: 0.8,
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8, top: 50, bottom: 8),
                    child: Container(

                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(75.0)),
                      ),
                      child: ListView(
                        primary: false,
                        padding: EdgeInsets.only(left: 2.0, right: 2.0),
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 45.0),
                              child: Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height - 300.0,
                                  child: ListView.builder(
                                      padding: const EdgeInsets.all(5.0),
                                      itemCount: files.length,
                                      itemBuilder: (context, index) {
                                        if (files[index].path
                                            .split('/')
                                            .last
                                            .length > 20) {
                                          return buildPdfItem(
                                              'assets/images/file-pdf-icon.png',
                                              files[index].path
                                                  .split('/')
                                                  .last
                                                  .substring(0, 17) + ".pdf");
                                        }
                                        else {
                                          return buildPdfItem(
                                              'assets/images/file-pdf-icon.png',
                                              files[index].path
                                                  .split('/')
                                                  .last);
                                        }
                                      }
//
                                  )
                              )

                          ),

                        ],
                      ),
                    )
                ),
              ),
            );
          }
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
//            child: AspectRatio(
//              aspectRatio: 0.8,
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8, top: 50, bottom: 8),
                    child: Container(

                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(75.0)),
                      ),
                      child: ListView(
                        primary: false,
                        padding: EdgeInsets.only(left: 2.0, right: 2.0),
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 45.0),
                              child: Container(
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height - 300.0,
                                 child:Center(
                                    child: Text("You havent saved any PDFS"),
                                 ),
                              )

                          ),

                        ],
                      ),
                    )
                ),
              ),
            );
          }
      );


 }

  }
//

  Widget buildPdfItem(String imgPath, String foodName) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(

            onTap: () {
//              Navigator.of(context).push(MaterialPageRoute(
////                  builder: (context) => DetailsPage(heroTag: imgPath, foodName: foodName, foodPrice: price)
//              ));
            },
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: FintnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                        children: [
                          Hero(
                              tag: imgPath,
                              child: Image(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.cover,
                                  height: 75.0,
                                  width: 75.0
                              )
                          ),
                          SizedBox(width: 10.0),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                       Text(
                                    foodName,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold
                                    )
                                ),

                                Text(
                                    "We can put time created",
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 15.0,
                                        color: Colors.grey
                                    )
                                )
                              ]
                          )
                        ]
                    )
                ),
                IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.black,
                    onPressed: () {} //add options to pdf
                )
              ],
            )

        ));
  }
}



