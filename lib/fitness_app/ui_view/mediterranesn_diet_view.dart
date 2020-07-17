import 'dart:ui';

import 'package:scanbot_sdk_example_flutter/help_screen.dart';
import 'package:scanbot_sdk_example_flutter/pdfviewcurved/detailsPage.dart';

import '../../feedback_screen.dart';
import '../fintness_app_theme.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class MediterranesnDietView extends StatelessWidget {
  final AnimationController animationController;
  final Animation animation;

  const MediterranesnDietView(
      {Key key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 24, bottom: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: FintnessAppTheme.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(68.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: FintnessAppTheme.grey.withOpacity(0.2),
                        offset: Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 16, left: 16, right: 16,bottom: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: 48,
                                        width: 2,
                                        decoration: BoxDecoration(
                                          color: HexColor('#87A0E5')
                                              .withOpacity(0.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 2),
                                              child: Text(
                                                'Name',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                  FintnessAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  letterSpacing: -0.1,
                                                  color: FintnessAppTheme.grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: <Widget>[
//                                                SizedBox(
//                                                  width: 28,
//                                                  height: 28,
////                                                  child: Image.asset(
////                                                      "assets/fitness_app/eaten.png"),
//                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 4, bottom: 3),
                                                  child: Text(
                                                    'Subham',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                      FintnessAppTheme
                                                          .fontName,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontSize: 16,
                                                      color: FintnessAppTheme
                                                          .darkerText,
                                                    ),
                                                  ),
                                                )
//                                                Padding(
//                                                  padding:
//                                                      const EdgeInsets.only(
//                                                          left: 4, bottom: 3),
//                                                  child: Text(
//                                                    '',
//                                                    textAlign: TextAlign.center,
//                                                    style: TextStyle(
//                                                      fontFamily:
//                                                          FintnessAppTheme
//                                                              .fontName,
//                                                      fontWeight:
//                                                          FontWeight.w600,
//                                                      fontSize: 12,
//                                                      letterSpacing: -0.2,
//                                                      color: FintnessAppTheme
//                                                          .grey
//                                                          .withOpacity(0.5),
//                                                    ),
//                                                  ),
//                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: <Widget>[
//
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Center(
                              child: Stack(
                                overflow: Overflow.visible,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: FintnessAppTheme.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                        border: new Border.all(
                                            width: 5,
                                            color: FintnessAppTheme
                                                .nearlyDarkBlue
                                                .withOpacity(0.8)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundImage:
                                            AssetImage('assets/images/groot.jpg'),
                                            radius: 45,
                                          ),
//                                      Radius.circular(50.0),

//                                          Text(
//                                            '${(1503 * animation.value).toInt()}',
//                                            textAlign: TextAlign.center,
//                                            style: TextStyle(
//                                              fontFamily:
//                                                  FintnessAppTheme.fontName,
//                                              fontWeight: FontWeight.normal,
//                                              fontSize: 24,
//                                              letterSpacing: 0.0,
//                                              color: FintnessAppTheme
//                                                  .nearlyDarkBlue,
//                                            ),
//                                          ),
//                                          Text(
//                                            '',
//                                            textAlign: TextAlign.center,
//                                            style: TextStyle(
//                                              fontFamily:
//                                                  FintnessAppTheme.fontName,
//                                              fontWeight: FontWeight.bold,
//                                              fontSize: 12,
//                                              letterSpacing: 0.0,
//                                              color: FintnessAppTheme.grey
//                                                  .withOpacity(0.5),
//                                            ),
//                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(4.0),
                                  //   child: CustomPaint(
                                  //     painter: CurvePainter(
                                  //         colors: [
                                  //           FintnessAppTheme.nearlyDarkBlue,
                                  //           HexColor("#8A98E8"),
                                  //           HexColor("#8A98E8")
                                  //         ],
                                  //         angle: 140 +
                                  //             (360 - 140) *
                                  //                 (1.0 - animation.value)),
                                  //     child: SizedBox(
                                  //       width: 108,
                                  //       height: 108,
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 8),
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: FintnessAppTheme.background,
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 8, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          new GestureDetector(
                              onTap:(){
                                Navigator.push(
                                    context,   MaterialPageRoute(builder: (context) => HelpScreen())
                                );
                              },
                              child:Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Text(
                                      'Help',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: FintnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        letterSpacing: -0.2,
                                        color: FintnessAppTheme.darkText,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Container(
                                        height: 4,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color:
                                          HexColor('#87A0E5').withOpacity(0.2),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 70,
//                                          width: ((70 / 1.2) * animation.value),
                                              height: 4,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(colors: [
                                                  HexColor('#87A0E5'),
                                                  HexColor('#87A0E5')
                                                      .withOpacity(0.5),
                                                ]),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FintnessAppTheme.fontName,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: FintnessAppTheme.grey
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                          new GestureDetector(
                            onTap:(){
                              Navigator.push(
                                  context,   MaterialPageRoute(builder: (context) => FeedbackScreen())
                              );
                            },
                            child:Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      //New Gesture Detector
                                      Text(
                                        'FeedBack',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FintnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          letterSpacing: -0.2,
                                          color: FintnessAppTheme.darkText,
                                        ),

                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Container(
                                          height: 4,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: HexColor('#F56E98')
                                                .withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                width:70,
                                                //                                              width: ((70 / 2) *
                                                //                                                  animationController.value),
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  gradient:
                                                  LinearGradient(colors: [
                                                    HexColor('#F56E98')
                                                        .withOpacity(0.1),
                                                    HexColor('#F56E98'),
                                                  ]),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(4.0)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: FintnessAppTheme.fontName,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: FintnessAppTheme.grey
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new GestureDetector(
                              onTap:(){
                                Navigator.push(
                                    context,   MaterialPageRoute(builder: (context) => PdfPreview(animationController: animationController)
                                )
                                );
                              },
                              child: Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'About',
                                          style: TextStyle(
                                            fontFamily: FintnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.2,
                                            color: FintnessAppTheme.darkText,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 0, top: 4),
                                          child: Container(
                                            height: 4,
                                            width: 70,
                                            decoration: BoxDecoration(
                                              color: HexColor('#F1B440')
                                                  .withOpacity(0.2),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4.0)),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  width:70,
//                                              width: ((70 / 2.5) *
//                                                  animationController.value),
                                                  height: 4,
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                    LinearGradient(colors: [
                                                      HexColor('#F1B440')
                                                          .withOpacity(0.1),
                                                      HexColor('#F1B440'),
                                                    ]),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(4.0)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 6),
                                          child: Text(
                                            '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: FintnessAppTheme.fontName,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: FintnessAppTheme.grey
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ],
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