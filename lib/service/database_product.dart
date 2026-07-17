import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/model/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fashion_app/main.dart';

const String PRODUCT_COLLECTION_REF = "Product";

class DatabaseProduct {
  final _firestore = FirebaseFirestore.instanceFor(app: app);
  final _storage = FirebaseStorage.instanceFor(app: app);
  late final CollectionReference _productRef;
  late String imageurl;

  DatabaseProduct() {
    _productRef = _firestore.collection(PRODUCT_COLLECTION_REF).withConverter<Product>(
      fromFirestore: (snapshots,_) => Product.fromJson(snapshots.data()!,
      ), 
      toFirestore: (product,_) => product.toJson());
  }

  Stream<QuerySnapshot> getProduct() {
    return _productRef.snapshots();
  }

  void addProduct(Product product) async {
    _productRef.add(product);
  }

  void updateProduct(String productId, Product product) {
    _productRef.doc(productId).update(product.toJson());
  }

  Future<Product?> getAll(String productId) async {
    try {
      var snapshot = await _productRef.doc(productId).get();
      if (snapshot.exists) {
        var productData = snapshot.data();
        if (productData != null) {
          var product = productData as Product;
          return product;
        }
      }
    } catch (e) {
      print("Error getting productname: $e");
    }
    return null;
  }

  Future<String?> getProductname(String productId) async {
    try {
      var snapshot = await _productRef.doc(productId).get();
      if (snapshot.exists) {
        var productData = snapshot.data();
        if (productData != null) {
          var product = productData as Product;
          return product.getProductname();
        }
      }
    } catch (e) {
      print("Error getting productname: $e");
    }
    return null;
  }

  Future<double?> getPrice(String productId) async {
    try {
      var snapshot = await _productRef.doc(productId).get();
      if (snapshot.exists) {
        var productData = snapshot.data();
        if (productData != null) {
          var product = productData as Product;
          return product.getPrice();
        }
      }
    } catch (e) {
      print("Error getting productname: $e");
    }
    return null;
  }

  Future<String?> getDescription(String productId) async {
    try {
      var snapshot = await _productRef.doc(productId).get();
      if (snapshot.exists) {
        var productData = snapshot.data();
        if (productData != null) {
          var product = productData as Product;
          return product.getDescription();
        }
      }
    } catch (e) {
      print("Error getting productname: $e");
    }
    return null;
  }

  Future<String?> getCategories(String productId) async {
    try {
      var snapshot = await _productRef.doc(productId).get();
      if (snapshot.exists) {
        var productData = snapshot.data();
        if (productData != null) {
          var product = productData as Product;
          return product.getCategories();
        }
      }
    } catch (e) {
      print("Error getting productname: $e");
    }
    return null;
  }

  Future<String?> getImage(String productId) async {
    try {
      var snapshot = await _productRef.doc(productId).get();
      if (snapshot.exists) {
        var productData = snapshot.data();
        if (productData != null) {
          var product = productData as Product;
          return product.getProductImage();
        }
      }
    } catch (e) {
      print("Error getting productname: $e");
    }
    return null;
  }

  Future<String?> getShopLink(String productId) async {
    try {
      var snapshot = await _productRef.doc(productId).get();
      if (snapshot.exists) {
        var productData = snapshot.data();
        if (productData != null) {
          var product = productData as Product;
          return product.getShopLink();
        }
      }
    } catch (e) {
      print("Error getting productname: $e");
    }
    return null;
  }

  Future<String?> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadurl = await snapshot.ref.getDownloadURL();
    return downloadurl;
  }

  Future<List<Product>> fetchProducts({String? category, String? gender, String? filter}) async {
    Query query = _firestore.collection('products');

    // กรองข้อมูลตามตัวเลือก
    if (category != null && category.isNotEmpty) {
      query = query.where('categories', isEqualTo: category);
    }
    if (gender != null && gender.isNotEmpty) {
      query = query.where('gender', isEqualTo: gender);
    }
    if (filter != null && filter.isNotEmpty) {
      query = query.where('filter', isEqualTo: filter);
    }

    QuerySnapshot querySnapshot = await query.get();
    
    return querySnapshot.docs.map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }
}

