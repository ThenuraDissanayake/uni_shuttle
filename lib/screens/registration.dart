import 'package:flutter/material.dart';
// Import the dashboard screens
import 'dashboard.dart'; // For passenger dashboard
import 'shuttledashboard.dart'; // For shuttle owner dashboard

class DynamicRegistrationScreen extends StatefulWidget {
  const DynamicRegistrationScreen({super.key});

  @override
  _DynamicRegistrationScreenState createState() => _DynamicRegistrationScreenState();
}

class _DynamicRegistrationScreenState extends State<DynamicRegistrationScreen> {
  String? _selectedRole; // To store the selected role
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Bus icon and UniShuttle text
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.directions_bus,
                    color: Colors.green,
                    size: 50,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'UniShuttle',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Role Dropdown
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: DropdownButton<String>(
                  value: _selectedRole,
                  hint: const Text(
                    'Select Role',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: Color.fromARGB(255, 48, 225, 130),
                  ),
                  dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                  items: <String>['Passenger', 'Shuttle Owner']
                      .map((String role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role, style: const TextStyle(fontSize: 18, color: Colors.black)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRole = newValue;
                    });
                  },
                ),
              ),

              // Name field
              TextFormField(
                controller: _nameController,
                enabled: _selectedRole != null, // Disable field if role not selected
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: (value) {
                  if (_selectedRole != null && (value == null || value.isEmpty)) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Email field
              TextFormField(
                controller: _emailController,
                enabled: _selectedRole != null, // Disable field if role not selected
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: (value) {
                  if (_selectedRole != null) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Password field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                enabled: _selectedRole != null, // Disable field if role not selected
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: (value) {
                  if (_selectedRole != null && (value == null || value.isEmpty)) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Confirm Password field
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                enabled: _selectedRole != null, // Disable field if role not selected
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: (value) {
                  if (_selectedRole != null && value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Register button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Check if the selected role is 'Passenger'
                    if (_selectedRole == 'Passenger') {
                      // Navigate to DashboardScreen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardScreen(),
                        ),
                      );
                    } else if (_selectedRole == 'Shuttle Owner') {
                      // Navigate to ShuttleDashboardScreen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShuttleDashboard(), // Change to ShuttleDashboardScreen
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 80),

              // Google Account Login button (now styled in blue)
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Add Google Account Login functionality here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logging in with Google')),
                  );
                },
                icon: const Icon(Icons.account_circle, color: Colors.white),
                label: const Text(
                  'Continue with Google',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Google login button color
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
