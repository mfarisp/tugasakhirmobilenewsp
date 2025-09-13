import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_002/firebase_option.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
); // Inisialisasi Firebase
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: '3D Asset Store',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const HomeScreen(), // layar pertama adalah login
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

