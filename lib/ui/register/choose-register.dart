import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:part_time/cubit/settings/cubit.dart';
import 'package:part_time/ui/login/choose_login.dart';
import 'package:part_time/ui/register/register_as_client.dart';
import 'package:part_time/ui/register/register_as_compny.dart';

class ChooseRegister extends StatefulWidget {
  const ChooseRegister({Key? key}) : super(key: key);

  @override
  State<ChooseRegister> createState() => _ChooseRegisterState();
}

class _ChooseRegisterState extends State<ChooseRegister> with TickerProviderStateMixin{
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation =
    CurvedAnimation(parent: _animationController, curve: Curves.linear)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.completed) {
          _animationController.reset();
          _animationController.forward();
        }
      });
    _animationController.forward();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
        CachedNetworkImage(
        imageUrl:
        "https://images.fineartamerica.com/images/artworkimages/mediumlarge/1/capital-arrow-stanislav-killer.jpg",
        placeholder: (context, url) => Image.asset(
          'assets/images/wallpaper.jpg',
          fit: BoxFit.fill,
        ),
        errorWidget: (context, url, error) =>
        const Icon(Icons.error),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        alignment: FractionalOffset(_animation.value, 0),
      ),  Center(
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterAsClientScreen(),));
                },
                color: Colors.cyan,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(13),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 14.0),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Text(
                        SettingsCubit.get(context).currentLanguage["clientRegister"],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          SizedBox(height: 35,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterAsClientCompany(),));

                },
                color: Colors.cyan,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(13),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 14.0),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Text(
                        SettingsCubit.get(context).currentLanguage["companyRegister"],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
            SizedBox(height: 35,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ChooseLogin(),));

                  },
                  color: Colors.cyan,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(13),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text(

                          SettingsCubit.get(context).currentLanguage["login"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
        ],),
      ),])
    );
  }
}
