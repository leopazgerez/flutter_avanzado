import 'package:flutter/material.dart';

import '../pages/chat_page.dart';
import '../pages/log_in_page.dart';
import '../pages/sign_up_page.dart';
import '../pages/splash_page.dart';
import '../pages/user_page.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  'userPage': (_) => const UserPage(),
  'chatPage': (_) => const ChatPage(),
  'logInPage': (_) => const LogInPage(),
  'signUpPage': (_) => const SignUpPage(),
  'splashPage': (_) => const SplashPage(),
};
