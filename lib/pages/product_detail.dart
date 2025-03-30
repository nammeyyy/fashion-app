import 'package:fashion_app/components/AppBar.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

class ProductDetailPage extends StatelessWidget {
  final String productName;
  final String shopLink;
  final double price;
  final String description;
  final String imagePath;

  const ProductDetailPage({
    Key? key,
    required this.productName,
    required this.shopLink,
    required this.price,
    required this.description,
    required this.imagePath
  }) : super(key: key);

  // ฟังก์ชันเปิดลิงก์ร้านค้า
//   void _launchURL() async {
//     final Uri url = Uri.parse(shopLink);
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url, mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint("ไม่สามารถเปิดลิงก์ได้: $shopLink");
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: "Detail", icon: Icons.arrow_back,),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 70,
          right: 50,
          left: 50,

        ),
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                child: SizedBox(
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          imagePath,
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Icon(Icons.image_not_supported, size: 100, color: Colors.grey));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productName,
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF97C2EC)),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "ราคา: ${price.toStringAsFixed(2)}฿",
                              style: const TextStyle(fontSize: 18, color: Colors.lightGreen),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "รายละเอียดสินค้า:",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF97C2EC)),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              description,
                              style: const TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "ลิงค์ร้านค้า:",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF97C2EC)),
                            ),
                            Text(
                              shopLink,
                              style: const TextStyle(fontSize: 16, color: Colors.grey, decoration: TextDecoration.underline, decorationColor: Colors.grey),
                            ),
                            // Center(
                            //   child: ElevatedButton.icon(
                            //     onPressed: _launchURL,
                            //     icon: const Icon(Icons.shopping_cart),
                            //     label: const Text("ไปที่ร้านค้า"),
                            //     style: ElevatedButton.styleFrom(
                            //       backgroundColor: Colors.blueAccent,
                            //       foregroundColor: Colors.white,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
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