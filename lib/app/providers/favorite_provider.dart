import 'package:flutter/material.dart';
import '../../data/models/property_model.dart';

class FavoriteProvider extends ChangeNotifier {
  // List of saved favorite properties
  final List<PropertyModel> _favorites = [];

  // Getter — read only
  List<PropertyModel> get favorites => _favorites;

  // Check if property is already saved
  bool isFavorite(PropertyModel property) {
    return _favorites.any((p) => p.name == property.name);
  }

  // Toggle — add or remove
  void toggleFavorite(PropertyModel property) {
    if (isFavorite(property)) {
      _favorites.removeWhere((p) => p.name == property.name);
    } else {
      _favorites.add(property);
    }
    notifyListeners(); // ← tell UI to rebuild
  }

  // Remove specific
  void removeFavorite(PropertyModel property) {
    _favorites.removeWhere((p) => p.name == property.name);
    notifyListeners();
  }

  // Clear all
  void clearAll() {
    _favorites.clear();
    notifyListeners();
  }

  // Total count
  int get count => _favorites.length;
}
