import 'package:flutter/material.dart';
import 'package:heal_tether_assignment/providers/user_provider.dart';
import 'package:heal_tether_assignment/services/api_sevices.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(apiService: ApiService()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserListScreen(),
    );
  }
}

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Fetch users when the screen is first loaded
    if (userProvider.users.isEmpty && userProvider.isLoading) {
      userProvider.fetchUsers();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("User List")),
      body: userProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : userProvider.errorMessage != null
              ? Center(child: Text(userProvider.errorMessage!))
              : ListView.builder(
                  itemCount: userProvider.users.length,
                  itemBuilder: (context, index) {
                    final user = userProvider.users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar),
                      ),
                      title: Text(user.name),
                      subtitle: Text(user.email),
                    );
                  },
                ),
    );
  }
}
