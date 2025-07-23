import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp2());
}

// PÁGINAS SIMPLES
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

// LAYOUT PRINCIPAL COM DRAWER
class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App com Drawer e GoRouter')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Pedidos'),
              onTap: () {
                context.go('/pedidos');
                Navigator.pop(context); // Fecha o drawer
              },
            ),
            ListTile(
              title: Text('Produtos'),
              onTap: () {
                context.go('/produtos');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Configurações'),
              onTap: () {
                context.go('/configuracoes');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}

// CONFIGURAÇÃO DO GoRouter
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

// APP PRINCIPAL
class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Web Drawer com GoRouter',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _router,
    );
  }
}
