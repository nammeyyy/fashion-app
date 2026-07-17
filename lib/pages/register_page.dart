import 'package:fashion_app/controllers/register_controller.dart';
import 'package:fashion_app/service/Auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fashion_app/main.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage = '';
  String noUsername = '';
  String noEmail = '';
  String noPassword = '';
  String wrongInput = '';
  String  passwordMismatch = '';
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;

  final RegisterController _registerController = RegisterController();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerCheckPassword =
      TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();

  Future<void> _register() async {
    if (!mounted) return;
    // Reset all error messages
    setState(() {
      noUsername = '';
      noEmail = '';
      noPassword = '';
      passwordMismatch = '';
      errorMessage = '';
    });

    // Validate inputs
    if (_controllerUsername.text.isEmpty) {
      setState(() => noUsername = "Please input your Username!");
      return;
    }
    if (_controllerEmail.text.isEmpty) {
      setState(() => noEmail = "Please input your Email!");
      return;
    }
    if (_controllerPassword.text.isEmpty) {
      setState(() => noPassword = "Please input your password!");
      return;
    }
    if (_controllerPassword.text != _controllerCheckPassword.text) {
      setState(() => passwordMismatch = "Passwords do not match!");
      return;
    }

    try {
      // Create user in Firebase Auth
      final UserCredential userCredential = 
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _controllerEmail.text.trim(),
            password: _controllerPassword.text.trim()
          );
          userCredential.user?.updateDisplayName(_controllerUsername.text.trim());

      // Add user data to Firestore
      await _registerController.addData(
        _controllerUsername.text.trim(),
        _controllerEmail.text.trim(),
        "",
        userCredential.user!.uid
      );

      // Navigate to home page after successful registration
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
      
      
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() => errorMessage = e.message ?? "Registration failed");
    } catch (e) {
      if (!mounted) return;
      setState(() => errorMessage = "Registration failed. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFAAB8FF),
              Color(0xFF97C2EC),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
            child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _controllerUsername,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: const TextStyle(
                        color: Color(0xFF66A1A9),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _controllerEmail,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                        color: Color(0xFF66A1A9),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _controllerPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                        color: Color(0xFF66A1A9),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _controllerCheckPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: const TextStyle(
                        color: Color(0xFF66A1A9),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: () async {
                      if (_controllerUsername.text == "") {
                        setState(() {
                          noUsername = "Please input your Username!";
                        });
                      } else {
                        setState(() {
                          noUsername = "";
                        });
                      }

                      if (_controllerEmail.text == "") {
                        setState(() {
                          noEmail = "Please input your Email!";
                        });
                      } else {
                        setState(() {
                          noEmail = "";
                        });
                      }

                      if (_controllerPassword.text == "") {
                        setState(() {
                          noPassword = "Please input your password!";
                        });
                      } else if (_controllerEmail.text !=
                          _controllerCheckPassword.text) {
                        setState(() {
                          wrongInput = "Password does not match!";
                        });
                      } else if (_controllerUsername.text != "" &&
                          _controllerEmail.text != "" &&
                          _controllerPassword.text != "") {
                        Navigator.pushNamed(context, '/login');
                      }
                    },
                    child: ElevatedButton(
                      onPressed: () {

                        _register();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC8D9E6),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(120, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 8,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
