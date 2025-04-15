import 'package:flutter/material.dart';
import 'main_navigation.dart'; 
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Hidratação',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainNavigation(), 
      debugShowCheckedModeBanner: false,
    );
  }
}
