import 'package:flutter/material.dart';

class RouterNotifier extends ChangeNotifier {
  // late final void Function(Duration) _observer;
  RouterNotifier() {
    // Sempre que houver mudança no histórico (inclusive botão "voltar"), notifica
    _locationStream = Uri.base.toString();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUriChange();
    });
  }

  String _locationStream = '';
  void _checkUriChange() {
    if (_locationStream != Uri.base.toString()) {
      _locationStream = Uri.base.toString();
      notifyListeners(); // 🔔 notifica o GoRouter
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkUriChange());
  }
}
