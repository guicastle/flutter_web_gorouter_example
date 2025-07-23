import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp3());
}

// PÁGINAS
class PedidosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Página de Pedidos', style: TextStyle(fontSize: 24)),
    );
  }
}

class ProdutosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Página de Produtos', style: TextStyle(fontSize: 24)),
    );
  }
}

class ConfiguracoesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Página de Configurações', style: TextStyle(fontSize: 24)),
    );
  }
}

// MENU LATERAL FIXO
class FixedDrawer extends StatelessWidget {
  const FixedDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.toString();

    Widget menuItem(String title, String route) {
      final selected = currentRoute == route;
      return ListTile(
        selected: selected,
        title: Text(title),
        onTap: () => context.go(route),
      );
    }

    return Container(
      width: 240,
      color: Colors.blue.shade50,
      child: Column(
        children: [
          DrawerHeader(
            child: Text('Menu Fixo', style: TextStyle(fontSize: 20)),
          ),
          menuItem('Pedidos', '/pedidos'),
          menuItem('Produtos', '/produtos'),
          menuItem('Configurações', '/configuracoes'),
        ],
      ),
    );
  }
}

// LAYOUT BASE FIXO COM MENU
class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          FixedDrawer(), // Menu lateral fixo
          Expanded(child: child), // Conteúdo da rota atual
        ],
      ),
    );
  }
}

// ROTAS COM GoRouter
final GoRouter _router = GoRouter(
  initialLocation: '/pedidos',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(path: '/pedidos', builder: (context, state) => PedidosPage()),
        GoRoute(path: '/produtos', builder: (context, state) => ProdutosPage()),
        GoRoute(
          path: '/configuracoes',
          builder: (context, state) => ConfiguracoesPage(),
        ),
      ],
    ),
  ],
);

// APP
class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Drawer Fixo com GoRouter',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _router,
    );
  }
}
