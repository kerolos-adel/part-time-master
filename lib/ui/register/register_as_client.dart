import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:part_time/cubit/register/cubit.dart';
import 'package:part_time/cubit/register/states.dart';
import 'package:part_time/cubit/settings/cubit.dart';
import 'package:part_time/ui/login/login_as_client.dart';
import 'package:part_time/ui/login/login_as_compny.dart';

import '../../cubit/login/cubit.dart';
import 'choose-register.dart';

class RegisterAsClientScreen extends StatefulWidget {
  const RegisterAsClientScreen({super.key});

  @override
  State<RegisterAsClientScreen> createState() => _RegisterAsClientScreenState();
}

class _RegisterAsClientScreenState extends State<RegisterAsClientScreen>
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

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Please choose an option",
            style: TextStyle(fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  _getFromCamera();
                },
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.camera,
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      'camera',
                      style: TextStyle(color: Colors.purple),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _getFromGallery();
                },
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.image,
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      'Gallery',
                      style: TextStyle(color: Colors.purple),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  List gender = ["Male", "Female", "Other"];

  String? select;

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme
              .of(context)
              .primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value) {
            setState(() {
              print(value);
              select = value;
            });
          },
        ),
        Text(title,style: TextStyle(color: Colors.white,fontSize: 15),)
      ],
    );
  }

  void _getFromCamera() async {
    XFile? pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void _cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return BlocBuilder<RegisterCubit, RegisterStates>(
        builder: (context, state) =>
            Scaffold(
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
                title: const Text(
                  "Register as Client",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                    "https://images.fineartamerica.com/images/artworkimages/mediumlarge/1/capital-arrow-stanislav-killer.jpg",
                    placeholder: (context, url) =>
                        Image.asset(
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


                                    // GestureDetector(
                                    //   onTap: () {
                                    //     _showImageDialog();
                                    //   },
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(8),
                                    //     child: Container(
                                    //       width: size.width * .24,
                                    //       height: size.width * .24,
                                    //       decoration: BoxDecoration(
                                    //           border: Border.all(
                                    //             width: 1,
                                    //             color: Colors.cyanAccent,
                                    //           ),
                                    //           borderRadius:
                                    //               BorderRadius.circular(20)),
                                    //       child: ClipRRect(
                                    //         borderRadius:
                                    //             BorderRadius.circular(16),
                                    //         child: imageFile == null
                                    //             ? const Icon(
                                    //                 Icons.camera_enhance_sharp,
                                    //                 color: Colors.cyan,
                                    //                 size: 30,
                                    //               )
                                    //             : Image.file(imageFile!,
                                    //                 fit: BoxFit.fill),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    TextFormField(
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      controller: RegisterCubit
                                          .get(context)
                                          .NameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "This Field is missing";
                                        } else {
                                          return null;
                                        }
                                      },
                                      style:
                                      const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.drive_file_rename_outline,
                                            color: Colors.white,
                                          ),
                                          hintText: "Full Name",
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
                                      controller: RegisterCubit
                                          .get(context)
                                          .EmailController,
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !value.contains('@')) {
                                          return "please enter a valid Email address";
                                        } else {
                                          return null;
                                        }
                                      },
                                      style:
                                      const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.email,
                                            color: Colors.white,
                                          ),
                                          hintText: "Email",
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
                                      controller: RegisterCubit
                                          .get(context)
                                          .PasswordController,
                                      obscureText:
                                      LoginCubit
                                          .get(context)
                                          .visable,
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 6) {
                                          return "please enter a valid password";
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
                                                LoginCubit
                                                    .get(context)
                                                    .visable =
                                                !LoginCubit
                                                    .get(context)
                                                    .visable;
                                              });
                                            },
                                            child: Icon(
                                              LoginCubit
                                                  .get(context)
                                                  .visable
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.white,
                                            ),
                                          ),
                                          hintText: "Password",
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
                                      keyboardType: TextInputType.text,
                                      controller: RegisterCubit
                                          .get(context)
                                          .AgeController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "please enter a valid age";
                                        } else {
                                          return null;
                                        }
                                      },
                                      style:
                                      const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                          suffixIcon: Icon(
                                            Icons.apps_outage_outlined,
                                            color: Colors.white,
                                          ),
                                          hintText: "Age",
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
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      const Text("Choose Gender", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.white
                                      ),

                                      ),
                                      Row(
                                        children: <Widget>[
                                          addRadioButton(0, 'Male'),
                                          addRadioButton(1, 'Female'),
                                          addRadioButton(2, 'Others'),
                                        ],
                                      ),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.white,
                                        ),
                                    ],),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    MaterialButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate() &&
                                              RegisterCubit
                                                  .get(context)
                                                  .AccountType
                                                  .isNotEmpty) {
                                            print("All Data is ok");
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
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                SettingsCubit
                                                    .get(context)
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
                                          SettingsCubit
                                              .get(context)
                                              .currentLanguage[
                                          "alreadyRegistered"],
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
                                                      const LoginAsCompany()));
                                            },
                                            child: Text(
                                              SettingsCubit
                                                  .get(context)
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

  Widget PersonRegisterBuilder(context) {
    List<String> genderItems = [
      SettingsCubit
          .get(context)
          .currentLanguage["male"],
      SettingsCubit
          .get(context)
          .currentLanguage["female"],
    ];
    String genderSelectedItem =
    SettingsCubit
        .get(context)
        .currentLanguage["male"];
    List<String> educationItems = [
      SettingsCubit
          .get(context)
          .currentLanguage["bachelors"],
      SettingsCubit
          .get(context)
          .currentLanguage["masters"],
      SettingsCubit
          .get(context)
          .currentLanguage["doctoral"],
    ];
    String educationSelectedItem =
    SettingsCubit
        .get(context)
        .currentLanguage["bachelors"];
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: RegisterCubit
                .get(context)
                .NameController,
            decoration: InputDecoration(
              labelText: SettingsCubit
                  .get(context)
                  .currentLanguage["name"],
              border: InputBorder.none,
              contentPadding:
              const EdgeInsetsDirectional.symmetric(horizontal: 10),
            ),
            cursorColor: Colors.black,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return SettingsCubit
                    .get(context)
                    .currentLanguage["nameEmptyError"];
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
            controller: RegisterCubit
                .get(context)
                .AgeController,
            decoration: InputDecoration(
              labelText: SettingsCubit
                  .get(context)
                  .currentLanguage["age"],
              border: InputBorder.none,
              contentPadding:
              const EdgeInsetsDirectional.symmetric(horizontal: 10),
            ),
            cursorColor: Colors.black,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return SettingsCubit
                    .get(context)
                    .currentLanguage["ageEmptyError"];
              }
              if (int.tryParse(value) == null) {
                return SettingsCubit
                    .get(context)
                    .currentLanguage["ageParseError"];
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  SettingsCubit
                      .get(context)
                      .currentLanguage["gender"],
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DropdownButton(
                      value: genderSelectedItem,
                      items: genderItems
                          .map((e) =>
                          DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                          .toList(),
                      onChanged: (item) =>
                          setState(() {
                            genderSelectedItem = item!;
                          })),
                ),
              ],
            ),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  SettingsCubit
                      .get(context)
                      .currentLanguage["educationLevel"],
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DropdownButton(
                      value: educationSelectedItem,
                      items: educationItems
                          .map((e) =>
                          DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                          .toList(),
                      onChanged: (item) =>
                          setState(() {
                            educationSelectedItem = item!;
                          })),
                ),
              ],
            ),
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
            controller: RegisterCubit
                .get(context)
                .EmailController,
            decoration: InputDecoration(
              labelText: SettingsCubit
                  .get(context)
                  .currentLanguage["email"],
              border: InputBorder.none,
              contentPadding:
              const EdgeInsetsDirectional.symmetric(horizontal: 10),
            ),
            cursorColor: Colors.black,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return SettingsCubit
                    .get(context)
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
            controller: RegisterCubit
                .get(context)
                .PasswordController,
            decoration: InputDecoration(
              labelText: SettingsCubit
                  .get(context)
                  .currentLanguage["password"],
              border: InputBorder.none,
              contentPadding:
              const EdgeInsetsDirectional.symmetric(horizontal: 10),
              suffixIcon: IconButton(
                icon: Icon(RegisterCubit
                    .get(context)
                    .visable
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () {
                  RegisterCubit.get(context).ChangePasswordSecure();
                },
              ),
            ),
            cursorColor: Colors.black,
            obscureText: RegisterCubit
                .get(context)
                .visable,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return SettingsCubit
                    .get(context)
                    .currentLanguage["passwordEmptyError"];
              }
              if (value.length < 8 || value.length > 16) {
                return SettingsCubit
                    .get(context)
                    .currentLanguage["passwordLengthError"];
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget CompanyRegisterBuilder(context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            controller: RegisterCubit
                .get(context)
                .NameController,
            decoration: InputDecoration(
              labelText: SettingsCubit
                  .get(context)
                  .currentLanguage["name"],
              border: InputBorder.none,
              contentPadding:
              const EdgeInsetsDirectional.symmetric(horizontal: 10),
            ),
            cursorColor: Colors.black,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return SettingsCubit
                    .get(context)
                    .currentLanguage["nameEmptyError"];
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
            controller: RegisterCubit
                .get(context)
                .LocationController,
            decoration: InputDecoration(
              labelText: SettingsCubit
                  .get(context)
                  .currentLanguage["location"],
              border: InputBorder.none,
              contentPadding:
              const EdgeInsetsDirectional.symmetric(horizontal: 10),
            ),
            cursorColor: Colors.black,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return SettingsCubit
                    .get(context)
                    .currentLanguage["locationEmptyError"];
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
            controller: RegisterCubit
                .get(context)
                .PhoneController,
            decoration: InputDecoration(
              labelText:
              SettingsCubit
                  .get(context)
                  .currentLanguage["phoneNumber"],
              border: InputBorder.none,
              contentPadding:
              const EdgeInsetsDirectional.symmetric(horizontal: 10),
            ),
            cursorColor: Colors.black,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return SettingsCubit
                    .get(context)
                    .currentLanguage["phoneNumberEmptyError"];
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
            controller: RegisterCubit
                .get(context)
                .EmailController,
            decoration: InputDecoration(
              labelText: SettingsCubit
                  .get(context)
                  .currentLanguage["email"],
              border: InputBorder.none,
              contentPadding:
              const EdgeInsetsDirectional.symmetric(horizontal: 10),
            ),
            cursorColor: Colors.black,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return SettingsCubit
                    .get(context)
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
            controller: RegisterCubit
                .get(context)
                .PasswordController,
            decoration: InputDecoration(
              labelText: SettingsCubit
                  .get(context)
                  .currentLanguage["password"],
              border: InputBorder.none,
              contentPadding:
              const EdgeInsetsDirectional.symmetric(horizontal: 10),
              suffixIcon: IconButton(
                icon: Icon(RegisterCubit
                    .get(context)
                    .visable
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () {
                  RegisterCubit.get(context).ChangePasswordSecure();
                },
              ),
            ),
            cursorColor: Colors.black,
            obscureText: RegisterCubit
                .get(context)
                .visable,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value!.isEmpty) {
                return SettingsCubit
                    .get(context)
                    .currentLanguage["passwordEmptyError"];
              }
              if (value.length < 8 || value.length > 16) {
                return SettingsCubit
                    .get(context)
                    .currentLanguage["passwordLengthError"];
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
