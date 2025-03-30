import 'dart:convert';
import 'dart:io';

import 'package:fashion_app/components/AppBar.dart';
import 'package:fashion_app/controllers/addProduct_controller.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String? errorMessage = '';
  String noProductname = '';
  String noPrice = '';
  String noDescription = '';
  String noShoplink = '';
  String noCategories = '';
  String noGender = '';
  String noFilter = '';

  final TextEditingController _controllerProductname = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerShoplink = TextEditingController();
  String? _selectedCategories;
  String? _selectedGender;
  String? _selectedFilter;
  // final TextEditingController _controllerCategories = TextEditingController();
  // final TextEditingController _controllerGender = TextEditingController();
  // final TextEditingController _controllerFilter = TextEditingController();

  final List<String> _categories = ["CLothes", "Bags", "Accessories"];
  final List<String> _gender = ["Women", "Men", "Kid"];
  final List<String> _filter = ["All", "Trending", "Shirt", "Pants", "Dress"]; 

  Future<void> _addproduct() async {
    if(!mounted) return;

    setState(() {
      noProductname = '';
      noPrice = '';
      noDescription = '';
      noShoplink = '';
      noCategories = '';
      noGender = '';
      noFilter = '';
    });

    if (_controllerProductname.text.isEmpty) {
      setState(() => noProductname = "Please fill product name");
      return;
    }
    if (_controllerPrice.text.isEmpty) {
      setState(() => noPrice = "Please fill product price");
      return;
    }
    if (_controllerDescription.text.isEmpty) {
      setState(() => noDescription = "Please fill product description");
      return;
    }
    if (_controllerShoplink.text.isEmpty) {
      setState(() => noShoplink = "Please fill product shop link");
      return;
    }
    if (_selectedCategories == null) {
      setState(() => noCategories = "Please select product category");
      return;
    }
    if(_selectedGender == null) {
      setState(() => noGender = "Please select gender for product");
      return;
    }
    if(_selectedFilter == null) {
      setState(() => noFilter = "Please select filter for product");
      return;
    }

    try {
      double price = double.parse(_controllerPrice.text.trim());

      await FirebaseFirestore.instance.collection('products').add({
        'productName': _controllerProductname.text.trim(),
        'price': price,
        'description': _controllerDescription.text.trim(),
        'shoplink': _controllerShoplink.text.trim(),
        'categories': _selectedCategories,
        'gender': _selectedGender,
        'filter': _selectedFilter,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added successfully')),
      );

      _controllerProductname.clear();
      _controllerPrice.clear();
      _controllerDescription.clear();
      _controllerShoplink.clear;
      setState(() {
        _selectedCategories = null;
        _selectedGender = null;
        _selectedFilter = null;
      });
    } catch (e) {
      print("Failed to add product: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add product: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: 'Add Product', icon: Icons.arrow_back,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                // _image != null
                //     ? Image.file(_image!, height: 150)
                    Icon(Icons.image, size: 160, color: Colors.grey),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF97C2EC)),
                  onPressed: _addproduct,
                  child: Text("Upload Image", style: TextStyle(color: Color(0xFFFFFFFF)),),
                ),
                TextFormField(
                  controller: _controllerProductname,
                  decoration: InputDecoration(labelText: "product name"),
                  validator: (value) => value!.isEmpty ? "please enter product name!" : null,
                ),
                TextFormField(
                  controller: _controllerPrice,
                  decoration: InputDecoration(labelText: "price"),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? "please enter product price" : null,
                ),
                TextFormField(
                  controller: _controllerDescription,
                  decoration: InputDecoration(labelText: "description"),
                  validator: (value) => value!.isEmpty ? "please enter shop link" : null,
                  // validator: (value) => value!.isEmpty ? "please" : null,
                ),
                TextFormField(
                  controller: _controllerShoplink,
                  decoration: InputDecoration(labelText: "Shop link"),
                  validator: (value) => value!.isEmpty ? "please enter shop link" : null,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "categories"),
                  value: _selectedCategories,
                  items: _categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (value) => setState(() => _selectedCategories = value),
                  validator: (value) => value == null ? "please select category" : null,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "gender"),
                  value: _selectedGender,
                  items: _gender.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (value) => setState(() => _selectedGender = value),
                  validator: (value) => value == null ? "please select gender for product" : null,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "filter"),
                  value: _selectedFilter,
                  items: _filter.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (value) => setState(() => _selectedFilter = value),
                  validator: (value) => value == null ? "please select the product filter" : null,
                ),
                // SizedBox(height: 20),
                // _image != null
                //     ? Image.file(_image!, height: 150)
                //     : Icon(Icons.image, size: 100, color: Colors.grey),
                // ElevatedButton(
                //   onPressed: pickAndUploadImage,
                //   child: Text("เลือกและอัปโหลดรูป"),
                // ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF97C2EC)),
                  onPressed: _addproduct,
                  child: Text("Add product", style: TextStyle(color: Color(0xFFFFFFFF),),
                ), 
              ),
              ],
            ),
          ),
        ),
      );
  }
}

// class AddProductPage extends StatefulWidget {

//   @override
//   _AddProductPageState createState() => _AddProductPageState();
// }

// class _AddProductPageState extends State<AddProductPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _descController = TextEditingController();
//   final TextEditingController _shopLinkController = TextEditingController();

//   String? _selectedCategory;
//   String? _selectedGender;
//   String? _selectedFilter;
//   File? _image;

//   final picker = ImagePicker();
//   final List<String> _categories = ["Cloths", "Bags", "Accessories"];
//   final List<String> _genders = ["Women", "Men", "Kid"];
//   final List<String> _filters = ["All", "Trending", "Shirt", "Pant", "Dress"];

//   // ฟังก์ชันเลือกและอัปโหลดรูป
//   Future<void> pickImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() => _image = File(pickedFile.path));

//       // try {
//       //   String fileName = "products/${DateTime.now().millisecondsSinceEpoch}.jpg";
//       //   Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
//       //   UploadTask uploadTask = storageRef.putFile(_image!);
//       //   TaskSnapshot snapshot = await uploadTask;
//       //   String downloadURL = await snapshot.ref.getDownloadURL();

//       //   setState(() => _imageURL = downloadURL);
//       //   print("Upload successfully: $_imageURL");
//       // } catch (e) {
//       //   print("Upload image failed: $e");
//       // }
//     }
//   }

//   // ฟังก์ชันบันทึกข้อมูลสินค้า
//   Future<void> saveProduct() async {
//     if (!_formKey.currentState!.validate()) return;

//     String? imageBase64;
//     if(_image != null) {
//       List<int> imageBytes = await _image!.readAsBytes();
//       imageBase64 = base64Encode(imageBytes);
//     }

//     double? price = double.tryParse(_priceController.text.trim());
//     if(price == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('please enter the valid product price')));
//     }
//       try {
//         await FirebaseFirestore.instance.collection('products').add({
//           'productName': _nameController.text.trim(),
//           'price': price,
//           'description': _descController.text.trim(),
//           'linkShop': _shopLinkController.text.trim(),
//           'productmage': imageBase64,
//           'categories': _selectedCategory,
//           'gender': _selectedGender,
//           'filter': _selectedFilter,
//           'created_at': FieldValue.serverTimestamp(),

//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Save successfully')));

//         // _formKey.currentState!.reset();
//         // setState(() {
//         //   _image = null;
//         //   _selectedCategory = null;
//         //   _selectedGender = null;
//         //   _selectedFilter = null;
//         // });

//         print("save successfully!");
//       } catch (e) {
//         print("Failed to save!: $e");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to save $e')));
//       }
//     }
    
  //     @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: BasicAppBar(
  //       title: 'Add Product', icon: Icons.arrow_back,),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Form(
  //         key: _formKey,
  //         child: SingleChildScrollView(
  //           child: Column(
  //             children: [
  //               SizedBox(height: 20),
  //               _image != null
  //                   ? Image.file(_image!, height: 150)
  //                   : Icon(Icons.image, size: 160, color: Colors.grey),
  //               ElevatedButton(
  //                 style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF97C2EC)),
  //                 onPressed: pickImage,
  //                 child: Text("Upload Image", style: TextStyle(color: Color(0xFFFFFFFF)),),
  //               ),
  //               TextFormField(
  //                 controller: _nameController,
  //                 decoration: InputDecoration(labelText: "product name"),
  //                 validator: (value) => value!.isEmpty ? "please enter product name!" : null,
  //               ),
  //               TextFormField(
  //                 controller: _priceController,
  //                 decoration: InputDecoration(labelText: "price"),
  //                 keyboardType: TextInputType.number,
  //                 validator: (value) => value!.isEmpty ? "please enter product price" : null,
  //               ),
  //               TextFormField(
  //                 controller: _descController,
  //                 decoration: InputDecoration(labelText: "description"),
  //                 validator: (value) => value!.isEmpty ? "please enter shop link" : null,
  //                 // validator: (value) => value!.isEmpty ? "please" : null,
  //               ),
  //               TextFormField(
  //                 controller: _shopLinkController,
  //                 decoration: InputDecoration(labelText: "Shop link"),
  //                 validator: (value) => value!.isEmpty ? "please enter shop link" : null,
  //               ),
  //               DropdownButtonFormField<String>(
  //                 decoration: InputDecoration(labelText: "categories"),
  //                 value: _selectedCategory,
  //                 items: _categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
  //                 onChanged: (value) => setState(() => _selectedCategory = value),
  //                 validator: (value) => value == null ? "please select category" : null,
  //               ),
  //               DropdownButtonFormField<String>(
  //                 decoration: InputDecoration(labelText: "gender"),
  //                 value: _selectedGender,
  //                 items: _genders.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
  //                 onChanged: (value) => setState(() => _selectedGender = value),
  //                 validator: (value) => value == null ? "please select gender for product" : null,
  //               ),
  //               DropdownButtonFormField<String>(
  //                 decoration: InputDecoration(labelText: "filter"),
  //                 value: _selectedFilter,
  //                 items: _filters.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
  //                 onChanged: (value) => setState(() => _selectedFilter = value),
  //                 validator: (value) => value == null ? "please select the product filter" : null,
  //               ),
  //               // SizedBox(height: 20),
  //               // _image != null
  //               //     ? Image.file(_image!, height: 150)
  //               //     : Icon(Icons.image, size: 100, color: Colors.grey),
  //               // ElevatedButton(
  //               //   onPressed: pickAndUploadImage,
  //               //   child: Text("เลือกและอัปโหลดรูป"),
  //               // ),
  //               SizedBox(height: 20),
  //               ElevatedButton(
  //                 style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF97C2EC)),
  //                 onPressed: saveProduct,
  //                 child: Text("Add product", style: TextStyle(color: Color(0xFFFFFFFF),),
  //               ), 
  //             ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: BasicAppBar(
//         title: 'Add Product', icon: Icons.arrow_back,),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(height: 20),
//                 _image != null
//                     ? Image.file(_image!, height: 150)
//                     : Icon(Icons.image, size: 160, color: Colors.grey),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF97C2EC)),
//                   onPressed: pickAndUploadImage,
//                   child: Text("Upload Image", style: TextStyle(color: Color(0xFFFFFFFF)),),
//                 ),
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: InputDecoration(labelText: "product name"),
//                   validator: (value) => value!.isEmpty ? "please enter product name!" : null,
//                 ),
//                 TextFormField(
//                   controller: _priceController,
//                   decoration: InputDecoration(labelText: "price"),
//                   keyboardType: TextInputType.number,
//                   validator: (value) => value!.isEmpty ? "please enter product price" : null,
//                 ),
//                 TextFormField(
//                   controller: _descController,
//                   decoration: InputDecoration(labelText: "description")
//                   // validator: (value) => value!.isEmpty ? "please" : null,
//                 ),
//                 TextFormField(
//                   controller: _shopLinkController,
//                   decoration: InputDecoration(labelText: "Shop link"),
//                   validator: (value) => value!.isEmpty ? "please enter shop link" : null,
//                 ),
//                 DropdownButtonFormField<String>(
//                   decoration: InputDecoration(labelText: "categories"),
//                   value: _selectedCategory,
//                   items: _categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//                   onChanged: (value) => setState(() => _selectedCategory = value),
//                   validator: (value) => value == null ? "please select category" : null,
//                 ),
//                 DropdownButtonFormField<String>(
//                   decoration: InputDecoration(labelText: "gender"),
//                   value: _selectedGender,
//                   items: _genders.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//                   onChanged: (value) => setState(() => _selectedGender = value),
//                   validator: (value) => value == null ? "please select gender for product" : null,
//                 ),
//                 DropdownButtonFormField<String>(
//                   decoration: InputDecoration(labelText: "filter"),
//                   value: _selectedFilter,
//                   items: _filters.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//                   onChanged: (value) => setState(() => _selectedFilter = value),
//                   validator: (value) => value == null ? "please select the product filter" : null,
//                 ),
//                 // SizedBox(height: 20),
//                 // _image != null
//                 //     ? Image.file(_image!, height: 150)
//                 //     : Icon(Icons.image, size: 100, color: Colors.grey),
//                 // ElevatedButton(
//                 //   onPressed: pickAndUploadImage,
//                 //   child: Text("เลือกและอัปโหลดรูป"),
//                 // ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF97C2EC)),
//                   onPressed: saveProduct,
//                   child: Text("Add product", style: TextStyle(color: Color(0xFFFFFFFF),),
//                 ), 
//               ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// class AddProductPage extends StatelessWidget {
//   const AddProductPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: BasicAppBar(
//         title: 'Add Product', icon: Icons.arrow_back,),
//         body: Column(
//           children: [
            
//           ],
//         ),
//     );
//   }
// }