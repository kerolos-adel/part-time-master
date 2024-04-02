import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/register/states.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit(): super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // Global data
  var AccountType = "";
  bool visable = false;
  var EmailController = TextEditingController();
  var NameController = TextEditingController();
  var PasswordController = TextEditingController();

  // Person's data
  var AgeController = TextEditingController();
  var EducationController = TextEditingController();


  // Company's data
  var LocationController = TextEditingController();
  var PhoneController = TextEditingController();

  void ChangePasswordSecure(){
    visable = !visable;
    emit(RegisterChangePasswordSecureState());
  }
  void ChangeAccountType(type){
    AccountType = type;
    emit(RegisterChangeAccountTypeState());
  }

}