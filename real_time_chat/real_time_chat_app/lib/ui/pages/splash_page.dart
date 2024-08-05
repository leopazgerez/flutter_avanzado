import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat_app/ui/pages/log_in_page.dart';
import 'package:real_time_chat_app/ui/pages/user_page.dart';

import '../../services/auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _checkData(context),
          builder: (context, snapshot) =>
              const Center(child: Text('Verificando sesion'))),
    );
  }

  _checkData(context) async {
    final authService = Provider.of<AuthService>(context);
    final result = await authService.checkToken();
    if (result != null) {
      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const UserPage(),));
    } else {
      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const LogInPage(),));
    }
  }
}
