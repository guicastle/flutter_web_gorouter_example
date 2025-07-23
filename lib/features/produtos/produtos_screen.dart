import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProdutosScreen extends StatelessWidget {
  const ProdutosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Lista de Produtos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed:
                () => GoRouter.of(
                  context,
                ).go('/produtos/ABC001'), // Navega para um produto específico
            child: const Text('Ver Detalhes do Produto ABC001'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => GoRouter.of(context).go('/produtos/XYZ999'),
            child: const Text('Ver Detalhes do Produto XYZ999'),
          ),
        ],
      ),
    );
  }
}
