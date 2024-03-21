import 'package:eisapp/network/ApiService.dart';
import 'package:flutter/material.dart';


class GetVfApproveSrpDetailsProvider extends ChangeNotifier {
  final _service = ApiService();
  bool isLoading = false;
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Future<void> getAllTodos() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.getVfPoApproveSrpDetailsCall();

    _todos = response;
    isLoading = false;
    notifyListeners();
  }
}