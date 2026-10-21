   import 'package:flutter/material.dart';
   import 'core/theme/app_theme.dart';

   void main() {
     runApp(const AzulPassApp());
   }

   class AzulPassApp extends StatelessWidget {
     const AzulPassApp({super.key});

     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         title: 'AzulPass',
         theme: AppTheme.lightTheme, // Aplicamos nuestro tema
         home: const Scaffold(
           body: Center(child: Text('AzulPass - Setup Inicial Completado')),
         ),
       );
     }
   }