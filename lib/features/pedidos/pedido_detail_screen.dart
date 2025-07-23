import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PedidoDetailScreen extends StatelessWidget {
  final String pedidoId;
  const PedidoDetailScreen({super.key, required this.pedidoId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Detalhes do Pedido: $pedidoId',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:
                () => GoRouter.of(
                  context,
                ).go('/pedidos'), // Volta para a lista de pedidos
            child: const Text('Voltar para Pedidos'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed:
                () => GoRouter.of(
                  context,
                ).go('/pedidos/$pedidoId/itens'), // Navega para sub-sub-rota
            child: const Text('Ver Itens do Pedido'),
          ),
        ],
      ),
    );
  }
}
