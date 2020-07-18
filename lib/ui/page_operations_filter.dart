import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanbot_sdk/common_data.dart';
import 'package:scanbot_sdk/document_scan_data.dart';
import 'package:scanbot_sdk_example_flutter/fitness_app/traning/training_screen.dart';
import 'package:scanbot_sdk_example_flutter/pdfviewcurved/main.dart';
import 'package:scanbot_sdk_example_flutter/ui/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:scanbot_sdk/common_data.dart' as c;
import 'package:scanbot_sdk/cropping_screen_data.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'package:scanbot_sdk/scanbot_sdk_ui.dart';
import 'package:scanbot_sdk_example_flutter/ui/utils.dart';

import '../pages_repository.dart';
import 'filter_page_widget.dart';
import 'pages_widget.dart';

// ignore: must_be_immutable
class PageOperations extends StatelessWidget {
  c.Page _page;
  final PageRepository _pageRepository;

  PageOperations(this._page, this._pageRepository);

  @override
  Widget build(BuildContext context) {
    imageCache.clear();
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          title: const Text('Image Preview',
              style: TextStyle(inherit: true, color: Colors.black)),
        ),
        body: PagesPreviewWidget(_page, _pageRepository));
  }
}

// ignore: must_be_immutable
class PagesPreviewWidget extends StatefulWidget {
  c.Page page;
  final PageRepository _pageRepository;

  PagesPreviewWidget(this.page, this._pageRepository);

  @override
  State<PagesPreviewWidget> createState() {
    return new PagesPreviewWidgetState(page, this._pageRepository);
  }
}

class PagesPreviewWidgetState extends State<PagesPreviewWidget> {
  c.Page page;
  PageRepository _pageRepository;

  c.ImageFilterType selectedFilter;

  Uri filteredImageUri;
bool filtertap = true;
  PagesPreviewWidgetState(this.page, this._pageRepository) {
    filteredImageUri = page.documentImageFileUri;
    selectedFilter = page.filter ?? c.ImageFilterType.NONE;
    image = PageWidget(filteredImageUri);
  }
  PageWidget image;

  void _updatePage(c.Page page) {
    imageCache.clear();
    _pageRepository.updatePage(page);
    setState(() {
      this.page = page;
    });
  }
  int _page = 0;
  int _page2 = 0;


  @override
  Widget build(BuildContext context) {
    if (_page==3  && filtertap==true) {
      print("Filter 2");
      return Scaffold(

        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(opacity: 1),
            unselectedIconTheme: IconThemeData(opacity: 0.5),
            selectedItemColor: Colors.black87,
            currentIndex: _page,
//          height: 50.0,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_box, size: 30, color: Colors.black),
                  title: new Text("Scan")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.image, size: 30, color: Colors.black),
                  title: new Text("Import")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.crop_rotate, size: 30, color: Colors.black),
                  title: new Text("Crop")
              ),

              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.filter_tilt_shift, size: 30, color: Colors.black),
                  title: new Text("Filter")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.delete, size: 30, color: Colors.black),
                  title: new Text("Delete")
              ),


            ],


//          buttonBackgroundColor: Colors.black,
//          backgroundColor: Colors.black26,
//          animationCurve: Curves.easeInOut,
//          animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              if (index == 0) {
                startDocumentScanning();
              }
              if (index == 1) {
                importImage();
              }
              if (index == 2) {
                startCroppingScreen(page);
              }

//              if (index == 3) {
//                rotatePage(page);
//              }

              if (index == 4) {
                deletePage(page);
              }


              setState(() {
                _page = index;
                this.filtertap = false;
              });
            }

        ),

        body: Column(

          children: <Widget>[
            Expanded(
                child: Container(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                        child:Container(

                          width: MediaQuery
                              .of(context)
                              .size
                              .width * .80,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * .60,
                          child: image,
                        )
                        ),
                      ],
                    )

                )
            ),

            BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedIconTheme: IconThemeData(opacity: 1),
                unselectedIconTheme: IconThemeData(opacity: 0.5),
                selectedItemColor: Colors.black87,
                currentIndex: _page2,
//          height: 50.0,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.filter_none, size: 30, color: Colors.black),
                      title: new Text("None")
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.gradient, size: 30, color: Colors.black),
                      title: new Text("Grayscale")
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.border_inner, size: 30, color: Colors.black),
                      title: new Text("Binarization")
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                          Icons.highlight, size: 30, color: Colors.black),
                      title: new Text("Edge Highlight")
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                          Icons.format_color_fill, size: 30, color: Colors.black),
                      title: new Text("Color Enhanced")
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.filter_b_and_w, size: 30, color: Colors.black),
                      title: new Text("B/W")
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.color_lens, size: 30, color: Colors.black),
                      title: new Text("Color Document")
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.broken_image, size: 30, color: Colors.black),
                      title: new Text("OSTU")
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.save_alt, size: 30, color: Colors.black),
                      title: new Text("Apply")
                  ),


                ],


//          buttonBackgroundColor: Colors.black,
//          backgroundColor: Colors.black26,
//          animationCurve: Curves.easeInOut,
//          animationDuration: Duration(milliseconds: 600),
                onTap: (index) {
                  if (index == 5) {
                    previewFilter(page, c.ImageFilterType.BLACK_AND_WHITE);
                  }
                  if (index == 1) {
                    previewFilter(page, c.ImageFilterType.GRAYSCALE);
                  }
                  if (index == 2) {
                    previewFilter(page, c.ImageFilterType.DEEP_BINARIZATION);
                  }

                  if (index == 3) {
                    previewFilter(page, c.ImageFilterType.EDGE_HIGHLIGHT);
                  }
                  if (index == 4) {
                    previewFilter(page, c.ImageFilterType.COLOR_ENHANCED);
                  }
                  if (index == 0) {
                    previewFilter(page, c.ImageFilterType.NONE);
                  }
                  if (index == 6) {
                    previewFilter(page, c.ImageFilterType.COLOR_DOCUMENT);
                  }
                  if (index == 7) {
                    previewFilter(page, c.ImageFilterType.OTSU_BINARIZATION);
                  }
                  if (index == 8) {
                    applyFilter();
                  }


                  setState(() {
                    _page2 = index;

                  });
                }

            ),

//
          ],
        ),
      );
    }
    else{
      print("Else");
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedIconTheme: IconThemeData(opacity: 1),
            unselectedIconTheme: IconThemeData(opacity: 0.5),
            selectedItemColor: Colors.black87,
            currentIndex: _page,
//          height: 50.0,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_box, size: 30, color: Colors.black),
                  title: new Text("Scan")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.image, size: 30, color: Colors.black),
                  title: new Text("Import")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.crop_rotate, size: 30, color: Colors.black),
                  title: new Text("Crop")
              ),

              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.filter_tilt_shift, size: 30, color: Colors.black),
                  title: new Text("Filter")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.delete, size: 30, color: Colors.black),
                  title: new Text("Delete")
              ),



            ],


//          buttonBackgroundColor: Colors.black,
//          backgroundColor: Colors.black26,
//          animationCurve: Curves.easeInOut,
//          animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              if (index == 0) {
                startDocumentScanning();
              }
              if (index == 1) {
                importImage();
              }
              if (index == 2) {
                startCroppingScreen(page);
              }

//              if (index == 3) {
//                rotatePage(page);
//              }

              if (index == 4) {
                deletePage(page);
              }


              setState(() {
                _page = index;
                this.filtertap = true;

              });
            }

        ),

        body: Column(

          children: <Widget>[
            Expanded(
                child: Container(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * .80,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * .70,
                          child: image,
                        ),
                      ],
                    )
                )
            ),


//
          ],
        ),
      );

    }
  }

  importImage() async {
    try {
      print("Entered import images");
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      print("Calling createImage");
      await createPage(image.uri);
      print("Pages count after return");
      print(_pageRepository.pages.length);
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
      this._pageRepository.addPage(p);
      print("Pages count");
      print(_pageRepository.pages.length);
    } catch (e) {
      print(e);
      dialog.hide();
    }
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
      this._pageRepository.addPages(result.pages);
      Navigator.pop(context);
      gotoImagesView();
    }
  }

  gotoPreviewview()  async {
    imageCache.clear();
    return await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PagesPreviewWidget(page, _pageRepository)),
    );
  }

  gotoImagesView() async {
    imageCache.clear();
    return await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => TrainingScreen(
        pR: _pageRepository,
//        animationController:animationController ,
      )),
    );
  }

  deletePage(c.Page page) async {
    try {
      await ScanbotSdk.deletePage(page);
      _pageRepository.removePage(page);
//      setState(() {
//        this._pageRepository = _pageRepository;
//      });

      Navigator.pop(context,this._pageRepository);
    } catch (e) {
      print(e);
    }
  }

  applyFilter() async {
    if (!await checkLicenseStatus(context)) { return; }

    var dialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: "Processing");
    dialog.show();
    try {
      var updatedPage = await ScanbotSdk.applyImageFilter(page, selectedFilter);
      dialog.hide();
      Navigator.of(context).pop(updatedPage);
    } catch (e) {
      dialog.hide();
      print(e);
    }
  }

  previewFilter(c.Page page, c.ImageFilterType filterType) async {
    if (!await checkLicenseStatus(context)) { return; }

    try {
      var dialog = ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      dialog.style(message: "Adding Filters ...");
      dialog.show();
      var uri = await ScanbotSdk.getFilteredDocumentPreviewUri(page, filterType);
      dialog.hide();
      setState(() {
        print("Set Stae in preview");
        selectedFilter = filterType;
        filteredImageUri = uri;
        dialog.hide();
        image = PageWidget(filteredImageUri);


      });
    } catch (e) {
      print(e);
    }
  }


  rotatePage(c.Page page) async {
    if (!await checkLicenseStatus(context)) { return; }

    try {
      var dialog = ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
//      dialog.style(message: "Processing ...");
//      dialog.show();
      var updatedPage = await ScanbotSdk.rotatePageClockwise(page, 1);
//      dialog.hide();
      if (updatedPage != null) {
        setState(() async {
          _updatePage(updatedPage);
//          image = PageWidget(updatedPage.documentImageFileUri);
        });
      }
    } catch (e) {
      print(e);
    }
  }

//  showFilterPage(c.Page page) async {
//    if (!await checkLicenseStatus(context)) { return; }
//
//    var resultPage = await Navigator.of(context).push(
//      MaterialPageRoute(builder: (context) => PageFiltering(page)),
//    );
//    if (resultPage != null) {
//      _updatePage(resultPage);
//    }
//  }

  startCroppingScreen(c.Page page) async {
    if (!await checkLicenseStatus(context)) { return; }

    try {
      var config = CroppingScreenConfiguration(
        bottomBarBackgroundColor: Colors.black,
        // polygonColor: Colors.yellow,
        // polygonLineWidth: 10,
        cancelButtonTitle: "Cancel",
        doneButtonTitle: "Save",
        // ...
      );
      var result = await ScanbotSdkUi.startCroppingScreen(page, config);
      if (isOperationSuccessful(result) && result.page != null) {
        setState(() {
          _updatePage(result.page);
//          Navigator.pop(context);
//          gotoPreviewview();
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
