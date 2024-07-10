import 'package:flutter/material.dart';
import 'package:flutter_avanzado_app/services/socket_service.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'pages/status_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:  (_)=>SocketService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Band names',
        initialRoute: 'home_page',
        routes: {
          'home_page': (_) => const HomePage(title: 'Soquete'),
          'status_page': (_) => const StatusPage(),
        },
      ),
    );
  }
}
