import 'package:flutter/material.dart';
import 'package:flutter_application_pizza/pizza/domain/pizza.dart';
import 'package:flutter_application_pizza/pizza/infrastructure/models/pizza_model.dart';
import 'package:flutter_application_pizza/pizza/infrastructure/pizza_repository.dart';

class ListaPizzaProvider extends ChangeNotifier{
  final PizzaRepository repository = PizzaRepository();

  bool _isLoading = false;
  List<PizzaModel> _pizzas = [];
  
  List<PizzaModel> get pizzas => _pizzas;
  bool get isLoading => _isLoading;

  Future<void> fetchPizzas() async {
    _isLoading = true;
    notifyListeners();

    _pizzas = await repository.fetchPizzas();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> createPizza(PizzaModel pizza) async {
    await repository.createPizza(pizza);
    await fetchPizzas();
  }

  Future<void> deletePizza(int id) async{
    await repository.deletePizza(id);
    await fetchPizzas();
  }

  Future<void> updatePizza(PizzaModel pizza) async{
    await repository.updatePizza(pizza);
    await fetchPizzas();
  }


}