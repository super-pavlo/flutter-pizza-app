import 'package:flutter_application_pizza/pizza/domain/pizza.dart';

class PizzaModel extends PizzaEntity {
  PizzaModel({
    super.pizId,
    required super.pizName,
    required super.pizOrigin,
  });

  factory PizzaModel.fromJson(Map<String, dynamic> json) {
    return PizzaModel(
      pizId: json['piz_id'],
      pizName: json['piz_name'],
      pizOrigin: json['piz_origin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': pizId,
      'name': pizName,
      'origin': pizOrigin,
    };
  }
}
