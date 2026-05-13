import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'screens/dashboard.dart'; // IMPORTANTE: Importar o Dashboard

void main() {
  // Define o padrão de moeda para o Brasil globalmente
  Intl.defaultLocale = 'pt_BR';
  runApp(const BankApp());
}

class BankApp extends StatelessWidget {
  const BankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa de debug
      
      // ALTERAÇÃO AQUI: Agora o app começa pelo Dashboard
      home: const Dashboard(), 
      
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        primaryColor: Colors.green.shade900,

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade900,
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green.shade700,
          foregroundColor: Colors.white,
        ),

        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),     
    );
  }
}