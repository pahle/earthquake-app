import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tugas_akhir/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login Page',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 25),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                ),
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                ),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => _login(context),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  _login(BuildContext context) async {
    // Replace 'your_secret_key' with your secret key for encryption
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Combine username and password for a unique identifier
    final combinedData = '$username:$password';

    // Encrypt the combined data using SHA-256
    final hashedData = sha256.convert(utf8.encode(combinedData)).toString();

    // Check if the hashed data matches the expected value
    if (hashedData == 'ca4d6d1d8ed7ea05a0fb3c83aee9e7ff8a686f38682e582c42be050efe85c2e2') {
      // Store a token or flag indicating the user is logged in (for simplicity, not secure)
      await const FlutterSecureStorage().write(key: 'is_logged_in', value: 'true');

      print(hashedData);

      // Navigate to the report page
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const Home(title: 'Earthquake App',)),
      );
    } else {
      // Show an error message if the login fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username or password'),
        ),
      );
    }
  }
}
