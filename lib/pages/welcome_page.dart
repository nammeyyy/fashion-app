import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';

class WelcomePage extends StatelessWidget {
 const WelcomePage({super.key});

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     body: Stack(
       children: [
         // Background Image
         Container(
           decoration: const BoxDecoration(
             image: DecorationImage(
               image: AssetImage('assets/images/welcome.jpeg'),
               fit: BoxFit.cover,
             ),
           ),
         ),
         // Bottom Overlay Box
         Positioned(
           bottom: 0,
           left: 0,
           right: 0,
           child: Container(
             padding: const EdgeInsets.only(
               left: 20,
               right: 30,
               top: 30,
               bottom: 60,
             ),
             decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  const Color(0xff97C2EC),
                  const Color(0xffAAB8FF),
                ],
              ),
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisSize: MainAxisSize.min,
               children: [
                 const Text(
                   'Buy Less, Choose Well,\nMake it last.',
                   style: TextStyle(
                     fontSize: 28,
                     fontWeight: FontWeight.w400,
                     color: Colors.white,
                   ),
                   textAlign: TextAlign.left,
                 ),
                 const SizedBox(height: 30),
                 ElevatedButton(
                   onPressed: () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => const LoginPage(),
                       ),
                     );
                   },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: const Color(0xFFD6D0C2),
                     foregroundColor: Colors.white,
                     minimumSize: const Size(double.infinity, 45),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(24),
                     ),
                   ),
                   child: const Text(
                     'Login',
                     style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                 ),
                 const SizedBox(height: 15),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     TextButton(
                       onPressed: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => const RegisterPage(),
                           ),
                         );
                       },
                       style: TextButton.styleFrom(
                         foregroundColor: Colors.white,
                         padding: const EdgeInsets.symmetric(horizontal: 8),
                       ),
                       child: const Text(
                         'Create account',
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 16,
                           decoration: TextDecoration.underline,
                           decorationColor: Colors.white,
                         ),
                       ),
                     ),
                     const SizedBox(width: 5),
                     InkWell(
                       onTap: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => const RegisterPage(),
                           ),
                         );
                       },
                       child: const Icon(
                         Icons.arrow_forward,
                         color: Colors.white,
                         size: 20,
                       ),
                     ),
                   ],
                 ),
               ],
             ),
           ),
         ),
       ],
     ),
   );
  }
}