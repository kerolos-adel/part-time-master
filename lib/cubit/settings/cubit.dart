import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/constants/strings/strings.dart';
import 'package:part_time/cubit/settings/states.dart';

class SettingsCubit extends Cubit<SettingsStates>{

  SettingsCubit() : super(SettingsInitialState());

  static SettingsCubit get(context) => BlocProvider.of(context);

  dynamic currentLanguage = EnglishStrings;
  Set<String> selected = {"en"};
  void ChangeCurrentLanguage(value){
    selected = value;
    if(value.first == "en"){
      currentLanguage = EnglishStrings;
    }
    else{
      currentLanguage = ArabicStrings;
    }
    emit(SettingsChangeLanguageState());
  }

}