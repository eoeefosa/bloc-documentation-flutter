// The data provider will usually expose simple APIs to perform CRUD operations.

import 'dart:convert';
import 'package:blocdocplay/blocArchitecture/dataprovider/user.dart';
import 'package:http/http.dart' as http;

class DataProvider {
  Future<User> readData() async {
    // Read from DB or make network request etc...
    // Return a user
    return User('John', 1234567890);
  }

  Future<User> createData(String name, int id) async {
    // Write to Db
    // Send a request to your database or API with the data you want to create
    // For example, using http.post method
    var response = await http.post(
      Uri.parse('https://example.com/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'id': id,
      }),
    );
    // Check the status code and convert the response into a User object
    if (response.statusCode == 201) {
      // The request was successful
      return User.fromJson(jsonDecode(response.body));
    } else {
      // The request failed
      throw Exception('Failed to create user');
    }
  }
// my version
  // Future<User> createData(String name, int id) async {
  //   return User(name, id);
  // }

  Future<User> updateData(String name, int id) async {
    // find out how to update data
    // Send a request to your database or API with the new data
    // For example, using http.put method

    var response = await http.put(
      Uri.parse('https://example.com/users/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'id': id,
      }),
    );
    // Check the status code and convert the response into a User object
    if (response.statusCode == 200) {
      // The request was successful
      return User.fromJson(jsonDecode(response.body));
    }
    // The request failed
    else {
      throw Exception('Failed to update user');
    }
  }

  Future<User> deleteData(String name, int id) async {
    // Send a request to your database or API with the id of the data you want to delete
    // For example, using http.delete method
    var response = await http.delete(
      Uri.parse('https://example.com/users/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    // Check the status code and convert the response into a User object
    if (response.statusCode == 200) {
      // The request was successful
      return User.fromJson(jsonDecode(response.body));
    } else {
      // The request failed
      throw Exception('Failed to delete user');
    }
  }
}

// // Data model
// class User {
//   final String name;
//   final int id;

//   User(this.name, this.id);
//   // A constructor that creates a User from a JSON map
//   User.fromJson(Map<String, dynamic> json)
//       : name = json['name'],
//         id = json['id'];
// }
