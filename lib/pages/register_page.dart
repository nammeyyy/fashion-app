import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xAAB8FF).withOpacity(1),
              Color(0x97C2EC).withOpacity(1),
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
                  const Text('Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                  TextField(
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
                  ElevatedButton(
                    onPressed: () {
                      // Handle registration
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
                ],
              ),
            ),
          ],
        )),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       TextField(
      //         decoration: InputDecoration(
      //           hintText: 'Username',
      //           filled: true,
      //           fillColor: Colors.white,
      //           border: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(25),
      //           ),
      //         ),
      //       ),
      //       const SizedBox(height: 15),
      //       TextField(
      //         decoration: InputDecoration(
      //           hintText: 'Email',
      //           filled: true,
      //           fillColor: Colors.white,
      //           border: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(25),
      //           ),
      //         ),
      //       ),
      //       const SizedBox(height: 15),
      //       TextField(
      //         obscureText: true,
      //         decoration: InputDecoration(
      //           hintText: 'Password',
      //           filled: true,
      //           fillColor: Colors.white,
      //           border: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(25),
      //           ),
      //         ),
      //       ),
      //       const SizedBox(height: 15),
      //       TextField(
      //         obscureText: true,
      //         decoration: InputDecoration(
      //           hintText: 'Confirm Password',
      //           filled: true,
      //           fillColor: Colors.white,
      //           border: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(25),
      //           ),
      //         ),
      //       ),
      //       const SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: () {
      //           // Handle registration
      //           Navigator.pop(context);
      //         },
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: const Color(0xFF66A1A9),
      //           foregroundColor: Colors.white,
      //           minimumSize: const Size(double.infinity, 45),
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(25),
      //           ),
      //         ),
      //         child: const Text(
      //           'Create Account',
      //           style: TextStyle(
      //             fontSize: 20,
      //             fontWeight: FontWeight.w500,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
