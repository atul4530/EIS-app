
import 'package:flutter/material.dart';

import '../network/ApiService.dart';

class VersionCheckProvider extends ChangeNotifier {
  final _service = ApiService();
  bool isLoading = false;
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Future<void> getAllTodos() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.versionCheckCall();

    _todos = response;
    isLoading = false;
    notifyListeners();
  }
}