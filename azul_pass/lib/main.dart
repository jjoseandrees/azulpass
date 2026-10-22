   import 'package:flutter/material.dart';
   import 'package:flutter_riverpod/flutter_riverpod.dart';
   import 'core/theme/app_theme.dart';
   import 'core/di/injection.dart';
   import 'core/router/app_router.dart';

   void main() {
    WidgetsFlutterBinding.ensureInitialized();
     configureDependencies().then((_) {
       runApp(const AzulPassApp());
     });
   }

   class AzulPassApp extends ConsumerWidget {
     const AzulPassApp({super.key});

     @override
     Widget build(BuildContext context,WidgetRef ref) {
       return ProviderScope(
         child: MaterialApp.router(
           title: 'AzulPass',
           theme: AppTheme.lightTheme, // Aplicamos nuestro tema
           routerConfig: appRouter,
           debugShowCheckedModeBanner: false,
         ),
       );
     }
   }