import 'package:cloud_firestore/cloud_firestore.dart';

class ProductController {
  final CollectionReference _productCollection = 
      FirebaseFirestore.instance.collection('products');

  Future<void> addData(String productname, double price, String description, String shoplink, String image, String categories,String gender, String filter) async {
    try {
      await _productCollection.doc().set({
        "productname": productname,
        "price": price,
        "description": description,
        "shoplink": shoplink,
        "productImage": image,
        "categories": categories,
        "gender": gender,
        "filter": filter,
        "createdAt": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error adding product data: $e");
      rethrow;
    }
  }
}