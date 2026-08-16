import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Biblioteca')),
      body: const Center(
        child: Text('Historias Guardadas y Descargadas'),
      ),
    );
  }
}