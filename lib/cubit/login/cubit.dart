import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/job/cubit.dart';
import 'package:part_time/cubit/login/states.dart';
import 'package:part_time/cubit/user/cubit.dart';
import 'package:part_time/network/authentication.dart';
import 'package:part_time/shared/methods/methods.dart';

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

  Future LoginUsingEmailAndPassword(context) async {
    emit(LoginWithEmailAndPasswordOnProgressState());

    var result = await NetworkAuthenticate.Login(context, EmailController.text, PasswordController.text);
    if(result is String){
      emit(LoginWithEmailAndPasswordFaildState());
    }
    else{
      UserCubit.get(context).SetNewToken(result["token"]);
      Map<String, dynamic> decodedToken =
      decodeJwt(result["token"]);
      await UserCubit.get(context).GetUserData(context, decodedToken);
      await UserCubit.get(context).GetUserAllData(context, UserCubit.get(context).myUser.role);
      // print(UserCubit.get(context).myUserFullData.name);
      // print(UserCubit.get(context).myUserFullData.email);
      // print(UserCubit.get(context).myUserFullData.id);
      if(UserCubit.get(context).myUser.role == "ROLE_USER")
        await JobCubit.get(context).GetAllJobs(context);
      else
        await JobCubit.get(context).GetMyJobs(context);

      emit(LoginWithEmailAndPasswordSuccessfulState());
    }
    return result;
  }

}