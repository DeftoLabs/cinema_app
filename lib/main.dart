import 'package:flutter/material.dart';

import 'package:cinema/config/router/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:cinema/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future <void> main() async {

  await dotenv.load(fileName: '.env');

  runApp(
    const ProviderScope(child: Cinema())
  );
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