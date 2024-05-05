import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/user/states.dart';
import 'package:part_time/models/company/company_model.dart';
import 'package:part_time/models/person/person_model.dart';
import 'package:part_time/models/user/user_model.dart';
import 'package:part_time/network/database.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitialState());

  static UserCubit get(context) => BlocProvider.of(context);

  dynamic myUser;
  dynamic myToken;
  dynamic myUserFullData;

  void SetNewToken(newToken) {
    myToken = newToken;
    emit(SetNewTokenState());
  }

  Future GetUserData(context, dynamic json) async {
    myUser = UserModel.FromJson(json);
    print("User uid : ${myUser.id}");
    dynamic result = await NetworkDatabase.GetUserData(context: context,id: myUser.id);
    myUser.id = result["id"];
  }

  Future GetUserAllData(context, role) async {
    if (role == "ROLE_COMPANY") {
      var result = await NetworkDatabase.GetUserData(
          context: context,
          id: UserCubit.get(context).myUser.id,
          isCompany: "/company");
      myUserFullData = Company.FromJson(result) as Company;
    } else {
      var result = await NetworkDatabase.GetUserData(
          context: context,
          id: UserCubit.get(context).myUser.id
      );
      myUserFullData = Person.FromJson(result) as Person;
    }
    emit(GetUserFullDataState());
  }

  void SignOut() {
    myUser = null;
    myToken = null;
    myUserFullData = null;
    emit(UserSignOutState());
  }
}
