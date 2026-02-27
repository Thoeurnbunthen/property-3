import 'package:flutter/material.dart';
import 'package:property_then/app/providers/profile_provider.dart';
import 'package:provider/provider.dart';
import 'app/providers/auth_provider.dart';
import 'routes/app_routes.dart';
import 'app/providers/favorite_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MaterialApp(
        title: 'Property App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'SF Pro Display',
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A1A2E)),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
      ),
    );
  }
}
