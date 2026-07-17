import 'package:fashion_app/pages/login_page.dart';
import 'package:fashion_app/service/database_user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fashion_app/main.dart';
import 'package:fashion_app/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (username == "") {
      DatabaseUser().getUsername(auth.currentUser!.uid).then((value) => {
            setState(() {
              username = value ?? "guest";
            })
          });
    }
    if (user == null) {
      Future.microtask(() => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage())));
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
        body: Column(children: [
      SizedBox(
        height: 200,
        child: Stack(
          children: [
            ClipPath(
              clipper: CustomAppBarClipper(),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFAAB8FF), Color(0xAA97C2EC)],
                  ),
                ),
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Hi, ${user.displayName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  // enabled: false,
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.grey.shade100),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  onTap: () {
                    final query = _searchController.text.trim();
                    if (query.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(initialQuery: query),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a search query'),
                        ),
                      );
                    }
                  },
                ),
              ),

              // Outfit of the Day
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Outfit of the Day',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 260,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 16.0, top: 10),
                  children: [
                    _buildOutfitCard(
                        'assets/images/minimalChic.jpg', 'Minimal Chic'),
                    _buildOutfitCard(
                        'assets/images/streetVibes.jpg', 'Street Vibes'),
                    _buildOutfitCard(
                        'assets/images/elegantEvening.jpg', 'Elegant Evening'),
                  ],
                ),
              ),

              // Lucky Color Table
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Text(
                  'Match your color',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildColorCarousel(),
              ),
            ],
          ),
        ),
      )
    ]));
  }

  Widget _buildOutfitCard(String imagePath, String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Image.asset(imagePath,
                  width: 150, height: 200, fit: BoxFit.cover),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.black.withOpacity(0.6),
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final PageController _pageController = PageController();
  int _currentPage = 0;

  Widget _buildColorCarousel() {
    final List<Map<String, String>> colorData = [
      {'day': 'Monday', 'main': 'Yellow', 'secondary': 'White', 'avoid': 'Red'},
      {
        'day': 'Tuesday',
        'main': 'Pink',
        'secondary': 'Purple',
        'avoid': 'Yellow'
      },
      {
        'day': '"Wednesday"',
        'main': 'Green',
        'secondary': 'Blue',
        'avoid': 'Black'
      },
      {
        'day': 'Thursday',
        'main': 'Orange',
        'secondary': 'Brown',
        'avoid': 'Purple'
      },
      {
        'day': 'Friday',
        'main': 'Red',
        'secondary': 'Black',
        'avoid': 'Green'
      },
      {
        'day': 'Saturday',
        'main': 'Blue',
        'secondary': 'Green',
        'avoid': 'Orange'
      },
      {
        'day': 'Sunday',
        'main': 'Purple',
        'secondary': 'Yellow',
        'avoid': 'Pink'
      },
    ];

    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: colorData.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(colorData[index]['day']!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 10),
                      Text('Main: ${colorData[index]['main']}'),
                      Text('Secondary: ${colorData[index]['secondary']}'),
                      Text('Avoid: ${colorData[index]['avoid']}'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () => _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('_currentPage', _currentPage));
  }
}

class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 30,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
