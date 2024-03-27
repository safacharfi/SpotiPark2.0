import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:land_registration/Admin/providers/LandRegisterModel.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'Admin/constant/routes.dart';
import 'Admin/providers/MetamaskProvider.dart';
import 'User/Authentification/UserLinking.dart';
import 'User/booking/ContractLinking.dart';
import 'User/balance/BalanceLinking.dart' as BalanceBooking;
import 'Admin/Parkinglot/parkinglotLinking.dart';
import 'User/Car/VehiculeLinking.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_page.dart';


void main() {
  runApp(const ParkieApp());
}

class ParkieApp extends StatelessWidget {
  const ParkieApp({Key? key}); // Correction de la syntaxe ici

  @override
  Widget build(BuildContext context) {
    return MultiProvider( // Utilisation de MultiProvider pour plusieurs providers
      providers: [
        ChangeNotifierProvider<LandRegisterModel>(
          create: (context) => LandRegisterModel(),
        ),
        ChangeNotifierProvider<UserController>(
          create: (_) => UserController(),
        ),
        ChangeNotifierProvider<BalanceBooking.ContractLinking>(
          create: (_) => BalanceBooking.ContractLinking(),
        ), // Utilisation de l'alias pour le package de réservation
        ChangeNotifierProvider<ContractLinking>(
          create: (_) => ContractLinking(),
        ),
        ChangeNotifierProvider<VehicleController>(
          create: (_) => VehicleController(),
        ),
           ChangeNotifierProvider<MetaMaskProvider>(
          create: (context) => MetaMaskProvider()..init(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: home_page(),
            routes: {
            },
          );
        },
      ),
    );
  }
}
