import 'package:flutter/material.dart';
import 'package:flutter_application_pizza/pizza/presentation/pages/formulario_pizza.dart';
import 'package:flutter_application_pizza/pizza/presentation/providers/lista_pizza_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ListaPizzasPage extends StatelessWidget {
  const ListaPizzasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ListaPizzaProvider()..fetchPizzas(),
      builder: (context, _) => Consumer<ListaPizzaProvider>(
        builder: (context, provider, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Lista de Pizzas'),
          ),
          body: _buildBody(context),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListenableProvider.value(
                    value: provider,
                    child: FormularioPizza(),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final provider = context.watch<ListaPizzaProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: provider.pizzas.length,
      itemBuilder: (context, index) {
        final pizza = provider.pizzas[index];
        return ListTile(
            title: Text(pizza.pizName),
            subtitle: Text(pizza.pizOrigin),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListenableProvider.value(
                          value: provider,
                          child: FormularioPizza(pizza: pizza),
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    if (pizza.pizId != null) {
                      final confirmar = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Confirmar"),
                              content: const Text(
                                  "¿Estás seguro de que deseas eliminar?"),
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
                                  child: const Text("Eliminar"),
                                ),
                              ],
                            ),
                          ) ??
                          false;

                      if (confirmar && context.mounted) {
                        provider.deletePizza(pizza.pizId!);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Eliminado con exito"),
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ));
      },
    );
  }
}
