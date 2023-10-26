// import 'dart:convert';
// import 'dart:io';

// import 'package:bank_app/screen/main/login_data.dart';
// import 'package:bank_app/screen/main/login_response.dart';

// Future<LoginResponse> login(LoginData loginData) async {
//   final client = HttpClient();
//   try {
//     HttpClientRequest request = await client.post(
//       'localhost',
//       5000,
//       '/login',
//     );
//     HttpClientResponse response = await request.close();
//     final stringData = await response.transform(utf8.decoder).join();
//     Map<String, dynamic> valueMap = json.decode(stringData);
//     LoginResponse loginResponse = LoginResponse.fromJson(valueMap);
//     return loginResponse;
//   } finally {
//     client.close();
//   }
// }
import 'dart:convert';
import 'dart:io';

import 'package:bank_app/screen/main/login_data.dart';
import 'package:bank_app/screen/main/login_response.dart';

Future<LoginResponse> login(LoginData loginData) async {
  final client = HttpClient();
  try {
    HttpClientRequest request = await client.post(
      'localhost',
      5000,
      '/login',
    );

    // Set the request headers to specify the content type as application/json
    request.headers.add('Content-Type', 'application/json');

    // Convert the loginData object to a JSON string
    final loginDataJson = json.encode(loginData);

    // Write the JSON data to the request body
    request.write(loginDataJson);

    HttpClientResponse response = await request.close();
    final stringData = await response.transform(utf8.decoder).join();
    Map<String, dynamic> valueMap = json.decode(stringData);
    LoginResponse loginResponse = LoginResponse.fromJson(valueMap);
    return loginResponse;
  } finally {
    client.close();
  }
}
