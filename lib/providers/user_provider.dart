import 'package:flutter/material.dart';
import 'package:heal_tether_assignment/models/user.dart';
import 'package:heal_tether_assignment/services/api_sevices.dart';

class UserProvider extends ChangeNotifier {
  final ApiService apiService;

  UserProvider({required this.apiService});

  List<User> users = [];
  bool isLoading = true;
  String? errorMessage;

  Future<void> fetchUsers() async {
    try {
      isLoading = true;
      notifyListeners();

      users = await apiService.fetchUsers();
      isLoading = false;
      errorMessage = null;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
