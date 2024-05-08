import 'package:cubit_test/features/auth/providers/auth_manager.dart';
import 'package:cubit_test/firebase_options.dart';
import 'package:cubit_test/repositories/providers/tab_manager.dart';
import 'package:cubit_test/router/router.dart';
import 'package:cubit_test/theme/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TabManagerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthManager(),
        ),
      ],
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: router,
          theme: theme,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
