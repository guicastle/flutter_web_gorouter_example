import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProdutoDetailScreen extends StatelessWidget {
  final String produtoId;
  const ProdutoDetailScreen({super.key, required this.produtoId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Detalhes do Produto: $produtoId',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:
                () => GoRouter.of(
                  context,
                ).go('/produtos'), // Volta para a lista de produtos
            child: const Text('Voltar para Produtos'),
          ),
        ],
      ),
    );
  }
}
