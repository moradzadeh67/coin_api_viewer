import 'package:api/screens/user_profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../data/model/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String title = 'Loading...';
  User? user;
  @override
  initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(child: Center(child: Text('test'))),
    );
  }

  void getData() async {
    var response = await Dio().get(
      'https://rest.coincap'
      '.io/v3/assets?apiKey=0add4468326e999de8747e8ad5ba36063f54004122bc39dc9c404020cf682c92',
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserProfileScreen(user: user)),
    );
  }
}
