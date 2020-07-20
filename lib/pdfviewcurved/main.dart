import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:scanbot_sdk_example_flutter/info/generic_app_theme.dart';

import 'detailsPage.dart';
import 'package:open_file/open_file.dart';



class PdfListView extends StatefulWidget {
  final List<FileSystemEntity> files;

  final Directory dir;

  final List<FileSystemEntity> allfiles;


  const PdfListView(
      {Key key,this.allfiles,this.dir, this.files,this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;
  @override
  _PdfListViewState createState() => _PdfListViewState(allfiles,dir,files);
}



AnimationController animationController;
class _PdfListViewState extends State<PdfListView> with TickerProviderStateMixin{
  List<FileSystemEntity> files;
  List<FileSystemEntity> allfiles;

  var _tapPosition;
  _PdfListViewState(allfiles,dir,files){
    this.allfiles = allfiles;
    this.dir = dir;
    this.files = files;
    print("Files are as follows");
    print(files);
  }

Directory dir;
  @override
  void initState() {
    _tapPosition=Offset(0.0,0.0);
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  //call when a pdf is deleted
  void _updatePdflist() {

    Future.delayed(Duration(microseconds: 500)).then((val) {
      setState(() {
        this.allfiles = dir.listSync(recursive: true, followLinks: false);


        if (files!=null){
          this.files.clear();
        }
        for (int i = 0; i < allfiles.length; i++) {
          print(allfiles[i].path);
          if (allfiles[i].path.endsWith('.pdf')) {
            this.files.add(allfiles[i]);
          }
        }


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
                        color: Colors.greenAccent,
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
                                                  .substring(0, 17) + ".pdf",files[index].path);
                                        }
                                        else {
                                          return buildPdfItem(
                                              'assets/images/file-pdf-icon.png',
                                              files[index].path
                                                  .split('/')
                                                  .last,files[index].path);
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

  Widget buildPdfItem(String imgPath, String foodName,String path) {
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child:Container(
//      color:Colors.amber,
      child:Material(
        color: Colors.greenAccent,
        child: InkWell(



            onTap: () {

              OpenFile.open(path);
//              Navigator.of(context).push(MaterialPageRoute(
////                  builder: (context) => DetailsPage(heroTag: imgPath, foodName: foodName, foodPrice: price)
//              ));
            },
            splashColor: AppTheme.nearlyDarkBlue.withOpacity(0.2),
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(

                    child: Row(
                        children: [
                          Container(

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
                PopupMenuButton(
                  onSelected: (v){
                if (v==1){
                         onOpenPdf(path);
                }
                else if(v==2){
                         onSharePdf(path);
                }
                else if(v==3){
                        onDeletePdf(files,path);
                }
                },
                      itemBuilder: (context) => [
                      PopupMenuItem(
                          value:1,
                          child:InkWell(
                            child: Text("View"),

                          )


                      ),
                      PopupMenuItem(
                        value:2,
                        child:InkWell(

                          child: Text("Share"),

                        ),
                      ),

                      PopupMenuItem(
                          value: 3,
                          child:InkWell(
                            //              onTap: onDeletePdf(files,path),
                            child: Text("Delete"),

                          )
                      ),

                    ],
                  ),
    ],
                ),

            )

        )
      ),
      );
//    );
  }

  void _storePosition(TapDownDetails details) {
    setState(() {
      _tapPosition =  details.globalPosition;
    });

  }
   _showPopupMenu(path)  async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();

    await showMenu(
        context: context,
        position: RelativeRect.fromRect(
        _tapPosition &  Size(40, 40), // smaller rect, the touch area
    Offset.zero & overlay.size // Bigger rect, the entire screen
    ),
//    await showMenu(
//      context: context,
//      position: RelativeRect.fromLTRB(1000, 100, 100, 400),
      items: [
        PopupMenuItem(

          child: Row(
              children: <Widget>[
            PopupMenuItem(
            value:1,
                child:InkWell(
                  onLongPress: onOpenPdf(path),
                        child: Text("View"),

          )


        ),
              PopupMenuItem(
                value:2,
                  child:InkWell(
                    onLongPress: onSharePdf(path),
                     child: Text("Share"),

          ),
          ),

                PopupMenuItem(
                  value: 3,
                    child:InkWell(
        //              onTap: onDeletePdf(files,path),
                      child: Text("Delete"),

            )
        ),
          ],
          ),
        ),
      ],
      elevation: 8.0,
    );
  }

   onDeletePdf(files,path) {
     File file = new File(path);
     file.delete();
    _updatePdflist();
  }

   onOpenPdf(path) {
    OpenFile.open(path);
  }

   onSharePdf(path){
    print("Share");
  }

}



