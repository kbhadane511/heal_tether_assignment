import 'dart:convert';
import 'package:heal_tether_assignment/models/user.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String url = "https://jsonplaceholder.typicode.com/users";

  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((user) => User.fromJson(user)).toList();
      } else {
        throw Exception("Failed to load users");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}
