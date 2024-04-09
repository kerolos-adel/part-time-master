import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:part_time/cubit/register/cubit.dart';
import 'package:part_time/cubit/register/states.dart';
import 'package:part_time/cubit/settings/cubit.dart';
import 'package:part_time/shared/components/components.dart';
import 'package:part_time/ui/login/login_as_client.dart';

import '../../cubit/login/cubit.dart';
import 'choose-register.dart';

class RegisterAsClientCompany extends StatefulWidget {
  const RegisterAsClientCompany({super.key});

  @override
  State<RegisterAsClientCompany> createState() => _RegisterAsClientCompanyState();
}

class _RegisterAsClientCompanyState extends State<RegisterAsClientCompany>
    with TickerProviderStateMixin {
  var formKey = GlobalKey<FormState>();
  File? imageFile;

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
    return BlocBuilder<RegisterCubit, RegisterStates>(
        builder: (context, state) => Scaffold(
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
                        builder: (context) => ChooseRegister(),
                      ));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 40,
                  color: Colors.white,
                )),
            title: Text(
                SettingsCubit.get(context).currentLanguage["companyRegister"],
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Stack(
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
              ),
              Container(
                color: Colors.black54,
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 80),
                  child: SizedBox(
                      width: double.infinity,
                      child: ListView(
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  controller: RegisterCubit.get(context)
                                      .NameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return SettingsCubit.get(context).currentLanguage["fieldMissing"];
                                    } else {
                                      return null;
                                    }
                                  },
                                  style:
                                  const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.drive_file_rename_outline,
                                        color: Colors.white,
                                      ),
                                      hintText: SettingsCubit.get(context).currentLanguage["companyNameHint"],
                                      hintStyle:
                                      TextStyle(color: Colors.white),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: RegisterCubit.get(context)
                                      .EmailController,
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !value.contains('@')) {
                                      return SettingsCubit.get(context).currentLanguage["emailValidationError"];
                                    } else {
                                      return null;
                                    }
                                  },
                                  style:
                                  const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                      hintText: SettingsCubit.get(context).currentLanguage["email"],
                                      hintStyle:
                                      TextStyle(color: Colors.white),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType:
                                  TextInputType.visiblePassword,
                                  controller: RegisterCubit.get(context)
                                      .PasswordController,
                                  obscureText:
                                  LoginCubit.get(context).visable,
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        value.length < 6) {
                                      return SettingsCubit.get(context).currentLanguage["passwordLengthError"];
                                    } else {
                                      return null;
                                    }
                                  },
                                  style:
                                  const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            LoginCubit.get(context)
                                                .visable =
                                            !LoginCubit.get(context)
                                                .visable;
                                          });
                                        },
                                        child: Icon(
                                          LoginCubit.get(context).visable
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.white,
                                        ),
                                      ),
                                      hintText: SettingsCubit.get(context).currentLanguage["password"],
                                      hintStyle: const TextStyle(
                                          color: Colors.white),
                                      enabledBorder:
                                      const UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder:
                                      const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.phone,
                                  controller: RegisterCubit.get(context)
                                      .PhoneController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return SettingsCubit.get(context).currentLanguage["phoneNumberEmptyError"];
                                    }

                                    else {
                                      String phone = value;
                                      if(phone[0] == '+')phone = phone.substring(1);
                                      if(int.tryParse(phone) == null){
                                        return SettingsCubit.get(context).currentLanguage["phoneValidError"];
                                      }
                                      return null;
                                    }
                                  },
                                  style:
                                  const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                      ),
                                      hintText: SettingsCubit.get(context).currentLanguage["phoneNumber"],
                                      hintStyle:
                                      TextStyle(color: Colors.white),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red))),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  controller: RegisterCubit.get(context)
                                      .LocationController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return SettingsCubit.get(context).currentLanguage["addressValidationError"];
                                    } else {
                                      return null;
                                    }
                                  },
                                  style:
                                  const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                      ),
                                      hintText: SettingsCubit.get(context).currentLanguage["address"],
                                      hintStyle:
                                      TextStyle(color: Colors.white),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red))),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                MaterialButton(
                                    onPressed: state is RegisterWithEmailAndPasswordOnProgressState
                                        ? null : () async {
                                      if (formKey.currentState!.validate()) {
                                        print("All Data is ok");
                                        await RegisterCubit.get(context).CompanySignUp(context).then((value){
                                          if(value is String){
                                            myToast(
                                                msg: value,
                                                backgroundColor: Colors.redAccent
                                            );
                                          }
                                          else{
                                            myToast(
                                                msg: SettingsCubit.get(context).currentLanguage["registeredSuccessful"],
                                                backgroundColor: Colors.green
                                            );
                                          }
                                        });
                                      } else {
                                        print("Error");
                                      }
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
                                      child: state == RegisterWithEmailAndPasswordOnProgressState
                                          ? CircularProgressIndicator()
                                          : Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            SettingsCubit.get(context)
                                                .currentLanguage[
                                            "register"],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      SettingsCubit.get(context)
                                          .currentLanguage["alreadyRegistered"],
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const LoginAsClientScreen()));
                                        },
                                        child: Text(
                                          SettingsCubit.get(context)
                                              .currentLanguage["login"],
                                          style: const TextStyle(
                                              color: Colors.teal),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}