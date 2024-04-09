import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:part_time/cubit/settings/cubit.dart';
class NetworkAuthenticate{

  static Future ClientSignup(context, String name,String email,String password,DateTime? birthDate,String gender) async {
    print('Signing up...');
    print(birthDate.toString().split(" "));
    final url = 'https://part-time.azurewebsites.net/auth/register';
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'name': name,
      'email': email,
      'password' : password,
      'gender': gender,
      'birthDate': birthDate.toString().split(" ")[0],
    };
    final body = json.encode(data);
    final response =
    await http.post(Uri.parse(url), headers: headers, body: body);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return SettingsCubit.get(context).currentLanguage["unknownError"];
    }

  }

  static Future CompanySignup(context, name, email, password, location, phoneNumber) async {
    print('Signing up...');

    final url = 'https://part-time.azurewebsites.net/auth/register/company';
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'name': name,
      'email': email,
      'password' : password,
      'location': location,
      'phoneNumber': phoneNumber,
    };
    final body = json.encode(data);
    final response =
    await http.post(Uri.parse(url), headers: headers, body: body);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return SettingsCubit.get(context).currentLanguage["unknownError"];
    }

  }

  static Future Login(context, email, password) async {
    final url = 'https://part-time.azurewebsites.net/auth/login';
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'email': email,
      'password' : password,
    };
    final body = json.encode(data);
    final response =
    await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body);
    }
    else if(response.statusCode == 400){
      return SettingsCubit.get(context).currentLanguage["invalidLoginData"];
    }
    else {
      return SettingsCubit.get(context).currentLanguage["unknownError"];
    }
  }


}