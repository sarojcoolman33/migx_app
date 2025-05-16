import 'package:flutter/material.dart';
import 'migx_home_screen.dart'; // Make sure this file exists

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool autoLogin = false;
  bool invisibleLogin = false;

  void _login() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter username and password")),
      );
      return;
    }

    if (username == "user" && password == "pass") {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Logging in..."),
            ],
          ),
        ),
      );
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MigXHomeScreen()),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Username or password doesn't match")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE082), Color(0xFFFFAB40)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'MigX',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    fillColor: Colors.white,
                    filled: true,
                    border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                    border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: autoLogin,
                      onChanged: (value) {
                        setState(() => autoLogin = value!);
                      },
                    ),
                    const Text('Auto Login', style: TextStyle(color: Colors.white)),
                    const Spacer(),
                    Checkbox(
                      value: invisibleLogin,
                      onChanged: (value) {
                        setState(() => invisibleLogin = value!);
                      },
                    ),
                    const Text('Invisible', style: TextStyle(color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Login', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/signup'),
                      child: const Text('Create New ID',
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline)),
                    ),
                    GestureDetector(
                      onTap: () => _showEmailDialog(),
                      child: const Text('Forgot Password?',
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEmailDialog() {
    // Keep your existing forgot password logic here
  }
}
