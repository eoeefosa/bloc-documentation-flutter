import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'user.dart';

Future<User> createData() async {
  var user = User('John', 1234567890);
  var response = await http.post(Uri.parse('https://example.com/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()));
  return User.fromJson(jsonDecode(response.body));
}
