import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/login/states.dart';
import 'package:part_time/network/authentication.dart';

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

  Future LoginUsingEmailAndPassword() async {
    emit(LoginWithEmailAndPasswordOnProgressState());

    var result = await NetworkAuthenticate.Login(EmailController.text, PasswordController.text);
    if(result is String){
      emit(LoginWithEmailAndPasswordFaildState());
    }
    else{
      emit(LoginWithEmailAndPasswordSuccessfulState());
    }
    return result;
  }

}