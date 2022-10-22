import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return const ListTile(
            leading: Icon(Icons.flutter_dash),
            title: Text("Title Title"),
            subtitle: Text("Subitle subtitle subtitle subtitle subtitle"),
          );
        },
      ),
    );
  }
}
