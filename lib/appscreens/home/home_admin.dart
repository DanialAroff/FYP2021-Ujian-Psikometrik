import 'package:flutter/material.dart';
import 'package:fyp1/services/auth.dart';
import 'package:fyp1/shared/appcolors.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: AppColors.primary,
      ),
      body: SafeArea(
        right: false,
        left: false,
        minimum: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text('ADMIN', 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await _auth.logOut();
                },
                icon: const Icon(Icons.logout),
                label: const Text('Log Keluar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
