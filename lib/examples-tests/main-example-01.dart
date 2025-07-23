import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp1());
}

// ---------------------------------------------------
// 1. Definição das Páginas de Conteúdo (StatelessWidgets)
//    Estas são as telas que serão exibidas ao lado do Drawer.
//    São StatelessWidget porque o GoRouter as reconstruirá quando a rota mudar.
// ---------------------------------------------------

class PedidosScreen extends StatelessWidget {
  const PedidosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Conteúdo da Página de Pedidos',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ProdutosScreen extends StatelessWidget {
  const ProdutosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Conteúdo da Página de Produtos',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ConfiguracoesScreen extends StatelessWidget {
  const ConfiguracoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Conteúdo da Página de Configurações',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// ---------------------------------------------------
// 2. O Shell Principal (Layout Persistente com Drawer)
//    Este widget é o "pai" que contém o Drawer e a área onde o conteúdo
//    das rotas filhas será exibido. Ele é um StatefulWidget para gerenciar
//    o estado do item selecionado no Drawer.
// ---------------------------------------------------

class MainShell extends StatefulWidget {
  // O 'child' é o widget da rota atual que o GoRouter injeta aqui.
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  // Estado local para controlar qual item do Drawer está selecionado.
  // Poderia ser gerenciado por um provedor de estado (Provider/Riverpod)
  // para aplicações maiores, mas para este exemplo, local é suficiente.
  int _selectedIndex = 0;

  // Método para atualizar o índice selecionado e navegar
  void _onItemTapped(BuildContext context, int index, String path) {
    setState(() {
      _selectedIndex = index;
    });
    // Usa GoRouter para navegar para a nova rota.
    // Isso atualiza a URL e troca o 'child' dentro do MainShell.
    GoRouter.of(context).go(path);
    // Fecha o Drawer após a seleção, se ele estiver aberto.
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha SPA Flutter Web'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      // O Drawer é parte do Scaffold e será persistente devido ao ShellRoute.
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Menu Principal',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Navegue pelas seções',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Pedidos'),
              selected: _selectedIndex == 0,
              onTap: () => _onItemTapped(context, 0, '/pedidos'),
              selectedTileColor: Colors.blue.withOpacity(0.1),
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Produtos'),
              selected: _selectedIndex == 1,
              onTap: () => _onItemTapped(context, 1, '/produtos'),
              selectedTileColor: Colors.blue.withOpacity(0.1),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              selected: _selectedIndex == 2,
              onTap: () => _onItemTapped(context, 2, '/configuracoes'),
              selectedTileColor: Colors.blue.withOpacity(0.1),
            ),
          ],
        ),
      ),
      // O corpo do Scaffold exibe o 'child' da rota atual.
      // O 'child' é o conteúdo da página (PedidosScreen, ProdutosScreen, etc.).
      body: widget.child,
    );
  }
}

// ---------------------------------------------------
// 3. Configuração do GoRouter
//    Define as rotas da aplicação, incluindo o ShellRoute.
// ---------------------------------------------------

final GoRouter _router = GoRouter(
  // A rota inicial quando a aplicação é carregada.
  initialLocation: '/pedidos',
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
        ),
        GoRoute(
          path: '/produtos',
          builder: (context, state) => const ProdutosScreen(),
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

// ---------------------------------------------------
// 4. O Widget Principal da Aplicação (MaterialApp.router)
//    Usa o GoRouter para gerenciar o roteamento.
// ---------------------------------------------------

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, // Remove o banner de debug
      title: 'Flutter SPA com Drawer Persistente',
      routerConfig: _router, // Conecta o GoRouter à aplicação
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // Usando a fonte Inter conforme instruído
      ),
    );
  }
}
