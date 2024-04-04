import 'dart:convert';
import 'package:http/http.dart' as http;
class NetworkAuthenticate{

  static Future ClientSignup(String name,String email,String password,DateTime? birthDate,String gender) async {
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
      return "Something Wrong happened";
    }

  }

  static Future CompanySignup(name, email, password, location, phoneNumber) async {
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
      return "Something Wrong happened";
    }

  }

  static Future Login(email, password) async {
    print("Login up...");
    final url = 'https://part-time.azurewebsites.net/auth/login';
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'email': email,
      'password' : password,
    };
    final body = json.encode(data);
    final response =
    await http.post(Uri.parse(url), headers: headers, body: body);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body);
    }
    else if(response.statusCode == 400){
      return "Invalid username or password";
    }
    else {
      return "Something wrong happened";
    }
  }


}