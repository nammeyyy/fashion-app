import 'package:flutter/material.dart';

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

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData icon;

  const BasicAppBar({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomAppBarClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFAAB8FF), Color(0xAA97C2EC)]),
        ),
        padding: const EdgeInsets.only(top: 20),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xFFFFFFFF)),
          ),
          leading: 
            IconButton(
              icon: Icon(icon, size: 28, color: Color(0xFFFFFFFF),),
              onPressed: () {
                // 🚀 เมื่อกด Icon ให้ไปยังหน้า targetPage
                Navigator.of(context).pop();
              },
            ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}