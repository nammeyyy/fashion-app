import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/components/customAppbar.dart';
import 'package:fashion_app/model/product.dart';
import 'package:fashion_app/pages/add_product_page.dart';
import 'package:fashion_app/service/database_product.dart';
import 'package:flutter/material.dart';
import 'package:fashion_app/main.dart';
import 'package:fashion_app/pages/home_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedCategory = "Women";
  String selectedFilter = "All";
  final DatabaseProduct _databaseProduct = DatabaseProduct();
  List<Product>_products = [];
  String? _selectedCategory;
  String? _selectedGender;
  String? _selectedFilter;

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
              tabs: const [
                Tab(icon: Icon(Icons.checkroom), text: "Clothes"),
                Tab(icon: Icon(Icons.shopping_bag), text: "Bags"),
                Tab(icon: Icon(Icons.watch), text: "Accessories"),
              ],
              indicatorColor: Color(0xAAAAB8FF),
            ),
            _buildCategoryTabs(),
            _buildFilterTabs(),
            Expanded(child: _buildProduct()),
          ],
        ),
    );
  }
  
  Widget _buildCategoryTabs() {
    return Container(
      color: Color(0xAAF6F4ED),
      child: Row(
        children: [
          _buildCategoryButton("Women"),
          _buildCategoryButton("Men"),
          _buildCategoryButton("Kids"),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String title) {
    bool isActive = title == selectedCategory;
    return TextButton(
      // width: MediaQuery.sizeOf(context).width
      style: TextButton.styleFrom(
        // width: MediaQuery.sizeOf(context).width
        backgroundColor: isActive ? Color(0xFF97C2EC) : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width/3)
      ),
      onPressed: () {
        setState(() {
          selectedCategory = title;
        });
      }, 
      child: Text(title, style: TextStyle(color: isActive ? Colors.white : Color(0xFF97C2EC))),
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
    bool isActive = title == selectedFilter;
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: isActive ? Color(0xFF97C2EC) : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      onPressed: () {
        setState(() {
          selectedFilter = title;
        });
      }, 
      child: Text(title, style: TextStyle(color: isActive ? Colors.white : Color(0xFF97C2EC))),
    );
  }

  Widget _buildProduct() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('products').where('category', isEqualTo: selectedCategory).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if(!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child:  Text("no products"));
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(product["image"]!, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product["productname"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(product["price"]!, style: const TextStyle(color: Colors.blueAccent)),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  } 
}
