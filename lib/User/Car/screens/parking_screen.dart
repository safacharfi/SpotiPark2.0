// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home-screen.dart';

class ParkingScreen extends StatelessWidget {
  static const String id = 'parking_screen';
  const ParkingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkTheme,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 379.h,
                    width: 370.w,
                    decoration: const BoxDecoration(
                      color: largeCircleColor,
                      borderRadius: BorderRadius.all(Radius.circular(200)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 301.h,
                          width: 301.h,
                          decoration: const BoxDecoration(
                            color: mediumCircleColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(200)),
                          ),
                          child: Center(
                            child: Container(
                              height: 219.h,
                              width: 219.w,
                              decoration: const BoxDecoration(
                                color: smallCircle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(200)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 90.h,
                    right: 30.w,
                    child: Column(
                      children: [
                        Image.asset('images/light1.png'),
                        SizedBox(
                          height: 30.h,
                        ),
                        Image.asset('images/light2.png'),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 1,
                    bottom: 1,
                    right: 79,
                    left: 0,
                    child: SizedBox(
                      height: 200.h,
                      child: Image.asset(
                        'images/Car2.png',
                        height: 200.h,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              TextButtonsWidget(
                myIcon: const Icon(FontAwesomeIcons.car,
                    color: greenColor, size: 32),
                myText: 'Car Parking',
                myText1: 'You can feel best performance on your drive 💪',
                mySizedBox: const SizedBox(height: 82),
                onSkipped: (isSkipped) {
                  Navigator.pushNamed(context, HomeScreen.id);
                  print('Skip-button is pressed');
                },
                onPressedNext: (isPressedNext) {
                  Navigator.pushNamed(context, HomeScreen.id);
                  print('Next-button is pressed');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

typedef ButtonPressedCallback = void Function(bool);

class TextButtonsWidget extends StatelessWidget {
  final ButtonPressedCallback onSkipped;
  final ButtonPressedCallback onPressedNext;
  final Icon? myIcon;
  final String? myText;
  final String? myText1;
  final SizedBox mySizedBox;
  const TextButtonsWidget({
    super.key,
    this.myIcon,
    this.myText,
    this.myText1,
    required this.mySizedBox,
    required this.onSkipped,
    required this.onPressedNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 23,
              ),
              child: myIcon,
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(left: 7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    myText!,
                    style: const TextStyle(
                        fontFamily: 'Anta-Regular.ttf',
                        color: whiteButton,
                        fontSize: 23),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 21.h),
        Padding(
          padding: const EdgeInsets.only(left: 23),
          child: Text(
            myText1!,
            style: const TextStyle(
              fontFamily: 'Anta-Regular.ttf',
              color: Color(0xFFFFFFFF),
              fontSize: 32,
            ),
          ),
        ),
        mySizedBox,
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: InkWell(
            onTap: () {
              onPressedNext(true);
            },
            child: Container(
              width: 284.w,
              height: 73.h,
              decoration: BoxDecoration(
                color: greenButton,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontFamily: 'Anta-Regular.ttf',
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
