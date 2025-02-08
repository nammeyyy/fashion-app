import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Account'),
        backgroundColor: const Color(0xFF79AEB2),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/profile.jpeg'),
          ),
          const SizedBox(height: 20),
          ListTile(
            title: const Text('Username'),
            trailing: const Icon(Icons.edit),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('Email'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('Password'),
            onTap: () {},
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.history),
                    onPressed: () {},
                  ),
                  const Text('Purchase History'),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  const Text('Favorite'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}