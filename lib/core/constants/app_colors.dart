import 'package:flutter/material.dart';

abstract class AppColors {
  // Fondos principales
  static const Color background = Color(0xFF0B0C10); // Negro azabache suave
  static const Color surface = Color(0xFF1F2833);    // Tarjetas y modales oscuros
  static const Color surfaceLight = Color(0xFF2C3540); // Superficie destacada

  // Colores de acento (Efecto Nox/Nocturno)
  static const Color primary = Color(0xFF6C5CE7);     // Violeta nocturno
  static const Color secondary = Color(0xFF00CEC9);   // Cían / Neón suave
  static const Color accent = Color(0xFFA29BFE);      // Lavanda

  // Textos
  static const Color textPrimary = Color(0xFFEAEAEA);   // Blanco roto (no cansa la vista)
  static const Color textSecondary = Color(0xFFA0AAB5); // Gris medio
  static const Color textMuted = Color(0xFF626D7A);     // Gris oscuro

  // Estados
  static const Color error = Color(0xFFFF7675);
  static const Color success = Color(0xFF55E6C1);
}