import 'package:flutter/material.dart';
import 'screens/welcome.dart';
import 'screens/userScreens/dashboard.dart';
import 'screens/ShuttleOwnerScreens/shuttledashboard.dart';
import 'screens/admin/admin_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniShuttle',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AdminDashboardPage(),
    );
  }
}
