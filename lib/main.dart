import 'package:flutter/material.dart';

import 'package:cinema/config/theme/app_theme.dart';
import 'package:cinema/config/router/app_router.dart';


void main() {
  runApp(const Cinema());
}

class Cinema extends StatelessWidget {
  const Cinema({super.key});
  
  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
  }