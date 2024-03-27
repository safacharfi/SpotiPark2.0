// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../colors.dart';
import '../widget/color_changing_container.dart';
import '../AddVehicule.dart';
import '/User/dashboard.dart';
enum Type {
  car,
  bike,
  bus,
}

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Type? selectedType;
  String _carImage = 'assets/images/car (1).png';
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: darkTheme,
          appBar: AppBar(
            backgroundColor: darkTheme,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Ajout de l'icône de la maison à gauche
                IconButton(
                  onPressed: () {
                    // Naviguer vers le tableau de bord
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard()),
                    );
                  },
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                ),
                // Bouton Skip for now amélioré
                TextButton(
                  onPressed: () {
                    // Naviguer vers le tableau de bord
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard()),
                    );
                  },
                  child: Text(
                    'Skip for now',
                    style: TextStyle(
                      color: const Color.fromRGBO(3, 100, 176, 65),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 27, top: 38),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '',
                  style: TextStyle(color: Color(0xFFD9D8E0), fontSize: 20),
                ),
                const Text(
                  'What are You Driving',
                  style: TextStyle(
                    color: const Color.fromRGBO(3, 100, 176, 65),
                    fontSize: 30,
                    fontFamily: 'Anta-Regular.ttf',
                  ),
                ),
                const Text(
                  'today?',
                  style: TextStyle(
                    color: const Color.fromRGBO(3, 100, 176, 65),
                    fontSize: 35,
                  ),
                ),
                const SizedBox(height: 34),
                Row(
                  children: [
                    // Ajout d'icônes pour les options de véhicule
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedType = Type.car;
                          _carImage = 'assets/images/car (1).png';
                        });
                      },
                      child: ColorChangingContainer(
                        containerColor: selectedType == Type.car
                            ? inActiveContainerColor
                            : activeContainerColor,
                        containerIcon: Icon(
                          FontAwesomeIcons.car,
                          size: 30,
                          color: selectedType == Type.car
                              ? inActiveTextColor
                              : activeTextColor,
                        ),
                        containerText: 'Car',
                        myTextColor: selectedType == Type.car
                            ? inActiveTextColor
                            : activeTextColor,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedType = Type.bike;
                          _carImage = 'assets/images/bike (2).png';
                        });
                      },
                      child: ColorChangingContainer(
                        containerColor: selectedType == Type.bike
                            ? inActiveContainerColor
                            : activeContainerColor,
                        containerIcon: Icon(
                          FontAwesomeIcons.motorcycle,
                          size: 30,
                          color: selectedType == Type.car
                              ? inActiveTextColor
                              : activeTextColor,
                        ),
                        containerText: 'Bike',
                        myTextColor: selectedType == Type.bike
                            ? inActiveTextColor
                            : activeTextColor,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedType = Type.bus;
                          _carImage = 'images/bus.png';
                        });
                      },
                      child: ColorChangingContainer(
                        containerColor: selectedType == Type.bus
                            ? inActiveContainerColor
                            : activeContainerColor,
                        containerIcon: Icon(
                          FontAwesomeIcons.bus,
                          size: 30,
                          color: selectedType == Type.bus
                              ? inActiveTextColor
                              : activeTextColor,
                        ),
                        containerText: 'Bus',
                        myTextColor: selectedType == Type.bus
                            ? inActiveTextColor
                            : activeTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/images/line1.png'),
                          const SizedBox(width: 80),
                          Image.asset(
                            _carImage,
                            height: 330.h,
                          ),
                          const SizedBox(width: 75),
                          Image.asset('assets/images/line2.png')
                        ],
                      ),
                      Positioned(
                        left: 127,
                        top: 280,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              // Naviguer vers l'écran d'ajout de véhicule
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => VehiclesEditScreen()),
                              );
                            },
                            child: Container(
                              height: 80.h,
                              width: 80.w,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(3, 100, 176, 65),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Tap to add',
                                      style: TextStyle(
                                        fontFamily: 'Anta-Regular.ttf',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to close the app?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      }
    );
    return exitApp;
  }
}
