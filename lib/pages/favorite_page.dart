import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
    const FavoritePage({Key? key}) : super(key: key);
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Favorite Page'),
            ),
            body: Center(
                child: Text('This is the Favorite Page'),
            ),
        );
    }
}