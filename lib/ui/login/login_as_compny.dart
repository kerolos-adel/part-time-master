import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/user/cubit.dart';
import 'package:part_time/shared/components/components.dart';
import 'package:part_time/ui/explore/explore_client_screen.dart';
import 'package:part_time/ui/explore/explore_comany_screen.dart';
import 'package:part_time/ui/register/choose-register.dart';
import '../../constants/assets/assets.dart';
import '../../cubit/login/cubit.dart';
import '../../cubit/login/states.dart';
import '../../cubit/settings/cubit.dart';
import 'choose_login.dart';

class LoginAsCompany extends StatefulWidget {
  const LoginAsCompany({Key? key}) : super(key: key);

  @override
  State<LoginAsCompany> createState() => _LoginAsCompanyState();
}

class _LoginAsCompanyState extends State<LoginAsCompany>
    with TickerProviderStateMixin {
  var formKey = GlobalKey<FormState>();
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
    return BlocBuilder<LoginCubit, LoginStates>(
        builder: (context, state) => Scaffold(
          body:Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.deepPurpleAccent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [.2, .9])),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChooseLogin(),
                        ));
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 40,
                    color: Colors.white,
                  )),
              title: Text(
                SettingsCubit.get(context).currentLanguage["companyLogin"],
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: "https://wallpaperaccess.com/full/643379.jpg",
                  placeholder: (context, url) => Image.asset(
                    'assets/images/wallpaper.jpg',
                    fit: BoxFit.fill,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  alignment: FractionalOffset(_animation.value, 0),
                ),
                Container(
                  color: Colors.black54,
                  height: double.infinity,
                  width: double.infinity,
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 80, right: 80),
                          child: Image.asset(AppAssets.mainLogo),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller:
                                  LoginCubit.get(context).EmailController,
                                  decoration: InputDecoration(
                                    labelText: SettingsCubit.get(context)
                                        .currentLanguage["email"],
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsetsDirectional.symmetric(
                                        horizontal: 10),
                                  ),
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return SettingsCubit.get(context)
                                          .currentLanguage["emailEmptyError"];
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextFormField(
                                  controller:
                                  LoginCubit.get(context).PasswordController,
                                  decoration: InputDecoration(
                                    labelText: SettingsCubit.get(context)
                                        .currentLanguage["password"],
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsetsDirectional.symmetric(
                                        horizontal: 10),
                                    suffixIcon: IconButton(
                                      icon: Icon(LoginCubit.get(context).visable
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () {
                                        LoginCubit.get(context)
                                            .ChangePasswordSecure();
                                      },
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                  obscureText: LoginCubit.get(context).visable,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return SettingsCubit.get(context)
                                          .currentLanguage["passwordEmptyError"];
                                    }
                                    if (value.length < 8 || value.length > 16) {
                                      return SettingsCubit.get(context)
                                          .currentLanguage["passwordLengthError"];
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              MaterialButton(
                                onPressed: state
                                is LoginWithEmailAndPasswordOnProgressState
                                    ? null
                                    : () async {
                                  if (formKey.currentState!.validate()) {
                                    await LoginCubit.get(context)
                                        .LoginUsingEmailAndPassword(context)
                                        .then((value) async {
                                      if (value is String) {
                                        myToast(
                                          msg: SettingsCubit.get(context).currentLanguage["loggInWrongCredentials"],
                                          backgroundColor: Colors.redAccent,
                                        );
                                      }
                                      else {
                                        myToast(
                                          msg: SettingsCubit.get(context).currentLanguage["loggedSuccessful"],
                                          backgroundColor: Colors.green,
                                        );
                                        while(Navigator.canPop(context))Navigator.pop(context);
                                        if(UserCubit.get(context).myUser.role == "ROLE_USER"){
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ExploreClientScreen()));
                                        }
                                        else{
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ExploreCompanyScreen()));
                                        }
                                      }
                                    });
                                  } else {
                                    print("Error");
                                  }
                                },
                                color: Colors.cyan,
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 14.0),
                                  child: state
                                  is LoginWithEmailAndPasswordOnProgressState
                                      ? CircularProgressIndicator()
                                      : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        SettingsCubit.get(context)
                                            .currentLanguage["login"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: RichText(
                                  text: TextSpan(children: [
                                     TextSpan(
                                        text: SettingsCubit.get(context).currentLanguage["doNotHaveAccount"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        )),
                                    const TextSpan(text: '   '),
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => const ChooseRegister(),)),
                                        text: SettingsCubit.get(context).currentLanguage["register"],
                                        style: const TextStyle(
                                            color: Colors.cyan,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        )
                                    ),
                                  ]),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
  Map<String, dynamic> decodeJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final Map<String, dynamic> payloadMap = json.decode(payload);
    return payloadMap;
  }
  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!');
    }
    return utf8.decode(base64Url.decode(output));
  }
}
