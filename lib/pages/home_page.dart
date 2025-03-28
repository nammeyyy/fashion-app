import 'package:fashion_app/pages/login_page.dart';
import 'package:fashion_app/service/database_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fashion_app/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String username = "";

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if(username == "") {
      DatabaseUser().getUsername(auth.currentUser!.uid).then((value) => {
        setState(() {
          username = value ?? "guest";
        })
      });
    }
    if (user == null) {
      Future.microtask(() => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage())));
      return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, $username', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF79AEB2),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search fashion trends...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                ),
              ),
            ),

            // Outfit of the Day
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Text(
                'Outfit of the Day',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16.0),
                children: [
                  _buildOutfitCard('assets/images/minimalChic.jpg', 'Minimal Chic'),
                  _buildOutfitCard('assets/images/streetVibes.jpg', 'Street Vibes'),
                  _buildOutfitCard('assets/images/elegantEvening.jpg', 'Elegant Evening'),
                ],
              ),
            ),

            // Lucky Color Table
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Text(
                'Lucky Color of the Day',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildLuckyColorTable(),
            ),
          ],
        ),
      ),
    );
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
              blurRadius: 6, 
              offset: const Offset(2, -4), 
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Image.asset(imagePath, width: 150, height: 200, fit: BoxFit.cover),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.black.withOpacity(0.6),
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLuckyColorTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        columns: const [
          DataColumn(label: Text('Day', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Main Color', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Secondary Color', style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text('Avoid', style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        rows: const [
          DataRow(cells: [DataCell(Text('Monday')), DataCell(Text('Yellow')), DataCell(Text('White')), DataCell(Text('Red'))]),
          DataRow(cells: [DataCell(Text('Tuesday')), DataCell(Text('Pink')), DataCell(Text('Purple')), DataCell(Text('Yellow'))]),
          DataRow(cells: [DataCell(Text('Wednesday')), DataCell(Text('Green')), DataCell(Text('Black')), DataCell(Text('Pink'))]),
          DataRow(cells: [DataCell(Text('Thursday')), DataCell(Text('Orange')), DataCell(Text('Brown')), DataCell(Text('Purple'))]),
          DataRow(cells: [DataCell(Text('Friday')), DataCell(Text('Blue')), DataCell(Text('Pink')), DataCell(Text('Black'))]),
          DataRow(cells: [DataCell(Text('Saturday')), DataCell(Text('Purple')), DataCell(Text('Navy Blue')), DataCell(Text('Green'))]),
          DataRow(cells: [DataCell(Text('Sunday')), DataCell(Text('Red')), DataCell(Text('Green')), DataCell(Text('Blue'))]),
        ],
      ),
    );
  }
}
  


// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   final User? user = FirebaseAuth.instance.currentUser;
  //   final String displayName = user?.displayName ?? 'guess';

  //   if (user == null) {
  //     Future.microtask(() => Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => LoginPage())));
  //     return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
  //   }
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Hi, $displayName', style: TextStyle(fontWeight: FontWeight.bold)),
  //       backgroundColor: const Color(0xFF79AEB2),
  //       elevation: 0,
  //     ),
  //     body: SingleChildScrollView(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           // Search Bar
  //           Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: TextField(
  //               decoration: InputDecoration(
  //                 hintText: 'Search fashion trends...',
  //                 prefixIcon: const Icon(Icons.search, color: Colors.grey),
  //                 filled: true,
  //                 fillColor: Colors.white,
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(25.0),
  //                   borderSide: BorderSide(color: Colors.grey.shade100),
  //                 ),
  //               ),
  //             ),
  //           ),

  //           // Outfit of the Day
  //           const Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
  //             child: Text(
  //               'Outfit of the Day',
  //               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 200,
  //             child: ListView(
  //               scrollDirection: Axis.horizontal,
  //               padding: const EdgeInsets.only(left: 16.0),
  //               children: [
  //                 _buildOutfitCard('assets/images/minimalChic.jpg', 'Minimal Chic'),
  //                 _buildOutfitCard('assets/images/streetVibes.jpg', 'Street Vibes'),
  //                 _buildOutfitCard('assets/images/elegantEvening.jpg', 'Elegant Evening'),
  //               ],
  //             ),
  //           ),

  //           // Lucky Color Table
  //           const Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
  //             child: Text(
  //               'Lucky Color of the Day',
  //               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //             child: _buildLuckyColorTable(),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildOutfitCard(String imagePath, String title) {
  //   return Padding(
  //     padding: const EdgeInsets.only(right: 16.0),
  //     child: Container(
  //       width: 150,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(12),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.3), 
  //             spreadRadius: 2, 
  //             blurRadius: 6, 
  //             offset: const Offset(2, -4), 
  //           ),
  //         ],
  //       ),
  //       child: ClipRRect(
  //         borderRadius: BorderRadius.circular(12),
  //         child: Stack(
  //           children: [
  //             Image.asset(imagePath, width: 150, height: 200, fit: BoxFit.cover),
  //             Positioned(
  //               bottom: 10,
  //               left: 10,
  //               child: Container(
  //                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //                 color: Colors.black.withOpacity(0.6),
  //                 child: Text(
  //                   title,
  //                   style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }



//   Widget _buildLuckyColorTable() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: DataTable(
//         columnSpacing: 20,
//         columns: const [
//           DataColumn(label: Text('Day', style: TextStyle(fontWeight: FontWeight.bold))),
//           DataColumn(label: Text('Main Color', style: TextStyle(fontWeight: FontWeight.bold))),
//           DataColumn(label: Text('Secondary Color', style: TextStyle(fontWeight: FontWeight.bold))),
//           DataColumn(label: Text('Avoid', style: TextStyle(fontWeight: FontWeight.bold))),
//         ],
//         rows: const [
//           DataRow(cells: [DataCell(Text('Monday')), DataCell(Text('Yellow')), DataCell(Text('White')), DataCell(Text('Red'))]),
//           DataRow(cells: [DataCell(Text('Tuesday')), DataCell(Text('Pink')), DataCell(Text('Purple')), DataCell(Text('Yellow'))]),
//           DataRow(cells: [DataCell(Text('Wednesday')), DataCell(Text('Green')), DataCell(Text('Black')), DataCell(Text('Pink'))]),
//           DataRow(cells: [DataCell(Text('Thursday')), DataCell(Text('Orange')), DataCell(Text('Brown')), DataCell(Text('Purple'))]),
//           DataRow(cells: [DataCell(Text('Friday')), DataCell(Text('Blue')), DataCell(Text('Pink')), DataCell(Text('Black'))]),
//           DataRow(cells: [DataCell(Text('Saturday')), DataCell(Text('Purple')), DataCell(Text('Navy Blue')), DataCell(Text('Green'))]),
//           DataRow(cells: [DataCell(Text('Sunday')), DataCell(Text('Red')), DataCell(Text('Green')), DataCell(Text('Blue'))]),
//         ],
//       ),
//     );
//   }
// }
