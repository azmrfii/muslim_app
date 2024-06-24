import 'package:flutter/material.dart';
import 'package:muslim_app/core/routes/app_routes.dart';
import 'package:muslim_app/core/routes/on_generate_route.dart';
import 'package:muslim_app/core/themes/app_themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoTracking',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme,
      onGenerateRoute: RouteGenerator.onGenerate,
      initialRoute: AppRoutes.entryPoint,
    );
  }
}
