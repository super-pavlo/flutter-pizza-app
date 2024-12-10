import 'package:flutter/material.dart';
import 'package:flutter_application_pizza/pizza/presentation/providers/lista_pizza_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ListaPizzasPage extends StatelessWidget {
  const ListaPizzasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ListaPizzaProvider()..fetchPizzas(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Pizzas'),
        ),
        body: _buildBody(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push('/pizza/create'),
          child: const Icon(Icons.add),
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
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {},
                ),
              ],
            ));
      },
    );
  }
}
