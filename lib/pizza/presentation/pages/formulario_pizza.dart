import 'package:flutter/material.dart';

class FormularioPizza extends StatelessWidget {
  const FormularioPizza({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Pizza'),
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              const TextField(
                decoration: InputDecoration(labelText: 'Origen'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
