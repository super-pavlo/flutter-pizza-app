import 'package:flutter/material.dart';
import 'package:flutter_application_pizza/my_app.dart';
import 'package:flutter_application_pizza/pizza/infrastructure/models/pizza_model.dart';
import 'package:flutter_application_pizza/pizza/presentation/providers/lista_pizza_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FormularioPizza extends StatefulWidget {
  FormularioPizza({super.key, this.pizza}) {
    _nameController.text = pizza != null ? pizza!.pizName : "";
    _originController.text = pizza != null ? pizza!.pizOrigin : "";
  }

  final PizzaModel? pizza;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _originController = TextEditingController();

  @override
  State<FormularioPizza> createState() => _FormularioPizzaState();
}

class _FormularioPizzaState extends State<FormularioPizza> {
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
              TextField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                controller: widget._nameController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Origen'),
                controller: widget._originController,
              ),
              ElevatedButton(
                onPressed: () {
                  if (widget.pizza == null) {
                    _crearPizza(context);
                  } else {
                    _editarPizza(context, widget.pizza!);
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _crearPizza(BuildContext context) {
    final provider = context.read<ListaPizzaProvider>();
    final pizza = PizzaModel(
      pizName: widget._nameController.text,
      pizOrigin: widget._originController.text,
    );
    provider.createPizza(pizza);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Creado con exito"),
      ),
    );
    context.pop();
  }

  Future<void> _editarPizza(BuildContext context, PizzaModel pizza) async {
    final provider = context.read<ListaPizzaProvider>();

    if (pizza.pizId != null) {
      final confirmar = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text("Confirmar"),
              content: const Text("¿Estás seguro de que deseas actualizar?"),
              actions: [
                TextButton(
                  onPressed: () {
                    context.pop(false);
                  },
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () {
                    context.pop(true);
                  },
                  child: const Text("Actualziar"),
                ),
              ],
            ),
          ) ??
          false;

      if (confirmar && context.mounted) {
        provider.updatePizza(PizzaModel(
          pizId: pizza.pizId,
          pizName: widget._nameController.text,
          pizOrigin: widget._originController.text,
        ));

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Actualziado con exito"),
          ),
        );

        context.pop();
      }
    }
  }
}
