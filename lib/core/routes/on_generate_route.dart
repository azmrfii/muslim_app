// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/cupertino.dart';
import 'package:muslim_app/views/entrypoint/entrypoint_nav.dart';
import 'package:muslim_app/views/home/home_page.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case AppRoutes.entryPoint:
        return CupertinoPageRoute(builder: (_) => const EntryPointNav());

      case AppRoutes.home:
        return CupertinoPageRoute(
            builder: (_) => const HomePage());
    }
  }

}
