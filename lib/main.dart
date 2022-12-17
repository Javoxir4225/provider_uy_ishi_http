import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_uy_ishi_http/counter_view_model.dart';
import 'package:provider_uy_ishi_http/pages/user_name.dart';
import 'package:provider_uy_ishi_http/pages/users.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => CounterViewModel(),
      child: MyUsers(),
        // child: MyUserName(name: "Abdulloh", userId: 1),
      ),
    );
  }
}
