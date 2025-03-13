import 'package:flutter/material.dart';

class PurchaseHistoryPage extends StatelessWidget {
  const PurchaseHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> purchaseItems = [
      {"image": "assets/images/dress.jpg", "title": "Outfit 1", "price": "฿1000"},
      {"image": "assets/images/dress.jpg", "title": "Outfit 2", "price": "฿2000"},
      {"image": "assets/images/dress.jpg", "title": "Outfit 3", "price": "฿3000"},
      {"image": "assets/images/dress.jpg", "title": "Outfit 4", "price": "฿1500"},
      {"image": "assets/images/dress.jpg", "title": "Outfit 1", "price": "฿1000"},
      {"image": "assets/images/dress.jpg", "title": "Outfit 2", "price": "฿2000"},
      {"image": "assets/images/dress.jpg", "title": "Outfit 3", "price": "฿3000"},
      {"image": "assets/images/dress.jpg", "title": "Outfit 4", "price": "฿1500"},
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Purchase History'),
        backgroundColor: const Color(0xFF79AEB2),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFFF5EFE6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIconButton(Icons.history, 'History', () {
                  debugPrint('Purchase History Clicked');
                }),
                _buildIconButton(Icons.favorite_border, 'Favorites', () {
                  debugPrint('Favorite Clicked');
                }),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // GridView สำหรับแสดงสินค้าที่ซื้อ
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 คอลัมน์
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8, // ปรับสัดส่วนของการ์ดสินค้า
                ),
                itemCount: purchaseItems.length,
                itemBuilder: (context, index) {
                  final item = purchaseItems[index];
                  return _buildProductCard(
                    imagePath: item["image"]!,
                    title: item["title"]!,
                    price: item["price"]!,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget สำหรับสร้างไอคอนปุ่ม
  Widget _buildIconButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 30, color: Colors.grey[600]),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Widget สำหรับแสดงสินค้าในรูปแบบ Card
  Widget _buildProductCard({required String imagePath, required String title, required String price}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  price,
                  style: const TextStyle(fontSize: 14, color: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
