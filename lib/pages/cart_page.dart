import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/components/customAppbar.dart';
import 'package:fashion_app/model/product.dart';
import 'package:fashion_app/pages/add_product_page.dart';
import 'package:fashion_app/pages/product_detail.dart';
import 'package:fashion_app/service/database_product.dart';
import 'package:flutter/material.dart';
import 'package:fashion_app/main.dart';
import 'package:fashion_app/pages/home_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  get selectedCategory => null;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // String selectedCategory = "Women";
  // String selectedFilter = "All";
  final DatabaseProduct _databaseProduct = DatabaseProduct();
  List<Product> _products = [];
  String? _selectedCategory = "Clothes";
  String? _selectedGender = "Women";
  String? _selectedFilter = "All";

  Future<void> loadProducts() async {
    List<Product> products = await _databaseProduct.fetchProducts(
      category: _selectedCategory,
      gender: _selectedGender,
      filter: _selectedFilter,
    );
    setState(() {
      _products = products;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    loadProducts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
          title: 'Clothes Shop', icon: Icons.add, targetPage: AddProductPage()),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Color(0xFF97C2EC),
            unselectedLabelColor: Color(0xFFD6D0C2),
            onTap: (index) {
              // ตรวจสอบแท็บที่ถูกเลือก
              if (index == 0) {
                _selectedCategory = "Clothes";
                print("_selectedCategory: $_selectedCategory");
              } else if (index == 1) {
                _selectedCategory = "Bags";
                print("_selectedCategory: $_selectedCategory");
              } else if (index == 2) {
                _selectedCategory = "Accessories";
                print("_selectedCategory: $_selectedCategory");
              }
            },
            tabs: const [
              Tab(icon: Icon(Icons.checkroom), text: "Clothes"),
              Tab(icon: Icon(Icons.shopping_bag), text: "Bags"),
              Tab(icon: Icon(Icons.watch), text: "Accessories"),
            ],
            indicatorColor: Color(0xAAAAB8FF),
          ),
          _buildGenderTabs(),
          _buildFilterTabs(),
          Expanded(child: _buildProduct()),
        ],
      ),
    );
  }

  Widget _buildGenderTabs() {
    return Container(
      color: Color(0xAAF6F4ED),
      child: Row(
        children: [
          _buildGenderButton("Women"),
          _buildGenderButton("Men"),
          _buildGenderButton("Kid"),
        ],
      ),
    );
  }

  Widget _buildGenderButton(String title) {
    bool isActive = title == _selectedGender;
    void _setGender(String title) {
      setState(() {
        _selectedGender = title;
      });
      print("_selectedGender: $_selectedGender");
    }

    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: isActive ? Color(0xFF97C2EC) : Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width / 3)),
      onPressed: () {
        _setGender(title);
      },
      child: Text(title,
          style: TextStyle(color: isActive ? Colors.white : Color(0xFF97C2EC))),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      color: Color(0xFFFFFFFF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFilterButton("All"),
          _buildFilterButton("Trending"),
          _buildFilterButton("Shirt"),
          _buildFilterButton("Pants"),
          _buildFilterButton("Dress"),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String title) {
    bool isActive = title == _selectedFilter;
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: isActive ? Color(0xFF97C2EC) : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      onPressed: () {
        setState(() {
          _selectedFilter = title;
        });
        print("_selectFilter: $_selectedFilter");
      },
      child: Text(title,
          style: TextStyle(color: isActive ? Colors.white : Color(0xFF97C2EC))),
    );
  }

  Widget _buildProduct() {
    late Stream<QuerySnapshot> fetch;
    if(_selectedFilter=="All" || _selectedFilter=="Trending") {
      fetch = FirebaseFirestore.instance
            .collection('products')
            .where('categories', isEqualTo: _selectedCategory)
            .where('gender', isEqualTo: _selectedGender)
            .snapshots();
    } else {
      fetch = FirebaseFirestore.instance
          .collection('products')
          .where('categories', isEqualTo: _selectedCategory)
          .where('filter', isEqualTo: _selectedFilter)
          .where('gender', isEqualTo: _selectedGender)
          .snapshots();
    }
      
    return StreamBuilder<QuerySnapshot>(
      stream: fetch,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("no products"));
        }

        List<DocumentSnapshot> products = snapshot.data!.docs;

        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return _buildProductCard(products[index]);
          },
        );
      },
    );
  }

  Widget _buildProductCard(DocumentSnapshot product) {
    Map<String, dynamic> data = product.data() as Map<String, dynamic>;
    String categories = data["categories"].toString().toLowerCase();
    String filter = data["filter"].toString().toLowerCase();
    String gender = data["gender"].toString().toLowerCase();

    // print("_selectedCategory: $_selectedCategory");
    // print("_selectedFilter: $_selectedFilter");
    // print("_selectedGender: $_selectedGender");
    
    print("Data: ${data["productName"]}, $categories, $filter, $gender");

    late String imagePath;
    if(categories=="clothes"){
      // if(gender=="men"&&filter=="dress")
      //   imagePath = "assets/images/$gender/$categories/shirt/$gender-shirt.jpg";

      if(filter=="all"||filter=="trending")
      //แสดง shirt ของ gender นั้นๆ
        imagePath = "assets/images/$gender/$categories/shirt/$gender-shirt.jpg";

      imagePath = "assets/images/$gender/$categories/$filter/$gender-$filter.jpg";
    } else {
      imagePath = "assets/images/$gender/$categories/$gender-$categories.jpg";
    }

    print("Shop Link: ${data["shoplink"]}");
    print("Description: ${data["description"]}");

    print("Image Path: $imagePath");

    // String imagePath = "/assets/images/$gender/$categories"

    return GestureDetector(
      onTap: () {
              Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              productName: data["productName"],
              shopLink: data["shoplink"],
              price: data["price"],
              description: data["description"],
              imagePath: imagePath
            ),
          ),
        );
            },
      child: Card(
        color: Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 200,
                maxWidth: double.infinity,
              ),
              child: Image.asset(
                imagePath,
                // "assets/images/women/clothes/dress/dress.jpg",
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                product["productName"] ?? "No name",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF97C2EC)),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("\$${data["price"]?.toString() ?? "0.00"}",
                  style: const TextStyle(color: Colors.blueAccent)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
