import 'package:flutter/material.dart';
import 'package:flutter_application_pizza/pizza/domain/pizza.dart';
import 'package:flutter_application_pizza/pizza/infrastructure/pizza_repository.dart';

class ListaPizzaProvider extends ChangeNotifier{
  final PizzaRepository repository = PizzaRepository();

  bool _isLoading = false;
  List<PizzaEntity> _pizzas = [];
  
  List<PizzaEntity> get pizzas => _pizzas;
  bool get isLoading => _isLoading;

  Future<void> fetchPizzas() async {
    _isLoading = true;
    notifyListeners();

    _pizzas = await repository.fetchPizzas();
    _isLoading = false;
    notifyListeners();
  }


}