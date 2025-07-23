import 'package:flutter/material.dart';
import 'package:flutter_web_gorouter_example/features/configuracoes/configuracoes_screen.dart';
import 'package:flutter_web_gorouter_example/features/pedidos/pedido_screen.dart';
import 'package:flutter_web_gorouter_example/features/pedidos/pedido_detail_screen.dart';
import 'package:flutter_web_gorouter_example/features/pedidos/pedido_itens_screen.dart';
import 'package:flutter_web_gorouter_example/features/produtos/produto_detail_screen.dart';
import 'package:flutter_web_gorouter_example/features/produtos/produtos_screen.dart';
import 'package:flutter_web_gorouter_example/router/router_notifier.dart';
import 'package:flutter_web_gorouter_example/shell/main_shell.dart';
import 'package:go_router/go_router.dart';

final routerNotifier = RouterNotifier();

final GoRouter routes = GoRouter(
  // A rota inicial quando a aplicação é carregada.
  initialLocation: '/pedidos',
  refreshListenable: routerNotifier,
  routes: [
    // O ShellRoute é a chave para o layout persistente.
    ShellRoute(
      // O 'builder' constrói o widget que será o shell (nosso MainShell).
      // O 'child' passado para o MainShell é o conteúdo da rota filha atual.
      builder: (context, state, child) {
        return MainShell(child: child);
      },
      // As rotas 'children' são as rotas que serão exibidas dentro do shell.
      routes: [
        GoRoute(
          path: '/pedidos',
          builder: (context, state) => const PedidosScreen(),
          routes: [
            // Sub-rota para detalhes do pedido: /pedidos/:pedidoId
            GoRoute(
              path: ':pedidoId', // ':pedidoId' é um parâmetro de rota
              builder: (context, state) {
                // Acessa o parâmetro 'pedidoId' do caminho
                final pedidoId = state.pathParameters['pedidoId']!;
                return PedidoDetailScreen(
                  key: ValueKey(pedidoId),
                  pedidoId: pedidoId,
                );
              },
              routes: [
                // Sub-sub-rota para itens do pedido: /pedidos/:pedidoId/itens
                GoRoute(
                  path: 'itens',
                  builder: (context, state) {
                    // O parâmetro 'pedidoId' ainda está disponível
                    final pedidoId = state.pathParameters['pedidoId']!;
                    return PedidoItensScreen(
                      key: ValueKey(state.fullPath),
                      pedidoId: pedidoId,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/produtos',
          builder: (context, state) => const ProdutosScreen(),
          routes: [
            // Sub-rota para detalhes do produto: /produtos/:produtoId
            GoRoute(
              path: ':produtoId', // ':produtoId' é um parâmetro de rota
              builder: (context, state) {
                // Acessa o parâmetro 'produtoId' do caminho
                final produtoId = state.pathParameters['produtoId']!;
                return ProdutoDetailScreen(
                  key: ValueKey(state.fullPath),
                  produtoId: produtoId,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/configuracoes',
          builder: (context, state) => const ConfiguracoesScreen(),
        ),
      ],
    ),
  ],
  // Opcional: Configurar o tratamento de erros (página 404).
  errorBuilder:
      (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: Center(
          child: Text(
            'Página não encontrada: ${state.uri}',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
);
