import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/login/states.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit(): super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  var EmailController = TextEditingController();
  var PasswordController = TextEditingController();
  bool visable = true;

  void ChangePasswordSecure(){
    visable = !visable;
    emit(LoginChangePasswordSecureState());
  }

}