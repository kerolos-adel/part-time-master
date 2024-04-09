import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:part_time/cubit/user/cubit.dart';

class NetworkDatabase{

  // Get person/company database
  static Future GetUserData({context, id, String isCompany = ""}) async {
    final url = 'https://part-time.azurewebsites.net/api/users/${id}${isCompany}';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${UserCubit.get(context).myToken}'
    };
    final response =
    await http.get(Uri.parse(url), headers: headers);
    return json.decode(response.body);
  }

  static Future GetJobCompany({context, id}) async {
    final url = 'https://part-time.azurewebsites.net/api/jobs/${id}/company';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${UserCubit.get(context).myToken}'
    };
    final response =
    await http.get(Uri.parse(url), headers: headers);
    return json.decode(response.body);
  }

  // Get My jobs
  static Future GetMyJobs({
    required context,
  }) async {
    print("ID: ${UserCubit.get(context).myUser.id}");
    final url = 'https://part-time.azurewebsites.net/api/companies/${UserCubit.get(context).myUser.id}/jobs';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${UserCubit.get(context).myToken}'
    };
    final response =
    await http.get(Uri.parse(url), headers: headers);
    return json.decode(response.body);
  }

  // Get All available jobs
  static Future GetAllJobs({
    required context,
  }) async {
    final url = 'https://part-time.azurewebsites.net/api/jobs';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${UserCubit.get(context).myToken}'
    };
    final response =
    await http.get(Uri.parse(url), headers: headers);

    return json.decode(response.body);
  }

  static Future GetCompanyId(context, id) async {
    final url = 'https://part-time.azurewebsites.net/api/users/${id}/company';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${UserCubit.get(context).myToken}'
    };
    final response =
    await http.get(Uri.parse(url), headers: headers);

    return json.decode(response.body);
  }

  // Post a job
  static Future PostJob({
    required context,
    required title,
    required location,
    required description,
    required requirements,
    required applyLink,
    required companyId,
    required ageFrom,
    required ageTo,
}) async {
    final url = 'https://part-time.azurewebsites.net/api/jobs/custom';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${UserCubit.get(context).myToken}'
    };
    final data = {
      "title": title,
      "location": location,
      "description": description,
      "requirements": requirements,
      "applyLink": applyLink,
      "ageFrom": ageFrom,
      "ageTo": ageTo,
      "companyId": companyId
    };
    final body = json.encode(data);
    final response = await http.post(Uri.parse(url), headers: headers, body: body);
    return response;
  }

  static Future UpdateJob({
    required jobId,
    required context,
    required title,
    required location,
    required description,
    required requirements,
    required applyLink,
    required ageFrom,
    required ageTo,
  }) async {
    final url = 'https://part-time.azurewebsites.net/api/jobs/${jobId}';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${UserCubit.get(context).myToken}'
    };
    final data = {
      "title": title,
      "location": location,
      "description": description,
      "requirements": requirements,
      "applyLink": applyLink,
      "ageFrom": ageFrom,
      "ageTo": ageTo,
    };
    final body = json.encode(data);
    final response = await http.put(Uri.parse(url), headers: headers, body: body);
    print(response.statusCode);
    print(response.body);

    return response.statusCode;
  }


  static Future DeleteJob({
    required jobId,
    required context,
  }) async {
    final url = 'https://part-time.azurewebsites.net/api/jobs/${jobId}';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${UserCubit.get(context).myToken}'
    };
    final response = await http.delete(Uri.parse(url), headers: headers);
    print(response.statusCode);
    return response.statusCode;
  }


}