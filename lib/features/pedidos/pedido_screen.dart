import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PedidosScreen extends StatelessWidget {
  const PedidosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Lista de Pedidos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:
                () => GoRouter.of(
                  context,
                ).go('/pedidos/12345'), // Navega para um pedido específico
            child: const Text('Ver Detalhes do Pedido 12345'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => GoRouter.of(context).go('/pedidos/67890'),
            child: const Text('Ver Detalhes do Pedido 67890'),
          ),
        ],
      ),
    );
  }
}
