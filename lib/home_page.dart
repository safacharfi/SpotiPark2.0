import 'package:flutter/material.dart';
import 'package:land_registration/Admin/widget/homePageDecription.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Admin/constant/utils.dart';
import 'User/Authentification/Signin.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    if (width > 600) {
      width = 590;
      isDesktop = true;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Top Header
           
            Padding(
              padding: const EdgeInsets.only(left: 150.0, top: 0, right: 150),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const LeftDescription(),
                  Center(
                    child: Container(
                      width: 600,
                      height: 804,
                      child: SvgPicture.asset(
                        'assets/background_svg.svg',
                        height: 20.0,
                        width: 20.0,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sélectionnez votre rôle :',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xff28313b),
                  fontSize: 50,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomAnimatedContainer('Admin', () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const CheckPrivateKey(
                  //               val: "owner",
                  //             )));
                  Navigator.of(context).pushNamed(
                    '/login',
                    arguments: "owner",
                  );
                }),
                
                CustomAnimatedContainer('User', () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const CheckPrivateKey(
                  //               val: "UserLogin",
                  //             )));
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));

                }),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
