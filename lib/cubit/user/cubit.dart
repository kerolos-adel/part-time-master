import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/user/states.dart';
import 'package:part_time/models/company/company_model.dart';
import 'package:part_time/models/person/person_model.dart';
import 'package:part_time/models/user/user_model.dart';
import 'package:part_time/network/database.dart';

class UserCubit extends Cubit<UserStates>{

  UserCubit() : super(UserInitialState());

  static UserCubit get(context) => BlocProvider.of(context);

  dynamic myUser;
  dynamic myToken;
  dynamic myUserFullData;

  void SetNewToken(newToken){
    myToken = newToken;
    print("New Token has been set");
    emit(SetNewTokenState());
  }

  Future GetUserData(context, dynamic json) async {
    myUser = UserModel.FromJson(json);
    dynamic result = await NetworkDatabase.GetCompanyId(context, myUser.id);
    myUser.id = result["id"];
    print(myUser.name);
    print(myUser.email);
    print(myUser.id);
  }

  Future GetUserAllData(context, role) async {
    if(role == "ROLE_COMPANY"){
      var result = await NetworkDatabase.GetUserData(context: context, id: UserCubit.get(context).myUser.id, isCompany: "/company");
      print("Full Data : $result");
      myUserFullData = Company.FromJson(result);
    }

    else{
      var result = await NetworkDatabase.GetUserData(context: context, id: UserCubit.get(context).myUser.id);
      print("Full Data : $result");
      myUserFullData = Person.FromJson(result);
    }
    emit(GetUserFullDataState());
  }

  void SignOut(){
    myUser = null;
    myToken = null;
    myUserFullData = null;
    emit(UserSignOutState());
  }

}