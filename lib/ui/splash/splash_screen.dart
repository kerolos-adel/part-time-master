import 'dart:async';
import 'package:flutter/material.dart';
import 'package:part_time/constants/assets/assets.dart';
import 'package:part_time/shared/preferences/cache_helper.dart';
import 'package:part_time/shared/styles/colors.dart';
import 'package:part_time/ui/company_layout/company_layout_screen.dart';
import 'package:part_time/ui/start_language/start_language_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay(){
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext(){
    print(CacheHelper.getData(key: "onboarding"));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      if(CacheHelper.getData(key: "onboarding") == true){
        return const CompanyLayoutScreen();
      }
      else {
        return const StartLanguageScreen();
      }
    }));
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backGround,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Image(
            image: AssetImage(AppAssets.mainLogo),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
