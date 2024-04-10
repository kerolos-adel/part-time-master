import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/register/states.dart';
import 'package:part_time/cubit/settings/cubit.dart';
import 'package:part_time/network/authentication.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit(): super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // Global data
  bool visable = false;
  var EmailController = TextEditingController();
  var NameController = TextEditingController();
  var PasswordController = TextEditingController();

  // Person's data
  var BirthDateController = TextEditingController();
  String GenderSelected = "";


  // Company's data
  var LocationController = TextEditingController();
  var PhoneController = TextEditingController();

  void ChangePasswordSecure(){
    visable = !visable;
    emit(RegisterChangePasswordSecureState());
  }

  DateTime? picked;
  Future pickDateDialog(context) async {
    picked = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100)
    );
    if(picked!=null){
      BirthDateController.text = '${picked!.year} - ${picked!.month} - ${picked!.day}';
    }
  }


  Future CompanySignUp(context) async {
    emit(RegisterWithEmailAndPasswordOnProgressState());

    var result = await NetworkAuthenticate.CompanySignup(
        context,
        NameController.text,
        EmailController.text,
        PasswordController.text,
        LocationController.text,
        PhoneController.text
    );

    if(result is String){
      emit(RegisterWithEmailAndPasswordFaildState());
    }
    else{
      emit(RegisterWithEmailAndPasswordSuccessfulState());
    }

    return result;
  }

  Future ClientSignUp(context) async {
    emit(RegisterWithEmailAndPasswordOnProgressState());

    if(GenderSelected.isEmpty){
      emit(RegisterWithEmailAndPasswordFaildState());
      return SettingsCubit.get(context).currentLanguage["selectGender"];
    }

    var result = await NetworkAuthenticate.ClientSignup(
        context,
        NameController.text,
        EmailController.text,
        PasswordController.text,
        picked,
        GenderSelected
    );

    if(result is String){
      emit(RegisterWithEmailAndPasswordFaildState());
    }
    else{
      emit(RegisterWithEmailAndPasswordSuccessfulState());
    }

    return result;
  }

}