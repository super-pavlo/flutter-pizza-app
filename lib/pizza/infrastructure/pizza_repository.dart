import 'package:dio/dio.dart';
import 'package:flutter_application_pizza/pizza/domain/pizza.dart';
import 'package:flutter_application_pizza/pizza/infrastructure/models/pizza_model.dart';

class PizzaRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://172.20.146.210:3000';

  Future<List<PizzaEntity>> fetchPizzas() async {
    final response = await _dio.get('$_baseUrl/pizzas');
    final pizzas = response.data as List;
    return pizzas.map((json) => PizzaModel.fromJson(json)).toList();
  }

  Future<void> createPizza(PizzaModel pizza) async {
    await _dio.post('$_baseUrl/pizzas', data: pizza.toJson());
  }

  Future<void> updatePizza(PizzaModel pizza) async {
    await _dio.put('$_baseUrl/pizzas/${pizza.pizId}', data: pizza.toJson());
  }

  Future<void> deletePizza(int id) async {
    await _dio.delete('$_baseUrl/pizzas/$id');
  }
}
