import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PedidoItensScreen extends StatelessWidget {
  final String pedidoId;
  const PedidoItensScreen({super.key, required this.pedidoId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Itens do Pedido: $pedidoId',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:
                () => GoRouter.of(
                  context,
                ).go('/pedidos/$pedidoId'), // Volta para detalhes do pedido
            child: const Text('Voltar para Detalhes do Pedido'),
          ),
        ],
      ),
    );
  }
}
