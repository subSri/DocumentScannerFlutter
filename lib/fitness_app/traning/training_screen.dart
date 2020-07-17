import 'package:flutter/rendering.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanbot_sdk/common_data.dart';
import 'package:scanbot_sdk/create_tiff_data.dart';
import 'package:scanbot_sdk/document_scan_data.dart';
import 'package:scanbot_sdk/ocr_data.dart';
import 'package:scanbot_sdk/render_pdf_data.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'package:scanbot_sdk/scanbot_sdk_ui.dart';
import 'package:scanbot_sdk_example_flutter/pages_repository.dart';
import 'package:scanbot_sdk_example_flutter/pdfviewcurved/main.dart';
import 'package:scanbot_sdk_example_flutter/ui/filter_all_pages_widget.dart';
import 'package:scanbot_sdk_example_flutter/ui/progress_dialog.dart';
import 'package:scanbot_sdk_example_flutter/ui/utils.dart';

import '../ui_view/area_list_view.dart';
import 'package:scanbot_sdk/common_data.dart' as c;
import '../ui_view/title_view.dart';
import 'package:flutter/material.dart';
import '../fintness_app_theme.dart';


class TrainingScreen extends StatefulWidget {


  const TrainingScreen({Key key,this.pR, this.animationController}) : super(key: key);
  final PageRepository pR;
  final AnimationController animationController;
  @override

  _TrainingScreenState createState() => _TrainingScreenState(pR);
}

class _TrainingScreenState extends State<TrainingScreen>
    with TickerProviderStateMixin {
  PageRepository pR;
  _TrainingScreenState(this.pR){
    if (pR!=null) {
      this.page = this.pR.pages;
    }
  }
//
//  _FitnessAppHomeScreenState().setState(){
//    _FitnessAppHomeScreenState().pR = this.pR;
//  }


  Animation<double> topBarAnimation;
  List<c.Page> page ;
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

  void addAllListData() {
    const int count = 0;

//    listViews.add(
//      TitleView(
//        titleTxt: 'Your program',
//        subTxt: 'Details',
//        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//            parent: widget.animationController,
//            curve:
//                Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
//        animationController: widget.animationController,
//      ),
//    );
//

    listViews.add(
      TitleView(
        titleTxt: 'Your Images',

        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController,
            curve:
            Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController,
      ),
    );
    print("Entering Area lsit");
    listViews.add(
      AreaListView(
        pR:pR,
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
        floatingActionButton: getBoomMenu(),
        backgroundColor: Colors.transparent,
        body:

        Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),

//            SizedBox(
//              height: MediaQuery.of(context).padding.bottom,
//              child:
//            ),



          ],
        ),
//          Expanded(
//            child: Align(
//              alignment: FractionalOffset.bottomCenter,
//              child:
//            ),
//          ),


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
                                  'My Images',
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
//
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

  Widget getBoomMenu() {
    return  BoomMenu(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      //child: Icon(Icons.add),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
//         scrollVisible: FontAwesomeIcons.scroll,
      overlayColor: Colors.black,
      overlayOpacity: 0.7,
      children: [
        MenuItem(
          child: Icon(Icons.picture_as_pdf, color: Colors.black),
          title: "Create PDF",
          titleColor: Colors.white,
          subtitle: "Convert all scans into PDF",
          subTitleColor: Colors.white,
          backgroundColor: Colors.deepOrange,
          onTap: () => createPdf(),
        ),
        MenuItem(
          child: Icon(Icons.image, color: Colors.black),
          title: "Import Images",
          titleColor: Colors.white,
          subtitle: "Add images from your files",
          subTitleColor: Colors.white,
          backgroundColor: Colors.green,
          onTap: () {
//               Navigator.pop(context);
            importImage();


          },
        ),
        MenuItem(
            child: Icon(Icons.pages, color: Colors.black),
            title: "Add Page",
            titleColor: Colors.white,
            subtitle: "Scan more in the document",
            subTitleColor: Colors.white,
            backgroundColor: Colors.blue,
            onTap: () {
//               Navigator.pop(context);
              startDocumentScanning();
//               _updatePagesList();
            }
        ),

        MenuItem(
            child: Icon(Icons.delete, color: Colors.black),
            title: "Delete All",
            titleColor: Colors.white,
            subtitle: "Clear all scanned images",
            subTitleColor: Colors.white,
            backgroundColor: Colors.red,
            onTap: () {
//               Navigator.pop(context);
              pR.clearPages();
              Navigator.pop(context);
              gotoImagesView();
            }
        ),

      ],
    );
//     );
  }




  startDocumentScanning() async {
    if (!await checkLicenseStatus(context)) { return; }

    DocumentScanningResult result;
    try {
      var config = DocumentScannerConfiguration(

        bottomBarBackgroundColor: Colors.black,
//        topBarBackgroundColor:Colors.white,
        ignoreBadAspectRatio: true,
        multiPageEnabled: true,
        shutterButtonAutoOuterColor:Colors.white,
        shutterButtonAutoInnerColor:Colors.black,
        shutterButtonManualInnerColor:Colors.black,
        shutterButtonManualOuterColor:Colors.white,
        polygonColor:Colors.lightGreen,
        polygonColorOK:Colors.lightGreen,
        multiPageButtonHidden:true,

        //maxNumberOfPages: 3,
        //flashEnabled: true,
        //autoSnappingSensitivity: 0.7,
        cameraPreviewMode: CameraPreviewMode.FIT_IN,
        orientationLockMode: CameraOrientationMode.PORTRAIT,
        //documentImageSizeLimit: Size(2000, 3000),
        cancelButtonTitle: "Cancel",

        pageCounterButtonTitle: "%d",
        textHintOK: "Perfect, don't move...",
        //textHintNothingDetected: "Nothing",
        // ...
      );
      result = await ScanbotSdkUi.startDocumentScanner(config);
    } catch (e) {
      print(e);
    }

    if (isOperationSuccessful(result)) {
      this.pR.addPages(result.pages);
      Navigator.pop(context);
      gotoImagesView();
    }
  }

  gotoImagesView() async {
    imageCache.clear();
    return await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => TrainingScreen(
        pR: pR,
        animationController:widget.animationController ,
      )),
    );
  }
  void _updatePagesList() {
    imageCache.clear();
    Future.delayed(Duration(microseconds: 500)).then((val) {
      setState(() {
        this.page = pR.pages;
        print("Pages count in setState");
        print(page.length);
      });
    });

    setState(() {
      this.page = pR.pages;
    });
  }

  showCleanupStorageDialog() {
    Widget text = SimpleDialogOption(
      child:
      Text("Delete all images and generated files (PDF, TIFF, etc)?"),
    );

    // set up the SimpleDialog
    AlertDialog dialog = AlertDialog(
      title: const Text('Delete all'),
      content: text,
      contentPadding: EdgeInsets.all(0),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            cleanupStorage();
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  filterAllPages() async {
    if (!await checkHasPages(context)) { return; }
    if (!await checkLicenseStatus(context)) { return; }

    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => MultiPageFiltering(pR)),
    );
  }

  cleanupStorage() async {
    try {
      await ScanbotSdk.cleanupStorage();
      pR.clearPages();
      _updatePagesList();
    } catch (e) {
      print(e);
    }
  }

  createPdf() async {
    if (!await checkHasPages(context)) { return; }
    if (!await checkLicenseStatus(context)) { return; }

    var dialog = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: "Creating PDF ...");
    try {
      dialog.show();
      var options = PdfRenderingOptions(PdfRenderSize.A4);
      final Uri pdfFileUri = await ScanbotSdk.createPdf(this.pR.pages, options);
      dialog.hide();
      showAlertDialog(context, pdfFileUri.toString(), title: "PDF file URI");
    } catch (e) {
      print(e);
      dialog.hide();
    }
  }

  importImage() async {
    try {
      print("Entered import images");
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      print("Calling createImage");
      await createPage(image.uri);
      print("Pages count after return");
      print(pR.pages.length);
      Navigator.pop(context);
      gotoImagesView();
//      _updatePagesList();
    } catch (e) {}
  }

  createPage(Uri uri) async {
    if (!await checkLicenseStatus(context)) { return; }

    var dialog = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: "Processing ...");
    dialog.show();
    try {
      print("Inside CrreatePage");
      var p = await ScanbotSdk.createPage(uri, false);
      p = await ScanbotSdk.detectDocument(p);
      dialog.hide();
      this.pR.addPage(p);
      print("Pages count");
      print(pR.pages.length);
    } catch (e) {
      print(e);
      dialog.hide();
    }
  }

  createTiff(bool binarized) async {
    if (!await checkHasPages(context)) { return; }
    if (!await checkLicenseStatus(context)) { return; }

    var dialog = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: "Creating TIFF ...");
    dialog.show();
    try {
      var options = TiffCreationOptions(binarized: binarized, dpi: 200, compression: (binarized ? TiffCompression.CCITT_T6 : TiffCompression.ADOBE_DEFLATE));
      final Uri tiffFileUri = await ScanbotSdk.createTiff(this.pR.pages, options);
      dialog.hide();
      showAlertDialog(context, tiffFileUri.toString(), title: "TIFF file URI");
    } catch (e) {
      print(e);
      dialog.hide();
    }
  }

  detectPage(c.Page page) async {
    if (!await checkLicenseStatus(context)) { return; }

    var dialog = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: "Processing ...");
    dialog.show();
    try {
      var updatedPage = await ScanbotSdk.detectDocument(page);
      dialog.hide();
      setState(() {
        this.pR.updatePage(updatedPage);
        _updatePagesList();
      });
    } catch (e) {
      print(e);
      dialog.hide();
    }
  }

  performOcr() async {
    if (!await checkHasPages(context)) { return; }
    if (!await checkLicenseStatus(context)) { return; }

    var dialog = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: "Performing OCR ...");
    dialog.show();
    try {
      var result = await ScanbotSdk.performOcr(
          page, OcrOptions(languages: ["en", "de"], shouldGeneratePdf: false));
      dialog.hide();
      showAlertDialog(context, "Plain text:\n" + result.plainText);
    } catch (e) {
      print(e);
      dialog.hide();
    }
  }

  createOcrPdf() async {
    if (!await checkHasPages(context)) { return; }
    if (!await checkLicenseStatus(context)) { return; }

    var dialog = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: "Performing OCR with PDF ...");
    dialog.show();
    try {
      var result = await ScanbotSdk.performOcr(
          page, OcrOptions(languages: ["en", "de"], shouldGeneratePdf: true));
      dialog.hide();
      showAlertDialog(context, "PDF File URI:\n" + result.pdfFileUri +
          "\n\nPlain text:\n" + result.plainText);
    } catch (e) {
      print(e);
      dialog.hide();
    }
  }

  Future<bool> checkHasPages(BuildContext context) async {
    if (page.isNotEmpty) {
      return true;
    }
    await showAlertDialog(context, 'Please scan or import some documents to perform this function.', title: 'Info');
    return false;
  }
}








