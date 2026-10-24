class ShopMockDataSource {
  Future<List<Map<String, dynamic>>> getCatalog() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {"id": "p1", "name": "Polera Oficial 2026", "price": 29990, "category": "Poleras", "iconName": "sports_soccer"},
      {"id": "p2", "name": "Polerón AzulPass", "price": 34990, "category": "Polerones", "iconName": "checkroom"},
      {"id": "p3", "name": "Bufanda de la U", "price": 12990, "category": "Accesorios", "iconName": "scarf"}, // Usaremos un icono fallback
      {"id": "p4", "name": "Gorro Tricota", "price": 9990, "category": "Accesorios", "iconName": "winter_sports"},
      {"id": "p5", "name": "Polera Entrenamiento", "price": 19990, "category": "Poleras", "iconName": "fitness_center"},
      {"id": "p6", "name": "Mochila Oficial", "price": 24990, "category": "Accesorios", "iconName": "backpack"},
    ];
  }
}