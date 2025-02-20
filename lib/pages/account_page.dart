import 'package:flutter/material.dart';
import 'purchase_history_page.dart'; 
import 'favorite_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text(
          'Your Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF79AEB2),
      ),
      body: Container(
        color: const Color(0xFFF5EFE6),
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Profile Image
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Info Container
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  _buildInfoRow('Username'),
                  const Divider(height: 30),
                  _buildInfoRow('Email'),
                  const Divider(height: 30),
                  _buildInfoRow('Password'),
                  const SizedBox(height: 15),
                  // Edit Profile Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit, size: 18, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Text(
                        'Edit profile',
                        style: TextStyle(
                          color: Colors.grey[600],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            // Purchase History and Favorite
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // กำหนด onTap ให้กับปุ่ม Purchase History
                _buildIconButton(
                  Icons.history,
                  'Purchase History',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PurchaseHistoryPage(),
                      ),
                    );
                  },
                ),
                // กำหนด onTap เป็นฟังก์ชันว่างหรือสามารถเพิ่มการทำงานได้ในภายหลัง
                _buildIconButton(
                  Icons.favorite_border,
                  'Favorite',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoritePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, size: 40, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
