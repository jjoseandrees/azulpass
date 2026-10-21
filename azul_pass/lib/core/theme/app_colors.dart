import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Constructor privado para evitar instancias

  // Colores Principales
  static const Color primaryBlue = Color(0xFF0033A0); // Azul U
  static const Color secondaryBlue = Color(0xFF002266); // Azul oscuro para appbar
  static const Color accentGold = Color(0xFFFFD700); // Dorado para detalles/acentos

  // Colores de Fondo y Superficie
  static const Color background = Color(0xFFF5F7FA); // Gris muy clarito
  static const Color surface = Colors.white;
  
  // Colores de Texto
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textOnPrimary = Colors.white;

  // Colores de Estado
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
}