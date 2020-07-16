import 'package:scanbot_sdk_example_flutter/fitness_app/traning/training_screen.dart';

import '../fintness_app_theme.dart';
import '../models/meals_list_data.dart';
import '../../main.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';

import 'package:scanbot_sdk_example_flutter/ui/preview_document_widget.dart';
import 'package:scanbot_sdk_example_flutter/ui/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scanbot_sdk/barcode_scanning_data.dart';
import 'package:scanbot_sdk/common_data.dart';
import 'package:scanbot_sdk/document_scan_data.dart';
import 'package:scanbot_sdk/ehic_scanning_data.dart';
import 'package:scanbot_sdk/mrz_scanning_data.dart';
import 'package:scanbot_sdk/scanbot_sdk.dart';
import 'package:scanbot_sdk/scanbot_sdk_models.dart';
import 'package:scanbot_sdk/scanbot_sdk_ui.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';

import '../../fitness_app_home_screen.dart';
import '../../pages_repository.dart';
import '../../ui/menu_items.dart';
import '../../ui/utils.dart';

import 'package:image_picker/image_picker.dart';

PageRepository _pageRepository = PageRepository();
const SCANBOT_SDK_LICENSE_KEY = "cPJaWtvXEJH/saeDetb6zHk8Uo72+h" +
    "Wxv1lHI1VxlnZK6vgtWD3M7n73jIjn" +
    "hVbTlGpksJ+uhY/xgkZ61cgQONQ/VJ" +
    "9TCz4SXiX8/Jnh+MYNemX6vkL2eUoL" +
    "0U0heANCj9j0nPsIqyrIVk4Z4o7NkY" +
    "s+Bx4TUcmEckuHp/ZQBXn/fwubmg2S" +
    "0ZXSFVzzd/E5FwVx+tsY2zDSNyd6YM" +
    "AVLcSbSqMtCMs3yBlmDrttAs4pSPAi" +
    "dZe1VA+iGovIA0Vy5JWtKl8ezNNYDP" +
    "0BDOsuzFbfuNcKZQ8pXPPnBIQHGq6g" +
    "Gakgp7yxX/wMqsAAiPJdwItx3hsWwQ" +
    "l6QIZNQ5RDIA==\nU2NhbmJvdFNESw" +
    "pjb20uZG9jc2Nhbi5mbHV0dGVyCjE1" +
    "OTY4NDQ3OTkKMjYyMTQzCjM=\n";

initScanbotSdk() async {
  // Consider adjusting this optional storageBaseDirectory - see the comments below.
  var customStorageBaseDirectory = await getDemoStorageBaseDirectory();

  var config = ScanbotSdkConfig(
    loggingEnabled: true, // Consider switching logging OFF in production builds for security and performance reasons.
    licenseKey: SCANBOT_SDK_LICENSE_KEY,
    imageFormat: ImageFormat.JPG,
    imageQuality: 100,
    storageBaseDirectory: customStorageBaseDirectory.path+"/DocScan",
  );

  try {
    await ScanbotSdk.initScanbotSdk(config);
  } catch (e) {
    print(e);
  }
}



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



class MealsListView extends StatefulWidget {

  const MealsListView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;

  @override
  _MealsListViewState createState() {
    initScanbotSdk();
    return _MealsListViewState();
  }
}

class _MealsListViewState extends State<MealsListView>
    with TickerProviderStateMixin {


  AnimationController animationController;
  List<MealsListData> mealsListData = MealsListData.tabIconsList;


  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: Container(
              height: 216,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = 4;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController.forward();

                  return MealsView(
                    pR :_pageRepository,
                    context:context,
                    mealsListData: mealsListData[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class MealsView extends StatelessWidget {



  const MealsView(
      {Key key,this.pR, this.context, this.mealsListData, this.animationController, this.animation})
      : super(key: key);

  final MealsListData mealsListData;
  final BuildContext context;
  final PageRepository pR;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  getOcrConfigs() async {
    try {
      var result = await ScanbotSdk.getOcrConfigs();
      showAlertDialog(context, jsonEncode(result), title: "OCR Configs");
    } catch (e) {
      print(e);
      showAlertDialog(context, "Error getting license status");
    }
  }

  getLicenseStatus() async {
    try {
      var result = await ScanbotSdk.getLicenseStatus();
      showAlertDialog(context, jsonEncode(result), title: "License Status");
    } catch (e) {
      print(e);
      showAlertDialog(context, "Error getting OCR configs");
    }
  }

  importImage() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      await createPage(image.uri);
      gotoImagesView();
    } catch (e) {
      print(e);
    }
  }

  createPage(Uri uri) async {
    if (!await checkLicenseStatus(context)) { return; }

    var dialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    dialog.style(message: "Processing");
    dialog.show();
    try {
      var page = await ScanbotSdk.createPage(uri, false);
      page = await ScanbotSdk.detectDocument(page);
      this.pR.addPage(page);
    } catch (e) {
      print(e);
    } finally {
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
      pR.addPages(result.pages);
      gotoImagesView();
    }
  }

  startBarcodeScanner() async {
    if (!await checkLicenseStatus(context)) { return; }

    try {
      var config = BarcodeScannerConfiguration(
        topBarBackgroundColor: Colors.black,
        finderTextHint: "Please align any supported barcode in the frame to scan it.",
        // ...
      );
      var result = await ScanbotSdkUi.startBarcodeScanner(config);
      _showBarcodeScanningResult(result);
    } catch (e) {
      print(e);
    }
  }

  startQRScanner() async {
    if (!await checkLicenseStatus(context)) { return; }

    try {
      var config = BarcodeScannerConfiguration(
        barcodeFormats: [BarcodeFormat.QR_CODE],
        finderTextHint: "Please align a QR code in the frame to scan it.",
        // ...
      );
      var result = await ScanbotSdkUi.startBarcodeScanner(config);
      _showBarcodeScanningResult(result);
    } catch (e) {
      print(e);
    }
  }

  _showBarcodeScanningResult(final BarcodeScanningResult result) {
    if (isOperationSuccessful(result)) {
      showAlertDialog(context,
          "Format: " + result.barcodeFormat.toString() + "\nValue: " + result.text,
          title: "Barcode Result:"
      );
    }
  }

//  startEhicScanner() async {
//    if (!await checkLicenseStatus(context)) { return; }
//
//    HealthInsuranceCardRecognitionResult result;
//    try {
//      var config = HealthInsuranceScannerConfiguration(
//        topBarBackgroundColor: Colors.blue,
//        topBarButtonsColor: Colors.white70,
//        // ...
//      );
//      result = await ScanbotSdkUi.startEhicScanner(config);
//    } catch (e) {
//      print(e);
//    }
//
//    if (isOperationSuccessful(result) && result?.fields != null) {
//      var concatenate = StringBuffer();
//      result.fields
//          .map((field) =>
//      "${field.type.toString().replaceAll("HealthInsuranceCardFieldType.", "")}:${field.value}\n")
//          .forEach((s) {
//        concatenate.write(s);
//      });
//      showAlertDialog(context, concatenate.toString());
//    }
//  }

  startMRZScanner() async {
    if (!await checkLicenseStatus(context)) { return; }

    MrzScanningResult result;
    try {
      var config = MrzScannerConfiguration(
        topBarBackgroundColor: Colors.blue,
        // ...
      );
      result = await ScanbotSdkUi.startMrzScanner(config);
    } catch (e) {
      print(e);
    }

    if (isOperationSuccessful(result)) {
      var concatenate = StringBuffer();
      result.fields
          .map((field) =>
      "${field.name.toString().replaceAll("MRZFieldName.", "")}:${field.value}\n")
          .forEach((s) {
        concatenate.write(s);
      });
      showAlertDialog(context, concatenate.toString());
    }
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
  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
                child:  new GestureDetector(
                onTap: () {
                if (mealsListData.titleTxt == "Document"){
                return startDocumentScanning();
                }
                else if(mealsListData.titleTxt == "Barcode"){
                return startBarcodeScanner();
                }
                else if (mealsListData.titleTxt == "QR Code"){
                return startQRScanner();
                }
                else {
                return startMRZScanner();
                }
                },
            child: SizedBox(
              width: 130,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32, left: 8, right: 8, bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: HexColor(mealsListData.endColor)
                                  .withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          colors: <HexColor>[
                            HexColor(mealsListData.startColor),
                            HexColor(mealsListData.endColor),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                      ),

                           child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 100, left: 16, right: 16, bottom: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                Text(
                                mealsListData.titleTxt,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FintnessAppTheme.fontName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  letterSpacing: 0.2,
                                  color: FintnessAppTheme.white,
                                ),
                              ),




                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      mealsListData.meals.toString(),
                                      style: TextStyle(
                                        fontFamily: FintnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        letterSpacing: 0.1,
                                        color: FintnessAppTheme.white,
                                      ),

                                    ),
                                  ],
                                ),
                              ),
                            ),
//

                          ],
                        ),
                      ),

                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: Container(
                      width: 94,
                      height: 84,
                      decoration: BoxDecoration(
                        color: FintnessAppTheme.nearlyWhite.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 35,
                    left: 40,
                    child: SizedBox(
                      width: 60,
                      height: 90,
                      child: Image.asset(mealsListData.imagePath),
                    ),
                  )
                ],

              ),
            ),
          ),
          ),
        );
      },
    );

  }

}
