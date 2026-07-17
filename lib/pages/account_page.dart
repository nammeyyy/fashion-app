import 'package:fashion_app/components/AppBar.dart';
import 'package:fashion_app/components/customAppbar.dart';
import 'package:fashion_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'purchase_history_page.dart'; 
import 'favorite_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fashion_app/service/database_user.dart';
import 'package:fashion_app/controllers/register_controller.dart';
import 'package:fashion_app/model/user.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String username = "";
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        title: 'Account', icon: Icons.logout, targetPage: LoginPage()),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assetName',),
              ),
            ),
            const SizedBox(height: 30),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              padding: const EdgeInsets.all(20),
              decoration:  BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xAAAAB8FF).withOpacity(0.8),
                  Color(0xAA97C2EC).withOpacity(0.8)]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Username", style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 5),
                  const Text("Email", style: TextStyle(fontSize: 16, color: Colors.white)),
                  const SizedBox(height: 5),
                  const Text("Password", style: TextStyle(fontSize: 16, color: Colors.white)),

                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: () {

                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const Icon(Icons.edit, size: 16),
                        const SizedBox(width: 300),
                        Text("Edit profile", style: TextStyle(color: Colors.blue.shade800, 
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue.shade800)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(Icons.save, "save"),
                const SizedBox(width: 30),
                _buildActionButton(Icons.favorite, "Favorite"),
              ],
            )
          ],
        ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xAAAAB8FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 24, color: Colors.white,),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFAAB8FF))),
      ],
    );
  }
}

// class AccountPage extends StatelessWidget {
//   const AccountPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const Icon(Icons.arrow_back),
//         title: const Text(
//           'Your Account',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//           ),
//         ),
//         backgroundColor: const Color(0xFF79AEB2),
//       ),
//       body: Container(
//         color: const Color(0xFFF5EFE6),
//         child: Column(
//           children: [
//             const SizedBox(height: 30),
//             // Profile Image
//             Center(
//               child: Container(
//                 width: 100,
//                 height: 100,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/profile.jpeg'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             // Info Container
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 20),
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Column(
//                 children: [
//                   _buildInfoRow('Username'),
//                   const Divider(height: 30),
//                   _buildInfoRow('Email'),
//                   const Divider(height: 30),
//                   _buildInfoRow('Password'),
//                   const SizedBox(height: 15),
//                   // Edit Profile Button
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.edit, size: 18, color: Colors.grey[600]),
//                       const SizedBox(width: 8),
//                       Text(
//                         'Edit profile',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 60),
//             // Purchase History and Favorite
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 // กำหนด onTap ให้กับปุ่ม Purchase History
//                 _buildIconButton(
//                   Icons.history,
//                   'Purchase History',
//                   () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const PurchaseHistoryPage(),
//                       ),
//                     );
//                   },
//                 ),
//                 // กำหนด onTap เป็นฟังก์ชันว่างหรือสามารถเพิ่มการทำงานได้ในภายหลัง
//                 _buildIconButton(
//                   Icons.favorite_border,
//                   'Favorite',
//                   () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const FavoritePage(),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String title) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Text(
//         title,
//         textAlign: TextAlign.center,
//         style: const TextStyle(
//           fontSize: 16,
//           color: Colors.black87,
//         ),
//       ),
//     );
//   }

//   Widget _buildIconButton(IconData icon, String label, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Container(
//             width: 70,
//             height: 70,
//             padding: const EdgeInsets.all(15),
//             decoration: BoxDecoration(
//               color: Colors.grey,
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Icon(icon, size: 40, color: Colors.grey[600]),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             label,
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
