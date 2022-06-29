import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bank_misr/data/web_services/registration_services/registeration_services.dart';

import 'package:bank_misr/presentation/resources/constants_manager.dart';
import 'package:bank_misr/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import '../resources/assets_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, Routes.whichViewRoute);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            AnimatedSplashScreen(
              splashIconSize: 70,
              splash:
             const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
              nextScreen: Container(),
              disableNavigation: true,
              //splashTransition: SplashTransition.sizeTransition,
              splashTransition: SplashTransition.fadeTransition,
            
            ),
             Align(
                    alignment: Alignment.bottomCenter,
                    child: Text("Powered by Eyouth Tech team."),
                  )
          ],
       
        )
    ,);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
    hhh();
  }

}


Widget hhh(){


  return Container();
}